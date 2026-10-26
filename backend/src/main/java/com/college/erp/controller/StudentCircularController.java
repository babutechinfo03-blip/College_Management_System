package com.college.erp.controller;

import com.college.erp.entity.User;
import com.college.erp.entity.circular.Circular;
import com.college.erp.service.CircularService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@RestController
@RequestMapping("/api/students/circulars")
@CrossOrigin(origins = "*", maxAge = 3600)
public class StudentCircularController {

    @Autowired
    private CircularService circularService;

    @GetMapping
    @PreAuthorize("hasRole('STUDENT')")
    public ResponseEntity<List<Circular>> getMyCirculars(@AuthenticationPrincipal User user) {
        List<Circular> feed = circularService.getCircularFeedForUser(user.getId());
        return ResponseEntity.ok(feed);
    }

    @PostMapping("/{id}/read")
    @PreAuthorize("hasRole('STUDENT')")
    public ResponseEntity<?> markAsRead(@AuthenticationPrincipal User user, @PathVariable Long id) {
        circularService.markAsRead(id, user.getId());
        return ResponseEntity.ok().build();
    }
}
