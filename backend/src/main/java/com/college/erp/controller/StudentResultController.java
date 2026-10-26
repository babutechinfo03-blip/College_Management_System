package com.college.erp.controller;

import com.college.erp.entity.SemesterResult;
import com.college.erp.repository.SemesterResultRepository;
import com.college.erp.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

@RestController
@RequestMapping("/api/students/results")
@CrossOrigin(origins = "*", maxAge = 3600)
public class StudentResultController {

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private SemesterResultRepository semesterResultRepository;

    @GetMapping
    @PreAuthorize("hasRole('STUDENT')")
    public ResponseEntity<?> getMyResults() {
        String studentIdStr = SecurityContextHolder.getContext().getAuthentication().getName();
        return studentRepository.findByStudentId(studentIdStr)
                .map(student -> {
                    List<SemesterResult> results = semesterResultRepository.findByStudentId(student.getId());

                    // Group by semester
                    Map<Integer, List<SemesterResult>> semesterGroups = results.stream()
                            .collect(java.util.stream.Collectors.groupingBy(SemesterResult::getSemester));

                    List<Map<String, Object>> semesterSummaries = new java.util.ArrayList<>();
                    double cumulativeGradePoints = 0;
                    int cumulativeCredits = 0;

                    for (int sem : semesterGroups.keySet().stream().sorted().toList()) {
                        List<SemesterResult> semResults = semesterGroups.get(sem);
                        double semGradePoints = 0;
                        int semCredits = 0;

                        for (SemesterResult res : semResults) {
                            int gp = getGradePoint(res.getGrade());
                            semGradePoints += (gp * res.getCredits());
                            semCredits += res.getCredits();
                        }

                        double sgpa = semCredits > 0 ? semGradePoints / semCredits : 0.0;
                        cumulativeGradePoints += semGradePoints;
                        cumulativeCredits += semCredits;

                        Map<String, Object> semData = new HashMap<>();
                        semData.put("semester", sem);
                        semData.put("results", semResults);
                        semData.put("sgpa", String.format("%.2f", sgpa));
                        semesterSummaries.add(semData);
                    }

                    double cgpa = cumulativeCredits > 0 ? cumulativeGradePoints / cumulativeCredits : 0.0;

                    Map<String, Object> response = new HashMap<>();
                    response.put("semesters", semesterSummaries);
                    response.put("cgpa", String.format("%.2f", cgpa));
                    response.put("totalCredits", cumulativeCredits);

                    return ResponseEntity.ok(response);
                })
                .orElse(ResponseEntity.status(404).build());
    }

    private int getGradePoint(String grade) {
        if (grade == null)
            return 0;
        return switch (grade.toUpperCase()) {
            case "O" -> 10;
            case "A+" -> 9;
            case "A" -> 8;
            case "B+" -> 7;
            case "B" -> 6;
            case "C" -> 5;
            default -> 0;
        };
    }
}
