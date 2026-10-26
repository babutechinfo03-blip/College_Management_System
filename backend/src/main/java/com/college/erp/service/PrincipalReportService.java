package com.college.erp.service;

import com.college.erp.repository.DepartmentRepository;
import com.college.erp.repository.StudentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PrincipalReportService {

    private final DepartmentRepository departmentRepository;
    private final StudentRepository studentRepository;

    public List<Map<String, Object>> getAttendanceReport() {
        // Return dummy data for attendance since there's no attendance tracking module
        // yet.
        return departmentRepository.findAll().stream().map(d -> {
            Map<String, Object> map = new java.util.HashMap<>();
            map.put("department", d.getCode());
            map.put("averageAttendance", 85 + (Math.random() * 10));
            map.put("defaultersCount", (int) (Math.random() * 50));
            return map;
        }).collect(Collectors.toList());
    }

    public List<Map<String, Object>> getMarksReport() {
        return departmentRepository.findAll().stream().map(d -> {
            long totalStudents = studentRepository.countByDegreeDepartmentId(d.getId());
            double passPct = 60 + (Math.random() * 30); // Mocking aggregated pass % for performance

            Map<String, Object> map = new java.util.HashMap<>();
            map.put("department", d.getCode());
            map.put("totalStudents", totalStudents);
            map.put("averagePassPercentage", String.format("%.2f", passPct));
            map.put("topPerformerTarget", "Details TBD");
            return map;
        }).collect(Collectors.toList());
    }
}
