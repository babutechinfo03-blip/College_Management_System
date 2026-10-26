package com.college.erp.controller;

import com.college.erp.entity.*;
import com.college.erp.repository.AttendanceRepository;
import com.college.erp.repository.InternalMarkRepository;
import com.college.erp.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@RestController
@RequestMapping("/api/students")
public class StudentController {
    @Autowired
    private StudentService studentService;

    @Autowired
    private AttendanceRepository attendanceRepository;

    @Autowired
    private InternalMarkRepository internalMarkRepository;

    @Autowired
    private com.college.erp.repository.AssignmentRepository assignmentRepository;

    @Autowired
    private com.college.erp.repository.AssignmentSubmissionRepository assignmentSubmissionRepository;

    @GetMapping
    @PreAuthorize("hasRole('PRINCIPAL') or hasRole('STAFF')")
    public ResponseEntity<List<Student>> getAllStudents() {
        return ResponseEntity.ok(studentService.getAllStudents());
    }

    @GetMapping("/{studentId}")
    public ResponseEntity<Student> getStudent(@PathVariable String studentId) {
        return ResponseEntity.ok(studentService.getStudentByStudentId(studentId));
    }

    @PostMapping
    @PreAuthorize("hasRole('PRINCIPAL')")
    public ResponseEntity<Student> createStudent(@RequestBody Student student) {
        return ResponseEntity.ok(studentService.saveStudent(student));
    }

    @GetMapping("/profile")
    @PreAuthorize("hasRole('STUDENT')")
    public ResponseEntity<Map<String, Object>> getProfile() {
        String studentIdStr = SecurityContextHolder.getContext().getAuthentication().getName();
        Student student = studentService.getStudentByStudentId(studentIdStr);
        Long id = student.getId();

        // Calculate Attendance
        List<Attendance> attendances = attendanceRepository.findByStudentId(id);
        long totalPresent = attendances.stream().filter(a -> a.getStatus() == AttendanceStatus.PRESENT).count();
        long totalSessions = attendances.size();
        String attendancePercent = totalSessions > 0 ? (totalPresent * 100 / totalSessions) + "%" : "0%";

        // Calculate Average Marks
        List<InternalMark> marks = internalMarkRepository.findByStudentId(id);
        double avgMark = marks.stream().mapToInt(InternalMark::getMarks).average().orElse(0.0);

        // Calculate Pending Tasks
        Long sectionId = student.getSection() != null ? student.getSection().getId() : null;
        int pendingTasks = 0;
        if (sectionId != null) {
            List<Assignment> totalAssignments = assignmentRepository.findBySectionId(sectionId);
            List<AssignmentSubmission> mySubmissions = assignmentSubmissionRepository.findByStudentId(id);
            java.util.Set<Long> submittedIds = mySubmissions.stream()
                    .map(s -> s.getAssignment().getId())
                    .collect(java.util.stream.Collectors.toSet());

            pendingTasks = (int) totalAssignments.stream()
                    .filter(a -> !submittedIds.contains(a.getId()))
                    .count();
        }

        Map<String, Object> profile = new HashMap<>();
        profile.put("studentId", student.getStudentId());
        profile.put("firstName", student.getFirstName());
        profile.put("lastName", student.getLastName());
        profile.put("email", student.getUser().getEmail());
        profile.put("degree", student.getDegree() != null ? student.getDegree().getName() : "N/A");
        profile.put("specialization",
                student.getSpecialization() != null ? student.getSpecialization().getName() : "N/A");
        profile.put("currentYear", student.getCurrentYear());
        profile.put("currentSemester", student.getCurrentSemester());
        profile.put("batch", student.getBatch());
        profile.put("photoPath", student.getPhotoPath());

        // Dynamic Stats
        Map<String, String> stats = new HashMap<>();
        stats.put("attendance", attendancePercent);
        stats.put("avgMarks", String.format("%.1f", avgMark));
        stats.put("pendingAssignments", String.valueOf(pendingTasks));
        stats.put("nextExam", "Upcoming"); // Logic can be added later

        profile.put("stats", stats);

        return ResponseEntity.ok(profile);
    }
}
