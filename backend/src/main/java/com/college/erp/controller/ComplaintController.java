package com.college.erp.controller;

import com.college.erp.entity.Complaint;
import com.college.erp.entity.ComplaintStatus;
import com.college.erp.service.ComplaintService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/complaints")
public class ComplaintController {
    @Autowired
    private ComplaintService complaintService;

    @PostMapping
    public ResponseEntity<Complaint> submitComplaint(@RequestBody Complaint complaint) {
        return ResponseEntity.ok(complaintService.submitComplaint(complaint));
    }

    @PutMapping("/{id}/status")
    @PreAuthorize("hasRole('PRINCIPAL') or hasRole('HOD')")
    public ResponseEntity<Complaint> updateStatus(@PathVariable long id, @RequestParam ComplaintStatus status) {
        return ResponseEntity.ok(complaintService.updateStatus(id, status));
    }

    @GetMapping("/all")
    @PreAuthorize("hasRole('PRINCIPAL')")
    public ResponseEntity<List<Complaint>> getAllComplaints() {
        return ResponseEntity.ok(complaintService.getAllComplaints());
    }
}
