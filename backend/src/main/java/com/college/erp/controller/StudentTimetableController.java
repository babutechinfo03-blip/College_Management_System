package com.college.erp.controller;

import com.college.erp.entity.*;
import com.college.erp.repository.StudentRepository;
import com.college.erp.repository.TimetableRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;

@RestController
@RequestMapping("/api/students/timetable")
@CrossOrigin(origins = "*", maxAge = 3600)
public class StudentTimetableController {

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private TimetableRepository timetableRepository;

    @GetMapping
    @PreAuthorize("hasRole('STUDENT')")
    public ResponseEntity<?> getMyTimetable() {
        String studentIdStr = SecurityContextHolder.getContext().getAuthentication().getName();
        return studentRepository.findByStudentId(studentIdStr)
                .map(student -> {
                    if (student.getSection() == null) {
                        return ResponseEntity.ok(new ArrayList<>());
                    }

                    List<TimetableEntry> entries = timetableRepository.findByDepartmentIdAndYearAndSectionId(
                            student.getDegree().getDepartment().getId(),
                            student.getCurrentYear(),
                            student.getSection().getId());

                    // Group by day for easier frontend processing
                    Map<String, List<TimetableEntry>> grouped = new HashMap<>();
                    for (TimetableEntry entry : entries) {
                        grouped.computeIfAbsent(entry.getDayOfWeek(), k -> new ArrayList<>()).add(entry);
                    }

                    return ResponseEntity.ok(grouped);
                })
                .orElse(ResponseEntity.status(404).build());
    }
}
