package com.college.erp.dto;

import java.util.List;

public record JwtResponse(String token, String username, String role, String email, List<String> staffRoles) {
}
