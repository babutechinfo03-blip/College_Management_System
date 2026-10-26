package com.college.erp.controller;

import com.college.erp.dto.LoginRequest;
import com.college.erp.dto.JwtResponse;
import com.college.erp.security.JwtUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import com.college.erp.entity.User;
import com.college.erp.repository.UserRepository;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtUtils jwtUtils;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private com.college.erp.repository.FacultyRepository facultyRepository;

    @PostMapping("/principal/login")
    public ResponseEntity<?> principalLogin(@RequestBody LoginRequest loginRequest) {
        return authenticateWithRole(loginRequest, "PRINCIPAL");
    }

    @PostMapping("/office/login")
    public ResponseEntity<?> officeLogin(@RequestBody LoginRequest loginRequest) {
        return authenticateWithRole(loginRequest, "OFFICE");
    }

    @PostMapping("/staff/login")
    public ResponseEntity<?> staffLogin(@RequestBody LoginRequest loginRequest) {
        return authenticateWithRoles(loginRequest, java.util.List.of("HOD", "FACULTY", "ADVISOR"));
    }

    @PostMapping("/assistant/login")
    public ResponseEntity<?> assistantLogin(@RequestBody LoginRequest loginRequest) {
        return authenticateWithRole(loginRequest, "ASSISTANT_STAFF");
    }

    @PostMapping("/student/login")
    public ResponseEntity<?> studentLogin(@RequestBody LoginRequest loginRequest) {
        return authenticateWithRole(loginRequest, "STUDENT");
    }

    @PostMapping("/parent/login")
    public ResponseEntity<?> parentLogin(@RequestBody LoginRequest loginRequest) {
        return authenticateWithRole(loginRequest, "PARENT");
    }

    // Unified login endpoint to handle any valid user
    @PostMapping("/login")
    public ResponseEntity<?> unifiedLogin(@RequestBody LoginRequest loginRequest) {
        logger.info("=== Unified Login Attempt ===");
        logger.info("Username: {}", loginRequest.username());

        try {
            // Step 1: Authenticate credentials
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginRequest.username(), loginRequest.password()));

            SecurityContextHolder.getContext().setAuthentication(authentication);
            org.springframework.security.core.userdetails.User userDetails = (org.springframework.security.core.userdetails.User) authentication
                    .getPrincipal();

            // Step 2: Fetch user to identify role
            User user = userRepository.findByUsername(userDetails.getUsername())
                    .orElseThrow(() -> new RuntimeException("User not found"));

            String userRole = user.getRole().name();
            logger.info("✓ Login Success. Role: {}", userRole);

            // Step 4: Proceed with normal authentication completion
            // We can reuse a common private method for the last bits of response generation
            return completeAuthentication(user, userDetails);

        } catch (org.springframework.security.authentication.BadCredentialsException e) {
            return ResponseEntity.status(401).body(java.util.Map.of("message", "Invalid username or password"));
        } catch (Exception e) {
            logger.error("Error in unified login: {}", e.getMessage());
            return ResponseEntity.status(500).body(java.util.Map.of("message", "Authentication failed"));
        }
    }

    // Helper to complete authentication and generate response
    private ResponseEntity<?> completeAuthentication(User user,
            org.springframework.security.core.userdetails.User userDetails) {
        if (!user.isActive()) {
            return ResponseEntity.status(403).body(java.util.Map.of("message", "Account is disabled"));
        }

        String jwt = jwtUtils.generateToken(user.getUsername());

        java.util.List<String> staffRoles = new java.util.ArrayList<>();
        if (java.util.List.of("FACULTY", "HOD", "ADVISOR").contains(user.getRole().name())) {
            facultyRepository.findByUser(user).ifPresent(faculty -> {
                if (faculty.getRoles() != null) {
                    faculty.getRoles().forEach(sr -> staffRoles.add(sr.getRole().name()));
                }
            });
        }

        return ResponseEntity
                .ok(new JwtResponse(jwt, user.getUsername(), user.getRole().name(), user.getEmail(), staffRoles));
    }

    // Helper method for single role validation
    private ResponseEntity<?> authenticateWithRole(LoginRequest loginRequest, String expectedRole) {
        return authenticateWithRoles(loginRequest, java.util.List.of(expectedRole));
    }

    // Helper method for multiple role validation (e.g., staff can be HOD, FACULTY,
    // or ADVISOR)
    private ResponseEntity<?> authenticateWithRoles(LoginRequest loginRequest, java.util.List<String> allowedRoles) {
        logger.info("=== Authentication Attempt ===");
        logger.info("Username: {}", loginRequest.username());
        logger.info("Allowed Roles: {}", allowedRoles);

        try {
            // Step 1: Authenticate username and password
            logger.debug("Step 1: Authenticating credentials...");
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginRequest.username(), loginRequest.password()));

            logger.info("✓ Authentication successful");
            logger.debug("Password verification passed for user: {}", loginRequest.username());
            SecurityContextHolder.getContext().setAuthentication(authentication);

            org.springframework.security.core.userdetails.User userDetails = (org.springframework.security.core.userdetails.User) authentication
                    .getPrincipal();

            // Step 2: Find the actual User entity to get role
            logger.debug("Step 2: Fetching user entity...");
            User user = userRepository.findByUsername(userDetails.getUsername()).orElseThrow(
                    () -> new RuntimeException("User not found"));
            String userRole = user.getRole().name();
            logger.info("User Role from DB: {}", userRole);
            logger.info("User Active Status: {}", user.isActive());

            // Check if user is active
            if (!user.isActive()) {
                logger.warn("✗ Login rejected: User account is disabled");
                return ResponseEntity.status(403).body(
                        java.util.Map.of("message", "Account is disabled. Please contact administrator."));
            }

            // Step 3: SECURITY - Hard role validation - reject if role doesn't match
            // endpoint
            logger.debug("Step 3: Validating role...");
            if (!allowedRoles.contains(userRole)) {
                logger.warn("✗ Role validation failed: Expected {}, Got {}", allowedRoles, userRole);
                return ResponseEntity.status(403).body(
                        java.util.Map.of(
                                "message", "Unauthorized role for this login. Please use the correct login page.",
                                "allowedRoles", allowedRoles,
                                "actualRole", userRole));
            }

            logger.info("✓ Role validation passed");

            // Proceed with normal authentication completion
            return completeAuthentication(user, userDetails);

        } catch (org.springframework.security.authentication.BadCredentialsException e) {
            logger.error("✗ Authentication failed: Bad credentials for user '{}'", loginRequest.username());
            return ResponseEntity.status(401).body(
                    java.util.Map.of("message", "Invalid username or password"));
        } catch (org.springframework.security.core.userdetails.UsernameNotFoundException e) {
            logger.error("✗ Authentication failed: User '{}' not found", loginRequest.username());
            return ResponseEntity.status(401).body(
                    java.util.Map.of("message", "User not found"));
        } catch (Exception e) {
            logger.error("✗ Authentication failed with exception: {}", e.getMessage(), e);
            return ResponseEntity.status(500).body(
                    java.util.Map.of("message", "Authentication failed: " + e.getMessage()));
        }
    }
}
