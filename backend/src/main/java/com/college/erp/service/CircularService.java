package com.college.erp.service;

import com.college.erp.entity.Department;
import com.college.erp.entity.Faculty;
import com.college.erp.entity.Section;
import com.college.erp.entity.Student;
import com.college.erp.entity.User;
import com.college.erp.entity.circular.Circular;
import com.college.erp.entity.circular.CircularRead;
import com.college.erp.entity.circular.CircularTarget;
import com.college.erp.entity.circular.enums.CircularStatus;
import com.college.erp.entity.circular.enums.CircularTargetRole;
import com.college.erp.repository.CircularReadRepository;
import com.college.erp.repository.CircularRepository;
import com.college.erp.repository.DepartmentRepository;
import com.college.erp.repository.FacultyRepository;
import com.college.erp.repository.SectionRepository;
import com.college.erp.repository.StudentRepository;
import com.college.erp.repository.UserRepository;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Predicate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class CircularService {

    @Autowired
    private CircularRepository circularRepository;

    @Autowired
    private CircularReadRepository readRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private FacultyRepository facultyRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private DepartmentRepository departmentRepository;

    @Autowired
    private SectionRepository sectionRepository;

    @Transactional
    public Circular createCircular(Circular circular, List<CircularTarget> targets, Long creatorId,
            MultipartFile file) {
        User creator = userRepository.findById(creatorId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        circular.setCreatedBy(creator);

        // Auto-approve logic
        if (circular.getCreatedRole().equals("PRINCIPAL") || circular.getCreatedRole().equals("OFFICE")) {
            circular.setStatus(CircularStatus.APPROVED);
            circular.setApprovedBy(creator);
            circular.setApprovedAt(LocalDateTime.now());
        } else if (circular.getCreatedRole().equals("HOD")) {
            circular.setStatus(CircularStatus.APPROVED);
            circular.setApprovedBy(creator);
            circular.setApprovedAt(LocalDateTime.now());
        } else {
            // Faculty needs approval
            circular.setStatus(CircularStatus.PENDING_APPROVAL);
        }

        // Handle file upload (mock for now, assume saved and URL returned)
        if (file != null && !file.isEmpty()) {
            // String fileUrl = fileStorageService.store(file);
            // circular.setAttachmentUrl(fileUrl);
        }

        Circular saved = circularRepository.save(circular);

        for (CircularTarget target : targets) {
            target.setCircular(saved);
        }
        saved.getTargets().addAll(targets);

        return circularRepository.save(saved);
    }

    public List<Circular> getCircularFeedForUser(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // Determine user context attributes
        CircularTargetRole targetRole = CircularTargetRole.ALL;
        Long deptId = null;
        Integer year = null;
        Integer sem = null;
        Long sectionId = null;

        if (user.getRole() == com.college.erp.entity.Role.STUDENT) {
            targetRole = CircularTargetRole.STUDENT;
            Student s = studentRepository.findByUser(user).orElse(null);
            if (s != null) {
                if (s.getDegree() != null && s.getDegree().getDepartment() != null) {
                    deptId = s.getDegree().getDepartment().getId();
                }
                year = s.getCurrentYear();
                sem = s.getCurrentSemester();
                // Student schema doesn't have direct section linkage
            }
        } else {
            Faculty f = facultyRepository.findByUser(user).orElse(null);
            if (f != null && f.getDepartment() != null) {
                deptId = f.getDepartment().getId();
            }

            boolean isHod = false;
            boolean isAdvisor = false;
            if (f != null && f.getRoles() != null) {
                isHod = f.getRoles().stream().anyMatch(r -> r.getRole().name().equals("HOD"));
                isAdvisor = f.getRoles().stream().anyMatch(r -> r.getRole().name().equals("CLASS_ADVISOR"));
            }

            if (user.getRole() == com.college.erp.entity.Role.HOD || isHod) {
                targetRole = CircularTargetRole.HOD;
            } else if (user.getRole() == com.college.erp.entity.Role.ADVISOR || isAdvisor) {
                targetRole = CircularTargetRole.CLASS_ADVISOR;
            } else if (user.getRole() == com.college.erp.entity.Role.OFFICE) {
                targetRole = CircularTargetRole.OFFICE;
            } else {
                targetRole = CircularTargetRole.FACULTY; // Standard faculty
            }
        }

        return findTargetedCirculars(targetRole, deptId, year, sem, sectionId);
    }

    private List<Circular> findTargetedCirculars(CircularTargetRole ur, Long dId, Integer y, Integer s, Long secId) {
        Specification<Circular> spec = (root, query, cb) -> {
            query.distinct(true);
            Join<Circular, CircularTarget> targets = root.join("targets");

            Predicate isActive = cb.isTrue(root.get("isActive"));
            Predicate isApproved = cb.equal(root.get("status"), CircularStatus.APPROVED);

            // Allow active, or scheduled where scheduledAt <= now
            Predicate scheduledStart = cb.or(
                    cb.isNull(root.get("scheduledAt")),
                    cb.lessThanOrEqualTo(root.get("scheduledAt"), LocalDateTime.now()));

            // Allow not expired, where expiryAt > now
            Predicate scheduledEnd = cb.or(
                    cb.isNull(root.get("expiryAt")),
                    cb.greaterThan(root.get("expiryAt"), LocalDateTime.now()));

            // Target matching checks
            // 1. Role matches (ur or ALL)
            Predicate roleMatch = cb.or(
                    cb.equal(targets.get("targetRole"), CircularTargetRole.ALL),
                    cb.equal(targets.get("targetRole"), ur));

            // 2. Dept matches (dId or null)
            Predicate deptMatch = cb.or(
                    cb.isNull(targets.get("department")),
                    cb.equal(targets.get("department").get("id"), dId));

            // 3. Year matches (y or null)
            Predicate yearMatch = cb.or(
                    cb.isNull(targets.get("year")),
                    cb.equal(targets.get("year"), y));

            // 4. Semester matches (s or null)
            Predicate semMatch = cb.or(
                    cb.isNull(targets.get("semester")),
                    cb.equal(targets.get("semester"), s));

            // 5. Section matches (secId or null)
            Predicate secMatch = cb.or(
                    cb.isNull(targets.get("section")),
                    cb.equal(targets.get("section").get("id"), secId));

            return cb.and(isActive, isApproved, scheduledStart, scheduledEnd, roleMatch, deptMatch, yearMatch, semMatch,
                    secMatch);
        };

        return circularRepository.findAll(spec);
    }

    @Transactional
    public CircularRead markAsRead(Long circularId, Long userId) {
        CircularRead cr = readRepository.findByCircularIdAndUserId(circularId, userId)
                .orElseGet(() -> {
                    CircularRead newCr = new CircularRead();
                    Circular c = circularRepository.findById(circularId).orElseThrow();
                    User u = userRepository.findById(userId).orElseThrow();
                    newCr.setCircular(c);
                    newCr.setUser(u);
                    return newCr;
                });

        if (!cr.isViewed()) {
            cr.setViewed(true);
            cr.setViewedAt(LocalDateTime.now());
        }
        return readRepository.save(cr);
    }

    @Transactional
    public CircularRead acknowledge(Long circularId, Long userId) {
        CircularRead cr = markAsRead(circularId, userId);
        if (!cr.isAcknowledged()) {
            cr.setAcknowledged(true);
            cr.setAcknowledgedAt(LocalDateTime.now());
        }
        return readRepository.save(cr);
    }

    public List<Circular> getPendingApprovalsForHod(Long departmentId) {
        return circularRepository.findPendingValidationsForHod(departmentId);
    }

    @Transactional
    public Circular approveCircular(Long circularId, Long hodId, boolean approve) {
        Circular c = circularRepository.findById(circularId).orElseThrow();
        User hod = userRepository.findById(hodId).orElseThrow();

        if (approve) {
            c.setStatus(CircularStatus.APPROVED);
            c.setApprovedBy(hod);
            c.setApprovedAt(LocalDateTime.now());
        } else {
            c.setStatus(CircularStatus.REJECTED);
        }
        return circularRepository.save(c);
    }

    @Transactional
    public void deleteCircular(Long circularId) {
        Circular c = circularRepository.findById(circularId).orElseThrow();
        c.setActive(false);
        circularRepository.save(c);
    }
}
