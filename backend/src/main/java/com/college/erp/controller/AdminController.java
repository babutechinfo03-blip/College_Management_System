package com.college.erp.controller;

import com.college.erp.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@RestController
@RequestMapping("/api/admin")
@PreAuthorize("hasRole('PRINCIPAL')")
public class AdminController {
    @Autowired
    private AdminService adminService;

    @GetMapping("/stats")
    public ResponseEntity<Map<String, Object>> getDashboardStats() {
        return ResponseEntity.ok(adminService.getDashboardStats());
    }

    // --- Master Data Management ---
    @PostMapping("/departments")
    public ResponseEntity<?> createDepartment(@RequestBody com.college.erp.entity.Department dept) {
        return ResponseEntity.ok(adminService.saveDepartment(dept));
    }

    @GetMapping("/departments")
    public ResponseEntity<?> getAllDepartments() {
        return ResponseEntity.ok(adminService.getAllDepartments());
    }

    // --- User & Role Management ---
    @GetMapping("/users")
    public ResponseEntity<?> getAllUsers() {
        return ResponseEntity.ok(adminService.getAllUsers());
    }

    @PutMapping("/users/{userId}/status")
    public ResponseEntity<?> updateUserStatus(@PathVariable Long userId, @RequestParam boolean active) {
        adminService.updateUserStatus(userId, active);
        return ResponseEntity.ok().build();
    }

    // --- Staff Management ---
    @GetMapping("/staff")
    public ResponseEntity<?> getAllStaff() {
        return ResponseEntity.ok(adminService.getAllStaff());
    }

    // --- Student Management ---
    @GetMapping("/students")
    public ResponseEntity<?> getAllStudents() {
        return ResponseEntity.ok(adminService.getAllStudents());
    }
}
