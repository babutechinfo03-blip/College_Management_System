package com.college.erp.controller;

import com.college.erp.entity.AcademicControl;
import com.college.erp.entity.User;
import com.college.erp.service.PrincipalService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/principal")
@RequiredArgsConstructor
@PreAuthorize("hasRole('PRINCIPAL')")
@CrossOrigin(origins = "*", maxAge = 3600)
public class PrincipalController {

    private final PrincipalService principalService;

    @GetMapping("/dashboard-stats")
    public ResponseEntity<Map<String, Object>> getDashboardStats() {
        return ResponseEntity.ok(principalService.getDashboardStats());
    }

    // Office User Management
    @GetMapping("/office-users")
    public ResponseEntity<List<User>> getOfficeUsers() {
        return ResponseEntity.ok(principalService.getAllOfficeUsers());
    }

    @PostMapping("/office-users")
    public ResponseEntity<User> createOfficeUser(@RequestBody User user) {
        return ResponseEntity.ok(principalService.createOfficeUser(user));
    }

    @PatchMapping("/users/{userId}/toggle-status")
    public ResponseEntity<Void> toggleUserStatus(@PathVariable Long userId) {
        principalService.toggleUserActiveStatus(userId);
        return ResponseEntity.ok().build();
    }

    // Global User Oversight
    @GetMapping("/users")
    public ResponseEntity<List<User>> getUserOversight(@RequestParam(required = false) String role) {
        com.college.erp.entity.Role queryRole = role != null ? com.college.erp.entity.Role.valueOf(role.toUpperCase())
                : null;
        return ResponseEntity.ok(principalService.getUserOversight(queryRole));
    }

    @PostMapping("/users/{userId}/reset-password")
    public ResponseEntity<Map<String, String>> forcePasswordReset(@PathVariable Long userId) {
        principalService.forcePasswordReset(userId);
        return ResponseEntity.ok(Map.of("message", "Password reset successfully to default logic."));
    }

    // Academic Control (Freeze Logic)
    @GetMapping("/academic-control")
    public ResponseEntity<AcademicControl> getAcademicControl(
            @RequestParam String academicYear,
            @RequestParam String semester) {
        return ResponseEntity.ok(principalService.getAcademicControl(academicYear, semester));
    }

    @PostMapping("/academic-control")
    public ResponseEntity<AcademicControl> updateAcademicControl(@RequestBody AcademicControl control) {
        return ResponseEntity.ok(principalService.updateAcademicControl(control));
    }

    // Department & HOD Management
    @GetMapping("/departments")
    public ResponseEntity<List<Map<String, Object>>> getDepartments() {
        return ResponseEntity.ok(principalService.getDepartmentsWithHod());
    }

    @PostMapping("/departments/{deptId}/assign-hod/{facultyId}")
    public ResponseEntity<Void> assignHod(@PathVariable Long deptId, @PathVariable Long facultyId) {
        principalService.assignHod(deptId, facultyId);
        return ResponseEntity.ok().build();
    }
}
