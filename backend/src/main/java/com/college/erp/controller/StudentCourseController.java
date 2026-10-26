package com.college.erp.controller;

import com.college.erp.entity.*;
import com.college.erp.repository.StudentRepository;
import com.college.erp.repository.TeachingAssignmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/students/courses")
@CrossOrigin(origins = "*", maxAge = 3600)
public class StudentCourseController {

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private TeachingAssignmentRepository teachingAssignmentRepository;

    @GetMapping
    @PreAuthorize("hasRole('STUDENT')")
    public ResponseEntity<?> getMyCourses() {
        String studentIdStr = SecurityContextHolder.getContext().getAuthentication().getName();
        return studentRepository.findByStudentId(studentIdStr)
                .map(student -> {
                    List<TeachingAssignment> assignments = teachingAssignmentRepository
                            .findByDepartmentIdAndYearAndSemester(
                                    student.getDegree().getDepartment().getId(),
                                    student.getCurrentYear(),
                                    student.getCurrentSemester());

                    // Add Filter by section if assignments are section-specific
                    List<TeachingAssignment> filtered = assignments.stream()
                            .filter(a -> a.getSection() == null || a.getSection().equals(student.getSection()))
                            .collect(Collectors.toList());

                    return ResponseEntity.ok(filtered);
                })
                .orElse(ResponseEntity.status(404).build());
    }
}
