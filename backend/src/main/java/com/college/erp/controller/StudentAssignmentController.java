package com.college.erp.controller;

import com.college.erp.entity.Assignment;
import com.college.erp.entity.AssignmentSubmission;
import com.college.erp.entity.Student;
import com.college.erp.repository.AssignmentRepository;
import com.college.erp.repository.AssignmentSubmissionRepository;
import com.college.erp.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

@RestController
@RequestMapping("/api/students/assignments")
@CrossOrigin(origins = "*", maxAge = 3600)
public class StudentAssignmentController {

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private AssignmentRepository assignmentRepository;

    @Autowired
    private AssignmentSubmissionRepository submissionRepository;

    @GetMapping
    @PreAuthorize("hasRole('STUDENT')")
    public ResponseEntity<?> getMyAssignments() {
        String studentIdStr = SecurityContextHolder.getContext().getAuthentication().getName();
        return studentRepository.findByStudentId(studentIdStr)
                .map(student -> {
                    if (student.getSection() == null)
                        return ResponseEntity.ok(java.util.Collections.emptyList());

                    List<Assignment> assignments = assignmentRepository.findBySectionId(student.getSection().getId());
                    List<AssignmentSubmission> submissions = submissionRepository.findByStudentId(student.getId());

                    Map<Long, AssignmentSubmission> submissionMap = new HashMap<>();
                    for (AssignmentSubmission s : submissions) {
                        submissionMap.put(s.getAssignment().getId(), s);
                    }

                    List<Map<String, Object>> result = assignments.stream().map(a -> {
                        Map<String, Object> map = new HashMap<>();
                        map.put("id", a.getId());
                        map.put("title", a.getTitle());
                        map.put("description", a.getDescription());
                        map.put("subjectCode", a.getSubjectCode());
                        map.put("deadline", a.getDeadline());
                        map.put("facultyName", a.getFaculty() != null ? a.getFaculty().getFirstName() : "N/A");

                        AssignmentSubmission sub = submissionMap.get(a.getId());
                        map.put("submissionStatus", sub != null ? sub.getStatus() : "PENDING");
                        map.put("marks", sub != null ? sub.getMarks() : null);
                        return map;
                    }).collect(java.util.stream.Collectors.toList());

                    return ResponseEntity.ok(result);
                })
                .orElse(ResponseEntity.status(404).build());
    }

    @PostMapping("/{id}/submit")
    @PreAuthorize("hasRole('STUDENT')")
    public ResponseEntity<?> submitAssignment(
            @PathVariable Long id,
            @RequestPart("file") MultipartFile file) {

        String studentIdStr = SecurityContextHolder.getContext().getAuthentication().getName();
        Student student = studentRepository.findByStudentId(studentIdStr).orElseThrow();
        Assignment assignment = assignmentRepository.findById(id).orElseThrow();

        // Mock file saving logic
        String fileName = file.getOriginalFilename();
        String filePath = "/uploads/assignments/" + student.getStudentId() + "_" + fileName;

        AssignmentSubmission submission = submissionRepository.findByAssignmentIdAndStudentId(id, student.getId())
                .orElse(new AssignmentSubmission());

        submission.setAssignment(assignment);
        submission.setStudent(student);
        submission.setFileName(fileName);
        submission.setFilePath(filePath);
        submission.setSubmissionDate(java.time.LocalDateTime.now());

        return ResponseEntity.ok(submissionRepository.save(submission));
    }
}
