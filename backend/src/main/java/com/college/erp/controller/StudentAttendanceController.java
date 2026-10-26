package com.college.erp.controller;

import com.college.erp.entity.Attendance;
import com.college.erp.repository.AttendanceRepository;
import com.college.erp.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/students/attendance")
@CrossOrigin(origins = "*", maxAge = 3600)
public class StudentAttendanceController {

    @Autowired
    private AttendanceRepository attendanceRepository;

    @Autowired
    private StudentRepository studentRepository;

    @GetMapping
    @PreAuthorize("hasRole('STUDENT')")
    public ResponseEntity<?> getMyAttendance() {
        String studentIdStr = SecurityContextHolder.getContext().getAuthentication().getName();
        return studentRepository.findByStudentId(studentIdStr)
                .map(student -> {
                    List<Attendance> attendances = attendanceRepository.findByStudentId(student.getId());

                    // Group by subject for the frontend table
                    Map<String, List<Attendance>> grouped = attendances.stream()
                            .collect(Collectors.groupingBy(Attendance::getSubjectCode));

                    List<Map<String, Object>> result = grouped.entrySet().stream()
                            .map(entry -> {
                                List<Attendance> list = entry.getValue();
                                long present = list.stream().filter(a -> "PRESENT".equals(a.getStatus().name()))
                                        .count();
                                long total = list.size();
                                double percent = (double) present / total * 100;

                                Map<String, Object> record = new HashMap<>();
                                record.put("subjectCode", entry.getKey());
                                record.put("subjectName", entry.getKey());
                                record.put("present", present);
                                record.put("total", total);
                                record.put("percentage", String.format("%.1f%%", percent));
                                record.put("status", percent >= 75 ? "Safe" : "Shortage");
                                return record;
                            })
                            .collect(Collectors.toList());

                    return ResponseEntity.ok(result);
                })
                .orElse(ResponseEntity.status(404).build());
    }
}
