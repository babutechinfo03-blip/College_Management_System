package com.college.erp.controller;

import com.college.erp.entity.*;
import com.college.erp.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/attendance")
public class AttendanceController {

    @Autowired
    private AttendanceRepository attendanceRepository;

    @Autowired
    private AttendanceHeaderRepository attendanceHeaderRepository;

    @Autowired
    private AttendanceDetailRepository attendanceDetailRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private FacultyRepository facultyRepository;

    @Autowired
    private AssistantStaffRepository assistantStaffRepository;

    @Autowired
    private SpecializationRepository specializationRepository;

    @Autowired
    private DegreeRepository degreeRepository;

    @Autowired
    private com.college.erp.repository.UserRepository userRepository;

    @Autowired
    private AuditLogRepository auditLogRepository;

    @PostMapping("/submit")
    @PreAuthorize("hasRole('ASSISTANT_STAFF')")
    @Transactional
    public ResponseEntity<?> submitAttendance(@RequestBody Map<String, Object> data) {
        try {
            String username = org.springframework.security.core.context.SecurityContextHolder.getContext()
                    .getAuthentication().getName();
            Faculty faculty = facultyRepository
                    .findByUser(userRepository.findByUsername(username).orElseThrow())
                    .orElseThrow(() -> new RuntimeException("Faculty not found"));

            CourseType programType = CourseType.valueOf(data.get("programType").toString());
            Long degreeId = Long.valueOf(data.get("degreeId").toString());
            Long specId = Long.valueOf(data.get("specializationId").toString());
            int year = Integer.parseInt(data.get("year").toString());
            int semester = Integer.parseInt(data.get("semester").toString());
            LocalDate date = LocalDate.parse(data.get("date").toString());
            int hour = Integer.parseInt(data.get("hour").toString());

            if (date.isAfter(LocalDate.now())) {
                return ResponseEntity.badRequest().body(Map.of("error", "Cannot mark attendance for future dates"));
            }

            // Check for duplicate with full criteria
            if (attendanceHeaderRepository
                    .findByProgramTypeAndDegreeIdAndSpecializationIdAndDateAndHourAndYearAndSemester(
                            programType, degreeId, specId, date, hour, year, semester)
                    .isPresent()) {
                return ResponseEntity.badRequest().body(Map.of("error", "Attendance already submitted for this slot"));
            }

            Degree degree = degreeRepository.findById(degreeId).orElseThrow();
            Specialization specialization = specializationRepository.findById(specId).orElseThrow();

            AttendanceHeader header = AttendanceHeader.builder()
                    .programType(programType)
                    .degree(degree)
                    .specialization(specialization)
                    .year(year)
                    .semester(semester)
                    .date(date)
                    .hour(hour)
                    .faculty(faculty)
                    .submittedAt(java.time.LocalDateTime.now())
                    .build();

            attendanceHeaderRepository.save(header);

            @SuppressWarnings("unchecked")
            List<Map<String, Object>> attendanceList = (List<Map<String, Object>>) data.get("attendance");
            for (Map<String, Object> entry : attendanceList) {
                Student student = studentRepository.findByStudentId(entry.get("studentId").toString()).orElseThrow();
                AttendanceDetail detail = AttendanceDetail.builder()
                        .header(header)
                        .student(student)
                        .status(com.college.erp.entity.AttendanceStatus.valueOf(entry.get("status").toString()))
                        .build();
                attendanceDetailRepository.save(detail);

                // For backward compatibility / existing views
                Attendance legacy = Attendance.builder()
                        .student(student)
                        .faculty(faculty)
                        .date(date)
                        .status(com.college.erp.entity.AttendanceStatus.valueOf(entry.get("status").toString()))
                        .subjectCode("HOUR_" + hour)
                        .build();
                attendanceRepository.save(legacy);
            }

            // Audit Log
            AuditLog log = AuditLog.builder()
                    .action("ATTENDANCE_SUBMISSION")
                    .userRole("ASSISTANT_STAFF")
                    .username(username)
                    .details(String.format("Marked for %s | %s | %s | Year %d | Sem %d | Hour %d",
                            programType, degree.getCode(), specialization.getCode(), year, semester, hour))
                    .timestamp(java.time.LocalDateTime.now())
                    .build();
            auditLogRepository.save(log);

            return ResponseEntity.ok(Map.of("message", "Attendance locked and submitted successfully"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @GetMapping("/history")
    @PreAuthorize("hasRole('ASSISTANT_STAFF')")
    public ResponseEntity<?> getHistory(
            @RequestParam(required = false) String programType,
            @RequestParam(required = false) Long degreeId,
            @RequestParam(required = false) Long specializationId,
            @RequestParam(required = false) Integer year,
            @RequestParam(required = false) Integer semester,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate) {

        String username = org.springframework.security.core.context.SecurityContextHolder.getContext()
                .getAuthentication().getName();
        Faculty faculty = facultyRepository
                .findByUser(userRepository.findByUsername(username).orElseThrow())
                .orElseThrow(() -> new RuntimeException("Faculty not found"));

        List<AttendanceHeader> history = attendanceHeaderRepository
                .findByFacultyIdOrderByDateDescHourDesc(faculty.getId());

        // Dynamic Filtering
        java.util.stream.Stream<AttendanceHeader> stream = history.stream();
        if (programType != null && !programType.isEmpty()) {
            stream = stream.filter(h -> h.getProgramType().name().equals(programType));
        }
        if (degreeId != null) {
            stream = stream.filter(h -> h.getDegree().getId().equals(degreeId));
        }
        if (specializationId != null) {
            stream = stream.filter(h -> h.getSpecialization().getId().equals(specializationId));
        }
        if (year != null) {
            stream = stream.filter(h -> h.getYear() == year);
        }
        if (semester != null) {
            stream = stream.filter(h -> h.getSemester() == semester);
        }
        if (startDate != null && !startDate.isEmpty()) {
            LocalDate start = LocalDate.parse(startDate);
            stream = stream.filter(h -> !h.getDate().isBefore(start));
        }
        if (endDate != null && !endDate.isEmpty()) {
            LocalDate end = LocalDate.parse(endDate);
            stream = stream.filter(h -> !h.getDate().isAfter(end));
        }

        List<Map<String, Object>> result = stream.map(h -> {
            List<AttendanceDetail> details = attendanceDetailRepository.findByHeaderId(h.getId());
            long total = details.size();
            long present = details.stream().filter(d -> d.getStatus() == AttendanceStatus.PRESENT).count();
            long absent = total - present;

            Map<String, Object> m = new java.util.HashMap<>();
            m.put("id", h.getId());
            m.put("date", h.getDate().toString());
            m.put("programType", h.getProgramType());
            m.put("degree", h.getDegree().getName());
            m.put("specialization", Map.of("name", h.getSpecialization().getName(), "code",
                    h.getSpecialization().getCode(), "id", h.getSpecialization().getId()));
            m.put("year", h.getYear());
            m.put("semester", h.getSemester());
            m.put("hour", h.getHour());
            m.put("markedBy", faculty.getStaffId()); // Updated for Faculty
            m.put("submittedAt", h.getSubmittedAt());
            m.put("totalStudents", total);
            m.put("presentCount", present);
            m.put("absentCount", absent);
            return m;
        }).collect(java.util.stream.Collectors.toList());

        return ResponseEntity.ok(result);
    }

    @GetMapping("/stats")
    @PreAuthorize("hasRole('ASSISTANT_STAFF')")
    public ResponseEntity<?> getStats() {
        String username = org.springframework.security.core.context.SecurityContextHolder.getContext()
                .getAuthentication().getName();
        Faculty faculty = facultyRepository
                .findByUser(userRepository.findByUsername(username).orElseThrow())
                .orElseThrow(() -> new RuntimeException("Faculty not found"));

        LocalDate today = LocalDate.now();
        List<AttendanceHeader> headers = attendanceHeaderRepository
                .findByFacultyIdOrderByDateDescHourDesc(faculty.getId());

        long submittedToday = headers.stream().filter(h -> h.getDate().equals(today)).count();

        // Calculate total students marked today
        long studentsMarkedToday = headers.stream()
                .filter(h -> h.getDate().equals(today))
                .mapToLong(h -> attendanceDetailRepository.findByHeaderId(h.getId()).size())
                .sum();

        Map<String, Object> stats = new java.util.HashMap<>();
        stats.put("date", today.toString());
        stats.put("submittedToday", submittedToday);
        stats.put("studentsMarkedToday", studentsMarkedToday);
        stats.put("totalAssigned", "Dynamic Schedule"); // Placeholder
        stats.put("pendingClasses", "Check Schedule"); // Placeholder

        return ResponseEntity.ok(stats);
    }

    @GetMapping("/degrees")
    @PreAuthorize("hasAnyRole('ASSISTANT_STAFF', 'OFFICE')")
    public ResponseEntity<?> getDegrees(@RequestParam CourseType programType) {
        return ResponseEntity.ok(degreeRepository.findByProgramType(programType));
    }

    @GetMapping("/specializations")
    @PreAuthorize("hasAnyRole('ASSISTANT_STAFF', 'OFFICE')")
    public ResponseEntity<?> getSpecializations(@RequestParam Long degreeId) {
        return ResponseEntity.ok(specializationRepository.findByDegreeId(degreeId));
    }

    @GetMapping("/students-list")
    @PreAuthorize("hasAnyRole('ASSISTANT_STAFF', 'OFFICE')")
    public ResponseEntity<?> getStudentsForAttendance(
            @RequestParam Long specializationId,
            @RequestParam int year,
            @RequestParam int semester) {

        List<Student> students = studentRepository.findAll();
        List<Map<String, Object>> result = students.stream()
                .filter(s -> s.getSpecialization() != null && s.getSpecialization().getId().equals(specializationId))
                .filter(s -> s.getCurrentYear() == year)
                // Filter by semester if needed, but usually students are group by year/dept
                .map(s -> {
                    Map<String, Object> m = new java.util.HashMap<>();
                    m.put("studentId", s.getStudentId());
                    m.put("name", s.getFirstName() + " " + (s.getLastName() != null ? s.getLastName() : ""));
                    m.put("photoPath", s.getPhotoPath());
                    return m;
                })
                .collect(java.util.stream.Collectors.toList());

        return ResponseEntity.ok(result);
    }

    @PostMapping("/mark")
    @PreAuthorize("hasAnyRole('FACULTY', 'HOD', 'ADVISOR', 'ASSISTANT_STAFF')")
    public ResponseEntity<?> markAttendance(@RequestBody Map<String, Object> data) {
        return ResponseEntity.ok(Map.of("message", "Legacy endpoint - use /submit for Assistant Flow"));
    }

    @GetMapping("/student/{studentId}")
    @PreAuthorize("hasAnyRole('STUDENT', 'PARENT', 'PRINCIPAL', 'FACULTY')")
    public ResponseEntity<List<Attendance>> getStudentAttendance(@PathVariable Long studentId) {
        return ResponseEntity.ok(attendanceRepository.findByStudentId(studentId));
    }
}
