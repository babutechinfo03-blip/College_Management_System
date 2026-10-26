package com.college.erp.controller;

import com.college.erp.service.PrincipalApprovalService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/principal/approvals")
@RequiredArgsConstructor
@PreAuthorize("hasRole('PRINCIPAL')")
@CrossOrigin(origins = "*", maxAge = 3600)
public class PrincipalApprovalController {

    private final PrincipalApprovalService principalApprovalService;

    @GetMapping("/pending")
    public ResponseEntity<Map<String, Object>> getPendingApprovals() {
        return ResponseEntity.ok(principalApprovalService.getPendingApprovals());
    }

    @PostMapping("/timetables/{id}")
    public ResponseEntity<Void> processTimetableApproval(
            @PathVariable Long id,
            @RequestParam boolean approve,
            @RequestParam(required = false) String remarks) {
        principalApprovalService.approveTimetable(id, approve, remarks);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/circulars/{id}")
    public ResponseEntity<Void> processCircularApproval(
            @PathVariable Long id,
            @RequestParam boolean approve,
            @RequestParam(required = false) String remarks) {
        principalApprovalService.approveCircular(id, approve, remarks);
        return ResponseEntity.ok().build();
    }
}
