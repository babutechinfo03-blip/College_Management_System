package com.college.erp.controller;

import com.college.erp.service.PrincipalReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/principal/reports")
@RequiredArgsConstructor
@PreAuthorize("hasRole('PRINCIPAL')")
@CrossOrigin(origins = "*", maxAge = 3600)
public class PrincipalReportController {

    private final PrincipalReportService principalReportService;

    @GetMapping("/attendance")
    public ResponseEntity<List<Map<String, Object>>> getAttendanceReport() {
        return ResponseEntity.ok(principalReportService.getAttendanceReport());
    }

    @GetMapping("/marks")
    public ResponseEntity<List<Map<String, Object>>> getMarksReport() {
        return ResponseEntity.ok(principalReportService.getMarksReport());
    }
}
