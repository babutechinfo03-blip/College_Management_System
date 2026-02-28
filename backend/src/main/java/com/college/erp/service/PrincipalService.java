package com.college.erp.service;

import com.college.erp.entity.AcademicControl;
import com.college.erp.entity.Department;
import com.college.erp.entity.Faculty;
import com.college.erp.entity.Role;
import com.college.erp.entity.RoleType;
import com.college.erp.entity.StaffRole;
import com.college.erp.entity.User;
import com.college.erp.repository.AcademicControlRepository;
import com.college.erp.repository.AssistantStaffRepository;
import com.college.erp.repository.DepartmentRepository;
import com.college.erp.repository.FacultyRepository;
import com.college.erp.repository.StudentRepository;
import com.college.erp.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PrincipalService {

    private final UserRepository userRepository;
    private final StudentRepository studentRepository;
    private final FacultyRepository facultyRepository;
    private final AcademicControlRepository academicControlRepository;
    private final DepartmentRepository departmentRepository;
    private final AssistantStaffRepository assistantStaffRepository;
    private final PasswordEncoder passwordEncoder;

    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();

        long totalStudents = studentRepository.countByIsActiveTrue();
        long totalFaculty = facultyRepository.countByIsActiveTrue();
        long officeCount = userRepository.countByRoleAndActive(Role.OFFICE, true);

        stats.put("totalStudents", totalStudents);
        stats.put("totalFaculty", totalFaculty);
        stats.put("totalOfficeStaff", officeCount);

        stats.put("avgAttendance", 85.5);

        return stats;
    }

    public List<User> getAllOfficeUsers() {
        return userRepository.findByRole(Role.OFFICE);
    }

    @Transactional
    public User createOfficeUser(User user) {
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email already exists");
        }
        user.setRole(Role.OFFICE);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setCreatedAt(LocalDateTime.now());
        user.setActive(true);
        return userRepository.save(user);
    }

    @Transactional
    public void toggleUserActiveStatus(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        user.setActive(!user.isActive());
        userRepository.save(user);
    }

    public AcademicControl getAcademicControl(String academicYear, String semester) {
        return academicControlRepository.findByAcademicYearAndSemester(academicYear, semester)
                .orElse(AcademicControl.builder()
                        .academicYear(academicYear)
                        .semester(semester)
                        .attendanceFrozen(false)
                        .marksFrozen(false)
                        .timetableFrozen(false)
                        .build());
    }

    @Transactional
    public AcademicControl updateAcademicControl(AcademicControl control) {
        Optional<AcademicControl> existing = academicControlRepository
                .findByAcademicYearAndSemester(control.getAcademicYear(), control.getSemester());

        if (existing.isPresent()) {
            AcademicControl dbControl = existing.get();
            dbControl.setAttendanceFrozen(control.isAttendanceFrozen());
            dbControl.setMarksFrozen(control.isMarksFrozen());
            dbControl.setTimetableFrozen(control.isTimetableFrozen());
            return academicControlRepository.save(dbControl);
        } else {
            return academicControlRepository.save(control);
        }
    }

    // Department Management with Rich Stats
    public List<Map<String, Object>> getDepartmentsWithHod() {
        return departmentRepository.findAll().stream().map(dept -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", dept.getId());
            map.put("name", dept.getName());
            map.put("code", dept.getCode());
            map.put("type", dept.getType());

            // Rich Stats
            map.put("totalStudents", studentRepository.countByDegree_Department_IdAndIsActiveTrue(dept.getId()));
            map.put("totalFaculty", facultyRepository.countByDepartmentId(dept.getId()));
            map.put("totalStaff", assistantStaffRepository.countByDepartment_IdAndIsActiveTrue(dept.getId()));

            // Find HOD for this department
            Optional<Faculty> hod = facultyRepository.findByRole(RoleType.HOD).stream()
                    .filter(f -> f.getDepartment() != null && f.getDepartment().getId().equals(dept.getId()))
                    .findFirst();

            if (hod.isPresent()) {
                Faculty h = hod.get();
                map.put("hodName", h.getFirstName() + " " + (h.getLastName() != null ? h.getLastName() : ""));
                map.put("hodId", h.getId());
            } else {
                map.put("hodName", "Not Assigned");
                map.put("hodId", null);
            }
            return map;
        }).collect(Collectors.toList());
    }

    @Transactional
    public void assignHod(Long departmentId, Long facultyId) {
        Department dept = departmentRepository.findById(departmentId)
                .orElseThrow(() -> new RuntimeException("Department not found"));
        Faculty newHod = facultyRepository.findById(facultyId)
                .orElseThrow(() -> new RuntimeException("Faculty not found"));

        if (!newHod.getDepartment().getId().equals(departmentId)) {
            throw new RuntimeException("Faculty does not belong to this department");
        }

        // Remove HOD role from existing HOD of this department
        List<Faculty> existingHods = facultyRepository.findByRole(RoleType.HOD).stream()
                .filter(f -> f.getDepartment() != null && f.getDepartment().getId().equals(departmentId))
                .toList();

        for (Faculty f : existingHods) {
            f.getRoles().removeIf(r -> r.getRole() == RoleType.HOD);
            facultyRepository.save(f);

            // Revert User Role if they were HOD
            User oldUser = f.getUser();
            if (oldUser.getRole() == Role.HOD) {
                oldUser.setRole(Role.FACULTY); // Default back to Faculty
                userRepository.save(oldUser);
            }
        }

        // Assign HOD role to new faculty
        boolean alreadyHod = newHod.getRoles().stream().anyMatch(r -> r.getRole() == RoleType.HOD);
        if (!alreadyHod) {
            StaffRole hodRole = StaffRole.builder()
                    .faculty(newHod)
                    .role(RoleType.HOD)
                    .build();
            newHod.getRoles().add(hodRole);
            facultyRepository.save(newHod);
        }

        // Update User entity role for login purposes
        User user = newHod.getUser();
        if (user.getRole() != Role.HOD) {
            user.setRole(Role.HOD);
            userRepository.save(user);
        }
    }
}
