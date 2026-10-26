package com.college.erp.controller;

import com.college.erp.entity.MarkEntry;
import com.college.erp.repository.MarkEntryRepository;
import com.college.erp.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/students/marks")
@CrossOrigin(origins = "*", maxAge = 3600)
public class StudentMarkController {

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private MarkEntryRepository markEntryRepository;

    @GetMapping
    @PreAuthorize("hasRole('STUDENT')")
    public ResponseEntity<?> getMyMarks() {
        String studentIdStr = SecurityContextHolder.getContext().getAuthentication().getName();
        return studentRepository.findByStudentId(studentIdStr)
                .map(student -> {
                    List<MarkEntry> allMarks = markEntryRepository.findByStudentId(student.getId());

                    // Filter: Only show APPROVED marks to students
                    List<MarkEntry> approvedMarks = allMarks.stream()
                            .filter(m -> m.getStatus() == MarkEntry.MarkStatus.APPROVED)
                            .collect(Collectors.toList());

                    return ResponseEntity.ok(approvedMarks);
                })
                .orElse(ResponseEntity.status(404).build());
    }
}
