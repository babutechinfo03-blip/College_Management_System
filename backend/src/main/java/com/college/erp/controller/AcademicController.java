package com.college.erp.controller;

import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class AcademicController {

    @GetMapping("/degrees")
    public List<Map<String, String>> getDegrees(@RequestParam(required = false) String programType) {
        System.out.println("AUDIT: [AcademicController] getDegrees called with programType: '" + programType + "'");

        if (programType == null || programType.trim().isEmpty()) {
            System.out.println("AUDIT: programType is null or empty, returning empty list");
            return new ArrayList<>();
        }

        String type = programType.trim().toUpperCase();
        List<Map<String, String>> degrees = new ArrayList<>();

        if (type.equals("UG") || type.contains("UNDERGRADUATE")) {
            degrees.add(Map.of("code", "BE", "name", "B.E"));
            degrees.add(Map.of("code", "BTECH", "name", "B.Tech"));
        } else if (type.equals("PG") || type.contains("POSTGRADUATE")) {
            degrees.add(Map.of("code", "ME", "name", "M.E"));
            degrees.add(Map.of("code", "MTECH", "name", "M.Tech"));
            degrees.add(Map.of("code", "MBA", "name", "MBA"));
            degrees.add(Map.of("code", "MCA", "name", "MCA"));
            degrees.add(Map.of("code", "VLSI", "name", "VLSI Design"));
        } else {
            System.out.println("AUDIT: Unrecognized programType: " + type);
        }

        System.out.println("AUDIT: [AcademicController] Returning Degrees: " + degrees);
        return degrees;
    }

    @GetMapping("/sub-departments")
    public List<String> getSubDepartments(@RequestParam(required = false) String degree) {
        System.out.println("AUDIT: [AcademicController] getSubDepartments called with degree: '" + degree + "'");

        if (degree == null || degree.trim().isEmpty()) {
            System.out.println("AUDIT: degree is null or empty, returning empty list");
            return new ArrayList<>();
        }

        String code = degree.trim().toUpperCase();
        List<String> subDepts = new ArrayList<>();

        switch (code) {
            case "BE":
                subDepts = List.of("CSE", "ECE", "EEE", "CIVIL", "MECH");
                break;
            case "BTECH":
                subDepts = List.of("IT");
                break;
            case "ME":
                subDepts = List.of("CSE", "ECE", "EEE", "MECH");
                break;
            case "MTECH":
                subDepts = List.of("IT");
                break;
            case "MBA":
                subDepts = List.of("MBA");
                break;
            case "MCA":
                subDepts = List.of("MCA");
                break;
            case "VLSI":
                subDepts = List.of("VLSI DESIGN");
                break;
            default:
                System.out.println("AUDIT: Unrecognized degree code: " + code);
                subDepts = new ArrayList<>();
        }

        System.out.println("AUDIT: [AcademicController] Returning Sub-Departments: " + subDepts);
        return subDepts;
    }
}
