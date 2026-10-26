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
@RequestMapping("/api/staff")
public class StaffController {

        @Autowired
        private FacultyRepository facultyRepository;

        @Autowired
        private UserRepository userRepository;

        @Autowired
        private TeachingAssignmentRepository teachingAssignmentRepository;

        @Autowired
        private TimetableRepository timetableRepository;

        @Autowired
        private StaffRoleRepository staffRoleRepository;

        @Autowired
        private DepartmentRepository departmentRepository;

        @Autowired
        private AssistantStaffRepository assistantStaffRepository;

        @Autowired
        private AssignmentRepository assignmentRepository;

        @Autowired
        private SectionRepository sectionRepository;

        @GetMapping("/departments")
        public ResponseEntity<?> getDepartments() {
                return ResponseEntity.ok(departmentRepository.findAll());
        }

        @GetMapping("/faculty-list")
        public ResponseEntity<?> getFacultyList() {
                // Return simplified list for dropdowns
                return ResponseEntity.ok(facultyRepository.findAll().stream().map(f -> Map.of(
                                "id", f.getId(),
                                "firstName", f.getFirstName(),
                                "lastName", f.getLastName() != null ? f.getLastName() : "",
                                "department", f.getDepartment() != null ? f.getDepartment().getCode() : "N/A"))
                                .collect(Collectors.toList()));
        }

        private Faculty getCurrentStaff() {
                String username = SecurityContextHolder.getContext().getAuthentication().getName();
                User user = userRepository.findByUsername(username).orElseThrow();
                return facultyRepository.findByUser(user).orElseThrow();
        }

        @GetMapping("/dashboard")
        @PreAuthorize("hasAnyRole('FACULTY', 'HOD', 'ADVISOR')")
        public ResponseEntity<?> getDashboardData(@RequestParam(required = false) String activeRole) {
                Faculty staff = getCurrentStaff();
                Map<String, Object> data = new HashMap<>();

                // 1. Profile Info (Common)
                data.put("profile", Map.of(
                                "name",
                                staff.getFirstName() + " " + (staff.getLastName() != null ? staff.getLastName() : ""),
                                "staffId", staff.getStaffId(),
                                "designation", staff.getDesignation(),
                                "departmentId", staff.getDepartment() != null ? staff.getDepartment().getId() : null,
                                "department", staff.getDepartment() != null ? staff.getDepartment().getName() : "N/A"));

                String roleToServe = activeRole != null ? activeRole : "FACULTY";

                // 2. Role-Specific Data
                if ("FACULTY".equals(roleToServe)) {
                        // Real Teaching Assignments
                        List<TeachingAssignment> assignments = teachingAssignmentRepository
                                        .findByFacultyId(staff.getId());

                        data.put("teachingAssignments", assignments.stream().map(a -> Map.of(
                                        "id", a.getId(),
                                        "subject", a.getSubjectName(),
                                        "subjectCode", a.getSubjectCode(),
                                        "department", a.getDepartment().getCode(),
                                        "year", a.getYear(),
                                        "semester", a.getSemester())).collect(Collectors.toList()));

                        // Mock recent activity until Attendance is linked to Faculty properly
                        data.put("recentActivity", Arrays.asList(
                                        Map.of("action", "Login", "details", "Accessed Dashboard", "time",
                                                        java.time.LocalDateTime.now().toString())));
                } else if ("CLASS_ADVISOR".equals(roleToServe)) {
                        // Check if actually advisor
                        boolean isAdvisor = staffRoleRepository.findAll().stream()
                                        .anyMatch(sr -> sr.getFaculty().getId().equals(staff.getId())
                                                        && sr.getRole() == RoleType.CLASS_ADVISOR);

                        if (isAdvisor) {
                                // Return class-specific metrics
                                // Note: Logic to link Faculty -> Class Section to be added.
                                // For now, returning mock data for UI simulation of a real Advisor
                                data.put("advisorSummary", Map.of(
                                                "assignedClass", "CSE - Year 2 - A",
                                                "totalStudents", 64,
                                                "avgAttendance", "91.5%",
                                                "defaultersCount", 3,
                                                "pendingApprovals", 2));
                        }
                } else if ("HOD".equals(roleToServe)) {
                        // HOD Logic
                        boolean isHod = staffRoleRepository.findAll().stream()
                                        .anyMatch(sr -> sr.getFaculty().getId().equals(staff.getId())
                                                        && sr.getRole() == RoleType.HOD);

                        if (isHod && staff.getDepartment() != null) {
                                Department dept = staff.getDepartment();
                                // Real count of faculty in department
                                long facultyCount = facultyRepository.findAll().stream()
                                                .filter(f -> f.getDepartment() != null
                                                                && f.getDepartment().getId().equals(dept.getId()))
                                                .count();

                                long studentCount = studentRepository.countByDegreeDepartmentId(dept.getId());
                                long assistantCount = assistantStaffRepository.countByDepartmentId(dept.getId());

                                String todayDay = java.time.LocalDate.now().getDayOfWeek().toString(); // e.g., MONDAY
                                long todayClasses = timetableRepository.countByDepartmentIdAndDayOfWeek(dept.getId(),
                                                todayDay);

                                long pendingMarks = markEntryRepository.countByStudentDegreeDepartmentIdAndStatusIn(
                                                dept.getId(), Arrays.asList(MarkEntry.MarkStatus.SUBMITTED,
                                                                MarkEntry.MarkStatus.VERIFIED));
                                long approvedMarks = markEntryRepository.countByStudentDegreeDepartmentIdAndStatus(
                                                dept.getId(), MarkEntry.MarkStatus.APPROVED);

                                data.put("hodAnalytics", Map.of(
                                                "departmentName", dept.getName(),
                                                "totalFaculty", facultyCount,
                                                "totalStudents", studentCount,
                                                "totalAssistantStaff", assistantCount,
                                                "todayClasses", todayClasses,
                                                "marksPending", pendingMarks,
                                                "marksApproved", approvedMarks,
                                                "deptAttendanceAvg", "88%", // Placeholder still, until Attendance
                                                                            // entity is fully queryable
                                                "activeResearches", 5,
                                                "pendingResults", 2));
                        }
                }

                return ResponseEntity.ok(data);
        }

        // Legacy endpoints kept for backward compatibility if needed,
        // but dashboard logic is now centralized above.

        @GetMapping("/teaching-assignments")
        @PreAuthorize("hasRole('FACULTY')")
        public ResponseEntity<?> getTeachingAssignments() {
                Faculty staff = getCurrentStaff();
                List<TeachingAssignment> assignments = teachingAssignmentRepository.findByFacultyId(staff.getId());

                return ResponseEntity.ok(assignments.stream().map(a -> Map.of(
                                "id", a.getId(),
                                "subject", a.getSubjectName(),
                                "subjectCode", a.getSubjectCode(),
                                "department", a.getDepartment().getCode(),
                                "year", a.getYear(),
                                "classLabel", a.getDepartment().getCode() + " - Yr " + a.getYear(),
                                "semester", a.getSemester())).collect(Collectors.toList()));
        }

        @PostMapping("/hod/assign-subject")
        @PreAuthorize("hasRole('HOD')")
        public ResponseEntity<?> assignSubject(@RequestBody Map<String, Object> request) {
                // Logic to create TeachingAssignment
                return ResponseEntity.ok(Map.of("message", "Subject assigned successfully (Simulation)"));
        }

        @GetMapping("/my-timetable")
        @PreAuthorize("hasRole('FACULTY')")
        public ResponseEntity<?> getMyTimetable() {
                Faculty staff = getCurrentStaff();
                List<TimetableEntry> entries = timetableRepository.findByFacultyId(staff.getId());
                return ResponseEntity.ok(entries);
        }

        // MARKS MANAGEMENT (Faculty)
        @Autowired
        private MarkEntryRepository markEntryRepository;

        @Autowired
        private StudentRepository studentRepository;

        @GetMapping("/students")
        @PreAuthorize("hasRole('FACULTY')")
        public ResponseEntity<?> getStudentsByClass(@RequestParam Long departmentId, @RequestParam Integer year) {
                return ResponseEntity.ok(studentRepository.findByDegreeDepartmentIdAndCurrentYear(departmentId, year)
                                .stream()
                                .map(s -> Map.of(
                                                "id", s.getId(),
                                                "studentId", s.getStudentId(),
                                                "firstName", s.getFirstName(),
                                                "lastName", s.getLastName() != null ? s.getLastName() : ""))
                                .collect(Collectors.toList()));
        }

        @PostMapping("/marks/submit")
        @PreAuthorize("hasRole('FACULTY')")
        public ResponseEntity<?> submitMarks(@RequestBody Map<String, Object> request) {
                try {
                        Faculty staff = getCurrentStaff();
                        String subjectCode = (String) request.get("subjectCode");
                        String examType = (String) request.get("examType");
                        Integer semester = Integer.valueOf(request.get("semester").toString());
                        boolean isFinalSubmit = Boolean.parseBoolean(request.get("isFinal").toString()); // true =
                                                                                                         // SUBMITTED,
                                                                                                         // false =
                                                                                                         // DRAFT

                        List<Map<String, Object>> marksData = (List<Map<String, Object>>) request.get("marks");

                        for (Map<String, Object> m : marksData) {
                                Long studentId = Long.valueOf(m.get("studentId").toString());
                                Double marks = Double.valueOf(m.get("marks").toString());
                                Double maxMarks = Double.valueOf(m.get("maxMarks").toString());

                                // Security: Prevent editing if already APPROVED
                                MarkEntry existing = markEntryRepository.findById(studentId).orElse(null); // NOTE: This
                                                                                                           // is naive,
                                                                                                           // actually
                                                                                                           // we need to
                                                                                                           // query by
                                                                                                           // student+subject+sem.
                                // Since we are creating a new MarkEntry object in the loop, we are essentially
                                // overwriting?
                                // Actually the code below creates 'new MarkEntry()'. This is WRONG if updating.
                                // The original code was naive insert. I should fix it to be upsert first to
                                // properly check status.

                                // Better Fix: Query existing entry by Student + Subject + ExamType + Semester
                                // But currently we don't have a unique constraint or lookup method easily
                                // without adding more repo methods.
                                // Assuming we want strict check:

                                MarkEntry entry = markEntryRepository.findAll().stream()
                                                .filter(e -> e.getStudent().getId().equals(studentId) &&
                                                                e.getSubjectCode().equals(subjectCode) &&
                                                                e.getExamType().equals(examType) &&
                                                                e.getSemester().equals(semester))
                                                .findFirst().orElse(new MarkEntry());

                                if (entry.getStatus() == MarkEntry.MarkStatus.APPROVED) {
                                        throw new RuntimeException(
                                                        "Cannot edit marks that are already APPROVED by HOD.");
                                }

                                if (entry.getId() == null) {
                                        entry.setStudent(studentRepository.findById(studentId).orElseThrow());
                                        entry.setSubjectCode(subjectCode);
                                        entry.setExamType(examType);
                                        entry.setSemester(semester);
                                }

                                entry.setMarksObtained(marks);
                                entry.setMaxMarks(maxMarks);
                                entry.setEnteredBy(staff);
                                entry.setStatus(isFinalSubmit ? MarkEntry.MarkStatus.SUBMITTED
                                                : MarkEntry.MarkStatus.DRAFT);

                                markEntryRepository.save(entry);
                        }

                        return ResponseEntity.ok(Map.of("message",
                                        isFinalSubmit ? "Marks Submitted for Verification" : "Marks Saved as Draft"));
                } catch (Exception e) {
                        return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
                }
        }

        @GetMapping("/marks/pending")
        @PreAuthorize("hasRole('CLASS_ADVISOR')")
        public ResponseEntity<?> getPendingVerifications() {
                Faculty advisor = getCurrentStaff();
                if (advisor.getDepartment() == null)
                        return ResponseEntity.ok(Collections.emptyList());

                // Fetch all marks for this dept that are SUBMITTED
                // Ideally we filter by the specific class the advisor manages
                // For now, returning all SUBMITTED marks for the department
                List<MarkEntry> pending = markEntryRepository.findAll().stream()
                                .filter(m -> m.getStatus() == MarkEntry.MarkStatus.SUBMITTED &&
                                                m.getStudent().getDegree().getDepartment().getId()
                                                                .equals(advisor.getDepartment().getId()))
                                .collect(Collectors.toList());

                return ResponseEntity.ok(pending.stream().map(m -> Map.of(
                                "id", m.getId(),
                                "studentName", m.getStudent().getFirstName(),
                                "subjectCode", m.getSubjectCode(),
                                "marks", m.getMarksObtained(),
                                "maxMarks", m.getMaxMarks())).collect(Collectors.toList()));
        }

        @PostMapping("/marks/verify")
        @PreAuthorize("hasRole('CLASS_ADVISOR')")
        public ResponseEntity<?> verifyMarks(@RequestBody Map<String, Object> request) {
                try {
                        Long entryId = Long.valueOf(request.get("entryId").toString());
                        MarkEntry entry = markEntryRepository.findById(entryId).orElseThrow();

                        if (entry.getStatus() == MarkEntry.MarkStatus.SUBMITTED) {
                                entry.setStatus(MarkEntry.MarkStatus.VERIFIED);
                                markEntryRepository.save(entry);
                                return ResponseEntity.ok(Map.of("message", "Marks Verified Successfully"));
                        }
                        return ResponseEntity.badRequest().body(Map.of("error", "Marks are not in SUBMITTED state"));
                } catch (Exception e) {
                        return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
                }
        }

        // ASSIGNMENT MANAGEMENT (Faculty)
        @PostMapping("/assignments/create")
        @PreAuthorize("hasRole('FACULTY')")
        public ResponseEntity<?> createAssignment(@RequestBody Map<String, Object> request) {
                try {
                        Faculty staff = getCurrentStaff();
                        String title = (String) request.get("title");
                        String description = (String) request.get("description");
                        String subjectCode = (String) request.get("subjectCode");
                        Long sectionId = Long.valueOf(request.get("sectionId").toString());
                        java.time.LocalDateTime deadline = java.time.LocalDateTime
                                        .parse(request.get("deadline").toString());
                        String attachmentPath = (String) request.get("attachmentPath");

                        Assignment assignment = Assignment.builder()
                                        .title(title)
                                        .description(description)
                                        .subjectCode(subjectCode)
                                        .section(sectionRepository.findById(sectionId).orElseThrow())
                                        .faculty(staff)
                                        .deadline(deadline)
                                        .attachmentPath(attachmentPath)
                                        .build();

                        assignmentRepository.save(assignment);
                        return ResponseEntity.ok(
                                        Map.of("message", "Assignment Created Successfully", "id", assignment.getId()));
                } catch (Exception e) {
                        return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
                }
        }

        @GetMapping("/assignments")
        @PreAuthorize("hasRole('FACULTY')")
        public ResponseEntity<?> getMyAssignments() {
                Faculty staff = getCurrentStaff();
                return ResponseEntity.ok(assignmentRepository.findByFacultyId(staff.getId()));
        }
}
