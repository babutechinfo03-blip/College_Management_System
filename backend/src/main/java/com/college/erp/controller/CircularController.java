package com.college.erp.controller;

import com.college.erp.entity.User;
import com.college.erp.entity.circular.Circular;
import com.college.erp.entity.circular.CircularTarget;
import com.college.erp.service.CircularService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/api/circulars")
public class CircularController {

    @Autowired
    private CircularService circularService;

    @Autowired
    private ObjectMapper objectMapper;

    @PostMapping
    public ResponseEntity<?> createCircular(
            @AuthenticationPrincipal User user,
            @RequestPart("data") String dataJson,
            @RequestPart(value = "file", required = false) MultipartFile file) throws JsonProcessingException {

        // Parse the Circular Request DTO
        // Expecting { circular: {...}, targets: [...] }
        CircularRequestDto request = objectMapper.readValue(dataJson, CircularRequestDto.class);

        Circular created = circularService.createCircular(request.getCircular(), request.getTargets(), user.getId(),
                file);
        return ResponseEntity.ok(created);
    }

    @GetMapping("/feed")
    public ResponseEntity<List<Circular>> getFeed(@AuthenticationPrincipal User user) {
        List<Circular> feed = circularService.getCircularFeedForUser(user.getId());
        return ResponseEntity.ok(feed);
    }

    @PostMapping("/{id}/read")
    public ResponseEntity<?> markAsRead(@AuthenticationPrincipal User user, @PathVariable Long id) {
        return ResponseEntity.ok(circularService.markAsRead(id, user.getId()));
    }

    @PostMapping("/{id}/acknowledge")
    public ResponseEntity<?> acknowledge(@AuthenticationPrincipal User user, @PathVariable Long id) {
        return ResponseEntity.ok(circularService.acknowledge(id, user.getId()));
    }

    @GetMapping("/pending/{departmentId}")
    public ResponseEntity<?> getPendingApprovals(@PathVariable Long departmentId) {
        return ResponseEntity.ok(circularService.getPendingApprovalsForHod(departmentId));
    }

    @PostMapping("/{id}/approve")
    public ResponseEntity<?> approveCircular(
            @AuthenticationPrincipal User user,
            @PathVariable Long id,
            @RequestParam boolean approve) {
        return ResponseEntity.ok(circularService.approveCircular(id, user.getId(), approve));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteCircular(@PathVariable Long id) {
        circularService.deleteCircular(id);
        return ResponseEntity.ok().build();
    }

    // DTO for incoming request parsing
    public static class CircularRequestDto {
        private Circular circular;
        private List<CircularTarget> targets;

        public Circular getCircular() {
            return circular;
        }

        public void setCircular(Circular circular) {
            this.circular = circular;
        }

        public List<CircularTarget> getTargets() {
            return targets;
        }

        public void setTargets(List<CircularTarget> targets) {
            this.targets = targets;
        }
    }
}
