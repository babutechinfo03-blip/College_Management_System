package com.college.erp.controller;

import com.college.erp.entity.*;
import com.college.erp.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/hod")
@PreAuthorize("hasRole('HOD')")
public class HODController {

    @Autowired
    private FacultyRepository facultyRepository;

    @Autowired
    private TeachingAssignmentRepository teachingAssignmentRepository;

    @Autowired
    private TimetableRepository timetableRepository;

    @Autowired
    private DepartmentRepository departmentRepository;

    @Autowired
    private SectionRepository sectionRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TimetableApprovalRepository timetableApprovalRepository;

    // Helper to validate HOD context
    private Faculty getHODContext() {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userRepository.findByUsername(username).orElseThrow();
        return facultyRepository.findByUser(user).orElseThrow();
        // Additional check: valid if user.roles contains HOD - done by PreAuthorize,
        // but dept check is needed for granular access in production (HOD of CSE
        // shouldn't edit IT).
    }

    // ==========================================
    // 1. SUBJECT ASSIGNMENT (TeachingAssignment)
    // ==========================================

    @PostMapping("/assign-subject")
    public ResponseEntity<?> assignSubject(@RequestBody Map<String, Object> request) {
        try {
            Long facultyId = Long.valueOf(request.get("facultyId").toString());
            Long deptId = Long.valueOf(request.get("departmentId").toString());
            Integer year = Integer.valueOf(request.get("year").toString());
            Integer semester = Integer.valueOf(request.get("semester").toString());
            String subjectName = (String) request.get("subjectName");
            String subjectCode = (String) request.get("subjectCode");

            Faculty faculty = facultyRepository.findById(facultyId)
                    .orElseThrow(() -> new RuntimeException("Faculty not found"));
            Department dept = departmentRepository.findById(deptId)
                    .orElseThrow(() -> new RuntimeException("Department not found"));

            TeachingAssignment assignment = new TeachingAssignment();
            assignment.setFaculty(faculty);
            assignment.setDepartment(dept);
            assignment.setYear(year);
            assignment.setSemester(semester);
            assignment.setSubjectName(subjectName);
            assignment.setSubjectCode(subjectCode);

            // Cross-Department Approval Logic
            Faculty hod = getHODContext();
            assignment.setAssignedByHodId(hod.getId());
            assignment.setRequestingDepartmentId(dept.getId());

            if (faculty.getDepartment() != null) {
                assignment.setFacultyDepartmentId(faculty.getDepartment().getId());
                if (!faculty.getDepartment().getId().equals(dept.getId())) {
                    assignment.setApprovalStatus(ApprovalStatus.PENDING);
                } else {
                    assignment.setApprovalStatus(ApprovalStatus.APPROVED);
                    assignment.setApprovedByHodId(hod.getId());
                    assignment.setApprovedAt(java.time.LocalDateTime.now());
                }
            } else {
                assignment.setApprovalStatus(ApprovalStatus.APPROVED);
            }

            teachingAssignmentRepository.save(assignment);

            String msg = assignment.getApprovalStatus() == ApprovalStatus.PENDING
                    ? "Subject assigned but PENDING approval from " + faculty.getDepartment().getCode() + " HOD"
                    : "Subject assigned successfully";
            return ResponseEntity.ok(Map.of("message", msg));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @GetMapping("/assignments")
    public ResponseEntity<?> getDeptAssignments() {
        Faculty hod = getHODContext();
        if (hod.getDepartment() == null)
            return ResponseEntity.badRequest().body("HOD has no department assigned");

        List<TeachingAssignment> assignments = teachingAssignmentRepository
                .findByDepartmentId(hod.getDepartment().getId());
        return ResponseEntity.ok(assignments.stream().map(a -> {
            Map<String, Object> m = new java.util.LinkedHashMap<>();
            m.put("id", a.getId());
            m.put("facultyName", a.getFaculty().getFirstName() + " "
                    + (a.getFaculty().getLastName() != null ? a.getFaculty().getLastName() : ""));
            m.put("facultyDept",
                    a.getFaculty().getDepartment() != null ? a.getFaculty().getDepartment().getCode() : "-");
            m.put("subject", a.getSubjectName() + " (" + a.getSubjectCode() + ")");
            m.put("subjectName", a.getSubjectName());
            m.put("subjectCode", a.getSubjectCode());
            m.put("year", a.getYear());
            m.put("semester", a.getSemester());
            m.put("class", "Year " + a.getYear() + " — Sem " + a.getSemester());
            m.put("sectionId", a.getSection() != null ? a.getSection().getId() : null);
            m.put("sectionName", a.getSection() != null ? a.getSection().getName() : "All");
            m.put("status", a.getApprovalStatus() != null ? a.getApprovalStatus().name() : "APPROVED");
            return m;
        }).collect(Collectors.toList()));
    }

    // ==========================================
    // 1A. CROSS-DEPT APPROVALS
    // ==========================================

    @GetMapping("/cross-dept-requests")
    public ResponseEntity<?> getCrossDeptRequests() {
        Faculty hod = getHODContext();
        if (hod.getDepartment() == null)
            return ResponseEntity.badRequest().body("HOD has no department assigned");

        List<TeachingAssignment> pending = teachingAssignmentRepository
                .findByFacultyDepartmentIdAndApprovalStatus(hod.getDepartment().getId(), ApprovalStatus.PENDING);

        return ResponseEntity.ok(pending.stream().map(a -> {
            Map<String, Object> m = new java.util.LinkedHashMap<>();
            m.put("id", a.getId());
            m.put("facultyName", a.getFaculty().getFirstName() + " "
                    + (a.getFaculty().getLastName() != null ? a.getFaculty().getLastName() : ""));
            m.put("subject", a.getSubjectName() + " (" + a.getSubjectCode() + ")");
            m.put("requestingDept", a.getDepartment().getCode());
            m.put("classInfo", "Year " + a.getYear() + " — Sem " + a.getSemester());
            m.put("hours", 4); // Placeholder

            // Lookup assigned By HOD Name
            if (a.getAssignedByHodId() != null) {
                facultyRepository.findById(a.getAssignedByHodId()).ifPresent(h -> m.put("assignedBy",
                        h.getFirstName() + " " + (h.getLastName() != null ? h.getLastName() : "")));
            }
            return m;
        }).collect(Collectors.toList()));
    }

    @PostMapping("/assignments/{id}/approve")
    public ResponseEntity<?> approveAssignment(@PathVariable Long id, @RequestBody Map<String, Object> req) {
        try {
            Faculty hod = getHODContext();
            TeachingAssignment assignment = teachingAssignmentRepository.findById(id).orElseThrow();

            if (!assignment.getFacultyDepartmentId().equals(hod.getDepartment().getId())) {
                return ResponseEntity.status(403).body(Map.of("error", "Only target department HOD can approve"));
            }

            boolean approve = (boolean) req.getOrDefault("approve", true);
            assignment.setApprovalStatus(approve ? ApprovalStatus.APPROVED : ApprovalStatus.REJECTED);
            assignment.setApprovedByHodId(hod.getId());
            assignment.setApprovedAt(java.time.LocalDateTime.now());

            teachingAssignmentRepository.save(assignment);

            return ResponseEntity.ok(Map.of("message", "Assignment " + (approve ? "approved" : "rejected")));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @DeleteMapping("/assignments/{id}")
    public ResponseEntity<?> deleteAssignment(@PathVariable Long id) {
        try {
            teachingAssignmentRepository.deleteById(id);
            return ResponseEntity.ok(Map.of("message", "Assignment deleted"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    // ==========================================
    // 2. TIMETABLE SCHEDULER
    // ==========================================

    @PostMapping("/timetable/entry")
    public ResponseEntity<?> addTimetableEntry(@RequestBody Map<String, Object> request) {
        try {
            Long deptId = Long.valueOf(request.get("departmentId").toString());
            Integer year = Integer.valueOf(request.get("year").toString());
            Integer semester = Integer.valueOf(request.get("semester").toString());
            Long sectionId = Long.valueOf(request.get("sectionId").toString());
            String day = (String) request.get("dayOfWeek");
            Integer hour = Integer.valueOf(request.get("hour").toString());
            String subject = (String) request.get("subjectName");
            String subjectCode = (String) request.get("subjectCode");
            Long facultyId = Long.valueOf(request.get("facultyId").toString());

            // 0. Check Lock Status
            Faculty hod = getHODContext();
            Optional<TimetableApproval> approvalOpt = timetableApprovalRepository
                    .findByDepartmentIdAndAcademicYearAndSemester(deptId, "2023-2024", String.valueOf(semester)); // Hardcoding
                                                                                                                  // academicYear
                                                                                                                  // for
                                                                                                                  // now
                                                                                                                  // as
                                                                                                                  // it's
                                                                                                                  // not
                                                                                                                  // in
                                                                                                                  // the
                                                                                                                  // request
                                                                                                                  // payload
                                                                                                                  // typically
            if (approvalOpt.isPresent() && approvalOpt.get().getStatus() == TimetableApproval.ApprovalStatus.APPROVED) {
                return ResponseEntity.status(403).body(
                        Map.of("error", "Timetable is locked and approved by Principal. Contact Principal to unlock."));
            }

            // 1. Clash Detection
            boolean classClash = timetableRepository.existsByDayOfWeekAndHourAndDepartmentIdAndYearAndSectionId(
                    day, hour, deptId, year, sectionId);
            if (classClash)
                return ResponseEntity.status(409).body(Map.of("error", "Class already has a session at this time"));

            boolean facultyClash = timetableRepository.existsByDayOfWeekAndHourAndFacultyId(day, hour, facultyId);
            if (facultyClash)
                return ResponseEntity.status(409)
                        .body(Map.of("error", "Faculty is already teaching elsewhere at this time"));

            // 2. Persist
            TimetableEntry entry = new TimetableEntry();
            entry.setDepartment(departmentRepository.findById(deptId).orElseThrow());
            entry.setYear(year);
            entry.setSemester(semester);
            entry.setSection(sectionRepository.findById(sectionId).orElseThrow());
            entry.setDayOfWeek(day);
            entry.setHour(hour);
            entry.setSubjectName(subject);
            entry.setSubjectCode(subjectCode);
            entry.setFaculty(facultyRepository.findById(facultyId).orElseThrow());

            timetableRepository.save(entry);

            return ResponseEntity.ok(Map.of("message", "Timetable entry added"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @GetMapping("/timetable")
    public ResponseEntity<?> getTimetable(
            @RequestParam Long departmentId,
            @RequestParam Integer year,
            @RequestParam Long sectionId) {
        List<TimetableEntry> entries = timetableRepository.findByDepartmentIdAndYearAndSectionId(departmentId, year,
                sectionId);
        return ResponseEntity.ok(entries.stream().map(e -> {
            Map<String, Object> m = new java.util.LinkedHashMap<>();
            m.put("id", e.getId());
            m.put("dayOfWeek", e.getDayOfWeek());
            m.put("hour", e.getHour());
            m.put("subjectName", e.getSubjectName());
            m.put("subjectCode", e.getSubjectCode());
            m.put("type", e.getType() != null ? e.getType() : "LECTURE");
            m.put("facultyId", e.getFaculty() != null ? e.getFaculty().getId() : null);
            m.put("facultyName", e.getFaculty() != null
                    ? e.getFaculty().getFirstName() + " "
                            + (e.getFaculty().getLastName() != null ? e.getFaculty().getLastName() : "")
                    : "");
            m.put("semester", e.getSemester());
            return m;
        }).collect(Collectors.toList()));
    }

    @DeleteMapping("/timetable/entry/{id}")
    public ResponseEntity<?> deleteTimetableEntry(@PathVariable Long id) {
        try {
            TimetableEntry entry = timetableRepository.findById(id).orElseThrow();

            // 0. Check Lock Status
            Optional<TimetableApproval> approvalOpt = timetableApprovalRepository
                    .findByDepartmentIdAndAcademicYearAndSemester(entry.getDepartment().getId(), "2023-2024",
                            String.valueOf(entry.getSemester()));
            if (approvalOpt.isPresent() && approvalOpt.get().getStatus() == TimetableApproval.ApprovalStatus.APPROVED) {
                return ResponseEntity.status(403).body(
                        Map.of("error", "Timetable is locked and approved by Principal. Contact Principal to unlock."));
            }

            timetableRepository.delete(entry);
            return ResponseEntity.ok(Map.of("message", "Entry deleted"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PostMapping("/timetable/submit")
    public ResponseEntity<?> submitTimetableForApproval(@RequestBody Map<String, Object> request) {
        try {
            String academicYear = (String) request.get("academicYear");
            String semester = (String) request.get("semester");
            Faculty hod = getHODContext();

            if (hod.getDepartment() == null) {
                return ResponseEntity.badRequest().body(Map.of("error", "HOD has no department assigned"));
            }

            TimetableApproval approval = timetableApprovalRepository
                    .findByDepartmentIdAndAcademicYearAndSemester(hod.getDepartment().getId(), academicYear, semester)
                    .orElse(TimetableApproval.builder()
                            .department(hod.getDepartment())
                            .academicYear(academicYear)
                            .semester(semester)
                            .build());

            approval.setStatus(TimetableApproval.ApprovalStatus.SUBMITTED);
            approval.setSubmittedAt(java.time.LocalDateTime.now());
            timetableApprovalRepository.save(approval);

            return ResponseEntity.ok(Map.of("message", "Timetable submitted to Principal for Approval"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @Autowired
    private MarkEntryRepository markEntryRepository;

    @PostMapping("/marks/approve")
    public ResponseEntity<?> approveMarks(@RequestBody Map<String, Object> request) {
        try {
            Long entryId = Long.valueOf(request.get("entryId").toString());
            String action = (String) request.get("action"); // VERIFY (Advisor) or APPROVE (HOD)

            MarkEntry entry = markEntryRepository.findById(entryId).orElseThrow();

            if ("VERIFY".equals(action)) {
                entry.setStatus(MarkEntry.MarkStatus.VERIFIED);
            } else if ("APPROVE".equals(action)) {
                entry.setStatus(MarkEntry.MarkStatus.APPROVED);
                entry.setApprovedBy(getHODContext());
                entry.setApprovedAt(java.time.LocalDateTime.now());
            }

            markEntryRepository.save(entry);
            return ResponseEntity.ok(Map.of("message", "Status Updated to " + entry.getStatus()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private InternalMarkRepository internalMarkRepository;

    @GetMapping("/students/stats")
    public ResponseEntity<?> getStudentStats() {
        Faculty hod = getHODContext();
        if (hod.getDepartment() == null)
            return ResponseEntity.badRequest().body("HOD has no department");

        Long deptId = hod.getDepartment().getId();
        long total = studentRepository.countByDegreeDepartmentId(deptId);
        long active = studentRepository.countByDegree_Department_IdAndIsActiveTrue(deptId);
        long inactive = total - active;

        // Defaulters: students whose avg internal mark is < 40% of maxMarks
        List<com.college.erp.entity.Student> allStudents = studentRepository.findByDegreeDepartmentId(deptId);
        long defaulters = allStudents.stream().filter(s -> {
            List<com.college.erp.entity.InternalMark> marks = internalMarkRepository.findByStudentId(s.getId());
            if (marks.isEmpty())
                return false;
            double avg = marks.stream().filter(m -> m.getMaxMarks() != null && m.getMaxMarks() > 0)
                    .mapToDouble(m -> (double) m.getMarks() / m.getMaxMarks() * 100).average().orElse(100);
            return avg < 40;
        }).count();

        return ResponseEntity.ok(Map.of(
                "total", total,
                "active", active,
                "inactive", inactive,
                "defaulters", defaulters));
    }

    @GetMapping("/students")
    public ResponseEntity<?> getAllStudents() {
        Faculty hod = getHODContext();
        if (hod.getDepartment() == null)
            return ResponseEntity.badRequest().body("HOD has no department");

        List<Student> students = studentRepository.findByDegreeDepartmentId(hod.getDepartment().getId());

        return ResponseEntity.ok(students.stream().map(s -> {
            Map<String, Object> row = new java.util.LinkedHashMap<>();
            row.put("id", s.getId());
            row.put("studentId", s.getStudentId());
            row.put("name", s.getFirstName() + " " + (s.getLastName() != null ? s.getLastName() : ""));
            row.put("year", s.getCurrentYear());
            row.put("semester", s.getCurrentSemester());
            row.put("degree", s.getDegree() != null ? s.getDegree().getCode() : "N/A");
            row.put("active", s.isActive());
            row.put("batch", s.getBatch() != null ? s.getBatch() : "-");
            // Compute performance tag
            List<com.college.erp.entity.InternalMark> marks = internalMarkRepository.findByStudentId(s.getId());
            double avgPct = marks.stream().filter(m -> m.getMaxMarks() != null && m.getMaxMarks() > 0)
                    .mapToDouble(m -> (double) m.getMarks() / m.getMaxMarks() * 100).average().orElse(-1);
            String perfTag = avgPct < 0 ? "N/A" : avgPct >= 75 ? "HIGH" : avgPct >= 50 ? "AVERAGE" : "AT_RISK";
            row.put("performanceTag", perfTag);
            row.put("avgMarkPct", avgPct < 0 ? null : Math.round(avgPct));
            return row;
        }).collect(Collectors.toList()));
    }

    @GetMapping("/students/{id}")
    public ResponseEntity<?> getStudentDetail(@PathVariable Long id) {
        Faculty hod = getHODContext();
        if (hod.getDepartment() == null)
            return ResponseEntity.badRequest().body("HOD has no department");

        Student s = studentRepository.findById(id)
                .orElse(null);

        if (s == null)
            return ResponseEntity.notFound().build();

        // Security: only allow HOD's dept students
        if (s.getDegree() == null || s.getDegree().getDepartment() == null ||
                !s.getDegree().getDepartment().getId().equals(hod.getDepartment().getId())) {
            return ResponseEntity.status(403).body("Unauthorized: Student not in your department");
        }

        Map<String, Object> detail = new java.util.LinkedHashMap<>();
        detail.put("id", s.getId());
        detail.put("studentId", s.getStudentId());
        detail.put("firstName", s.getFirstName());
        detail.put("lastName", s.getLastName() != null ? s.getLastName() : "");
        detail.put("name", s.getFirstName() + " " + (s.getLastName() != null ? s.getLastName() : ""));
        detail.put("email", s.getUser() != null ? s.getUser().getUsername() : "N/A");
        detail.put("phone", s.getPhone() != null ? s.getPhone() : "N/A");
        detail.put("whatsappNumber", s.getWhatsappNumber() != null ? s.getWhatsappNumber() : "N/A");
        detail.put("dob", s.getDob() != null ? s.getDob() : "N/A");
        detail.put("address", s.getAddress() != null ? s.getAddress() : "N/A");
        detail.put("bloodGroup", s.getBloodGroup() != null ? s.getBloodGroup() : "N/A");
        detail.put("caste", s.getCaste() != null ? s.getCaste() : "N/A");
        detail.put("religion", s.getReligion() != null ? s.getReligion() : "N/A");
        detail.put("parentName", s.getParentName() != null ? s.getParentName() : "N/A");
        detail.put("parentMobile", s.getParentMobile() != null ? s.getParentMobile() : "N/A");
        detail.put("batch", s.getBatch() != null ? s.getBatch() : "N/A");
        detail.put("degree", s.getDegree() != null ? s.getDegree().getCode() : "N/A");
        detail.put("degreeName", s.getDegree() != null ? s.getDegree().getName() : "N/A");
        detail.put("specialization", s.getSpecialization() != null ? s.getSpecialization().getName() : "N/A");
        detail.put("currentYear", s.getCurrentYear());
        detail.put("currentSemester", s.getCurrentSemester());
        detail.put("active", s.isActive());

        // Internal marks
        List<com.college.erp.entity.InternalMark> marks = internalMarkRepository.findByStudentId(id);
        List<Map<String, Object>> marksList = marks.stream().map(m -> {
            Map<String, Object> mk = new java.util.LinkedHashMap<>();
            mk.put("subject", m.getSubjectCode());
            mk.put("examType", m.getExamType());
            mk.put("marks", m.getMarks());
            mk.put("maxMarks", m.getMaxMarks());
            mk.put("pct", m.getMaxMarks() != null && m.getMaxMarks() > 0
                    ? Math.round((double) m.getMarks() / m.getMaxMarks() * 100)
                    : null);
            if (m.getSemester() != null)
                mk.put("semesterNo", m.getSemester().getSemesterNumber());
            return mk;
        }).collect(Collectors.toList());
        detail.put("internalMarks", marksList);

        double avgPct = marks.stream().filter(m -> m.getMaxMarks() != null && m.getMaxMarks() > 0)
                .mapToDouble(m -> (double) m.getMarks() / m.getMaxMarks() * 100).average().orElse(-1);
        detail.put("avgMarkPct", avgPct < 0 ? null : (long) Math.round(avgPct));
        detail.put("performanceTag", avgPct < 0 ? "N/A" : avgPct >= 75 ? "HIGH" : avgPct >= 50 ? "AVERAGE" : "AT_RISK");

        return ResponseEntity.ok(detail);
    }

    @PatchMapping("/students/{id}/toggle-status")
    public ResponseEntity<?> toggleStudentStatus(@PathVariable Long id) {
        Faculty hod = getHODContext();
        if (hod.getDepartment() == null)
            return ResponseEntity.badRequest().body("HOD has no department");

        Student s = studentRepository.findById(id).orElse(null);
        if (s == null)
            return ResponseEntity.notFound().build();

        if (s.getDegree() == null || s.getDegree().getDepartment() == null ||
                !s.getDegree().getDepartment().getId().equals(hod.getDepartment().getId())) {
            return ResponseEntity.status(403).body("Unauthorized");
        }

        s.setActive(!s.isActive());
        studentRepository.save(s);
        return ResponseEntity.ok(Map.of("active", s.isActive(), "message",
                s.isActive() ? "Student activated" : "Student deactivated"));
    }

    @GetMapping("/workload")
    public ResponseEntity<?> getFacultyWorkload() {
        Faculty hod = getHODContext();
        if (hod.getDepartment() == null)
            return ResponseEntity.badRequest().body("HOD has no department");

        List<Faculty> deptFaculty = facultyRepository.findAll().stream()
                .filter(f -> f.getDepartment() != null && f.getDepartment().getId().equals(hod.getDepartment().getId()))
                .collect(Collectors.toList());

        return ResponseEntity.ok(deptFaculty.stream().map(f -> {
            long subjectCount = teachingAssignmentRepository.findByFacultyId(f.getId()).size();
            long weeklyHours = timetableRepository.findByFacultyId(f.getId()).size(); // Assuming each entry is 1 hour

            return Map.of(
                    "facultyId", f.getId(),
                    "name", f.getFirstName() + " " + (f.getLastName() != null ? f.getLastName() : ""),
                    "subjects", subjectCount,
                    "weeklyHours", weeklyHours,
                    "status", weeklyHours > 12 ? "OVERLOAD" : weeklyHours < 4 ? "UNDERLOAD" : "NORMAL");
        }).collect(Collectors.toList()));
    }

    @GetMapping("/marks/pending")
    public ResponseEntity<?> getPendingMarks() {
        Faculty hod = getHODContext();
        if (hod.getDepartment() == null)
            return ResponseEntity.badRequest().body("HOD has no department");

        List<MarkEntry> entries = markEntryRepository.findByStudentDegreeDepartmentIdAndStatusIn(
                hod.getDepartment().getId(),
                Arrays.asList(MarkEntry.MarkStatus.SUBMITTED, MarkEntry.MarkStatus.VERIFIED));

        // Group by Subject Code + Exam Type + Semester
        Map<String, List<MarkEntry>> grouped = entries.stream()
                .collect(
                        Collectors.groupingBy(e -> e.getSubjectCode() + "|" + e.getExamType() + "|" + e.getSemester()));

        List<Map<String, Object>> result = new ArrayList<>();
        grouped.forEach((key, list) -> {
            String[] parts = key.split("\\|");
            result.add(Map.of(
                    "subjectCode", parts[0],
                    "examType", parts[1],
                    "semester", parts[2],
                    "studentCount", list.size(),
                    "status", list.get(0).getStatus(), // Assuming all in group have same status (simplified)
                    "sampleEntryId", list.get(0).getId() // For approval trigger
            ));
        });

        return ResponseEntity.ok(result);
    }

    // ==========================================
    // 3. STAFF & CLASS ADVISOR MANAGEMENT
    // ==========================================

    @GetMapping("/faculty")
    public ResponseEntity<?> getDeptFaculty() {
        Faculty hod = getHODContext();
        if (hod.getDepartment() == null)
            return ResponseEntity.badRequest().body("HOD has no department assigned");

        List<Faculty> faculty = facultyRepository.findAll().stream()
                .filter(f -> f.getDepartment() != null && f.getDepartment().getId().equals(hod.getDepartment().getId()))
                .collect(Collectors.toList());

        return ResponseEntity.ok(mapFacultyList(faculty));
    }

    /** All faculty across all departments — for cross-dept teaching assignments */
    @GetMapping("/faculty/all")
    public ResponseEntity<?> getAllFaculty() {
        List<Faculty> all = facultyRepository.findAll().stream()
                .filter(f -> f.isActive())
                .sorted(Comparator.comparing(f -> f.getDepartment() != null ? f.getDepartment().getCode() : "ZZZ"))
                .collect(Collectors.toList());
        return ResponseEntity.ok(mapFacultyList(all));
    }

    private List<Map<String, Object>> mapFacultyList(List<Faculty> list) {
        return list.stream().map(f -> {
            Map<String, Object> m = new java.util.LinkedHashMap<>();
            m.put("id", f.getId());
            m.put("staffId", f.getStaffId());
            m.put("firstName", f.getFirstName());
            m.put("lastName", f.getLastName() != null ? f.getLastName() : "");
            m.put("name", f.getFirstName() + " " + (f.getLastName() != null ? f.getLastName() : ""));
            m.put("department", f.getDepartment() != null ? f.getDepartment().getCode() : "-");
            m.put("designation", f.getDesignation() != null ? f.getDesignation() : "Faculty");
            List<String> roles = f.getRoles() != null
                    ? f.getRoles().stream().map(r -> r.getRole().name()).collect(Collectors.toList())
                    : List.of();
            m.put("roles", roles);
            return m;
        }).collect(Collectors.toList());
    }

    @Autowired
    private AssistantStaffRepository assistantStaffRepository;

    @GetMapping("/assistant-staff")
    public ResponseEntity<?> getDeptAssistantStaff() {
        Faculty hod = getHODContext();
        if (hod.getDepartment() == null)
            return ResponseEntity.badRequest().body("HOD has no department");

        List<AssistantStaff> staff = assistantStaffRepository.findByDepartmentId(hod.getDepartment().getId());

        return ResponseEntity.ok(staff.stream().map(s -> Map.of(
                "id", s.getId(),
                "firstName", s.getFirstName(),
                "lastName", s.getLastName() != null ? s.getLastName() : "",
                "staffId", s.getAssistantId(),
                "designation", s.getDesignation() != null ? s.getDesignation() : "Assistant"))
                .collect(Collectors.toList()));
    }

    @GetMapping("/sections")
    public ResponseEntity<?> getDeptSections(@RequestParam(required = false) Integer year) {
        Faculty hod = getHODContext();
        if (hod.getDepartment() == null)
            return ResponseEntity.badRequest().body("HOD has no department assigned");

        List<Section> sections = sectionRepository.findByDepartmentId(hod.getDepartment().getId());
        if (year != null) {
            sections = sections.stream().filter(s -> s.getYear() == year).collect(Collectors.toList());
        }

        return ResponseEntity.ok(sections.stream().map(s -> {
            Map<String, Object> m = new java.util.LinkedHashMap<>();
            m.put("id", s.getId());
            m.put("name", s.getName());
            m.put("year", s.getYear());
            m.put("semester", s.getSemester() != null ? s.getSemester().getSemesterNumber() : (s.getYear() * 2 - 1));
            m.put("classAdvisor", s.getClassAdvisor() != null
                    ? s.getClassAdvisor().getFirstName() + " "
                            + (s.getClassAdvisor().getLastName() != null ? s.getClassAdvisor().getLastName() : "")
                    : "Not Assigned");
            m.put("classAdvisorId", s.getClassAdvisor() != null ? s.getClassAdvisor().getId() : "");
            return m;
        }).collect(Collectors.toList()));
    }

    @PostMapping("/assign-advisor")
    public ResponseEntity<?> assignClassAdvisor(@RequestBody Map<String, Object> request) {
        try {
            Long sectionId = Long.valueOf(request.get("sectionId").toString());
            Long facultyId = Long.valueOf(request.get("facultyId").toString());

            Faculty hod = getHODContext();
            // Security Check: Section must belong to HOD's dept
            Section section = sectionRepository.findById(sectionId)
                    .orElseThrow(() -> new RuntimeException("Section not found"));

            if (!section.getDepartment().getId().equals(hod.getDepartment().getId())) {
                return ResponseEntity.status(403).body("Unauthorized: Section belongs to another department");
            }

            Faculty faculty = facultyRepository.findById(facultyId)
                    .orElseThrow(() -> new RuntimeException("Faculty not found"));

            // Security Check: Faculty must belong to HOD's dept
            if (!faculty.getDepartment().getId().equals(hod.getDepartment().getId())) {
                return ResponseEntity.status(403).body("Unauthorized: Faculty belongs to another department");
            }

            // Assign
            section.setClassAdvisor(faculty);
            sectionRepository.save(section);

            return ResponseEntity.ok(Map.of("message", "Class Advisor Assigned Successfully"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }
}
