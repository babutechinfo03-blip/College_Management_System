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

            teachingAssignmentRepository.save(assignment);

            return ResponseEntity.ok(Map.of("message", "Subject assigned successfully"));
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
        return ResponseEntity.ok(assignments.stream().map(a -> Map.of(
                "id", a.getId(),
                "facultyName", a.getFaculty().getFirstName() + " " + a.getFaculty().getLastName(),
                "subject", a.getSubjectName() + " (" + a.getSubjectCode() + ")",
                "class", "Year " + a.getYear() + " - Sem " + a.getSemester())).collect(Collectors.toList()));
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
        return ResponseEntity.ok(entries);
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

    @GetMapping("/students")
    public ResponseEntity<?> getAllStudents() {
        Faculty hod = getHODContext();
        if (hod.getDepartment() == null)
            return ResponseEntity.badRequest().body("HOD has no department");

        List<Student> students = studentRepository.findByDegreeDepartmentId(hod.getDepartment().getId());

        return ResponseEntity.ok(students.stream().map(s -> Map.of(
                "id", s.getId(),
                "studentId", s.getStudentId(),
                "name", s.getFirstName() + " " + (s.getLastName() != null ? s.getLastName() : ""),
                "year", s.getCurrentYear(),
                "semester", s.getCurrentSemester(),
                "degree", s.getDegree() != null ? s.getDegree().getCode() : "N/A",
                "active", s.isActive())).collect(Collectors.toList()));
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
            return ResponseEntity.badRequest().body("HOD has no department");

        List<Faculty> faculty = facultyRepository.findAll().stream()
                .filter(f -> f.getDepartment() != null && f.getDepartment().getId().equals(hod.getDepartment().getId()))
                .collect(Collectors.toList());

        return ResponseEntity.ok(faculty.stream().map(f -> Map.of(
                "id", f.getId(),
                "firstName", f.getFirstName(),
                "lastName", f.getLastName() != null ? f.getLastName() : "",
                "staffId", f.getStaffId(),
                "designation", f.getDesignation() != null ? f.getDesignation() : "Faculty"))
                .collect(Collectors.toList()));
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
    public ResponseEntity<?> getDeptSections() {
        Faculty hod = getHODContext();
        if (hod.getDepartment() == null)
            return ResponseEntity.badRequest().body("HOD has no department");

        List<Section> sections = sectionRepository.findByDepartmentId(hod.getDepartment().getId());

        return ResponseEntity.ok(sections.stream().map(s -> Map.of(
                "id", s.getId(),
                "name", s.getName(),
                "year", s.getYear(),
                "semester", s.getSemester() != null ? s.getSemester().getSemesterNumber() : 0,
                "classAdvisor",
                s.getClassAdvisor() != null
                        ? (s.getClassAdvisor().getFirstName() + " "
                                + (s.getClassAdvisor().getLastName() != null ? s.getClassAdvisor().getLastName() : ""))
                        : "Not Assigned",
                "classAdvisorId", s.getClassAdvisor() != null ? s.getClassAdvisor().getId() : ""))
                .collect(Collectors.toList()));
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
