package com.college.erp.controller;

import com.college.erp.entity.*;
import com.college.erp.entity.Faculty;
import com.college.erp.repository.*;
import com.college.erp.service.FileStorageService;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/office")
@PreAuthorize("hasRole('OFFICE')")
public class OfficeController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private FacultyRepository facultyRepository;

    @Autowired
    private AssistantStaffRepository assistantStaffRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private DegreeRepository degreeRepository;

    @Autowired
    private SpecializationRepository specializationRepository;

    @Autowired
    private DepartmentRepository departmentRepository;

    @Autowired
    private StaffRoleRepository staffRoleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private AuditLogRepository auditLogRepository;

    @Autowired
    private FileStorageService fileStorageService;

    @Autowired
    private com.fasterxml.jackson.databind.ObjectMapper objectMapper;

    // ==================== Academic Hierarchy Endpoints ====================

    @GetMapping("/degrees")
    public ResponseEntity<List<Map<String, String>>> getDegrees(@RequestParam String programType) {
        System.out.println("DEBUG: getDegrees called with programType: " + programType);
        List<Map<String, String>> degrees = new ArrayList<>();
        if ("UG".equalsIgnoreCase(programType)) {
            degrees.add(Map.of("code", "BE", "name", "B.E"));
            degrees.add(Map.of("code", "BTECH", "name", "B.Tech"));
        } else if ("PG".equalsIgnoreCase(programType)) {
            degrees.add(Map.of("code", "ME", "name", "M.E"));
            degrees.add(Map.of("code", "MTECH", "name", "M.Tech"));
            degrees.add(Map.of("code", "MBA", "name", "MBA"));
            degrees.add(Map.of("code", "MCA", "name", "MCA"));
            degrees.add(Map.of("code", "VLSI", "name", "VLSI Design"));
        }
        return ResponseEntity.ok(degrees);
    }

    @GetMapping("/sub-departments")
    public ResponseEntity<List<String>> getSubDepartments(@RequestParam String degree) {
        System.out.println("DEBUG: getSubDepartments called with degree: " + degree);
        List<String> subDepts = new ArrayList<>();
        if ("BE".equalsIgnoreCase(degree)) {
            subDepts.add("CSE");
            subDepts.add("ECE");
            subDepts.add("EEE");
            subDepts.add("CIVIL");
            subDepts.add("MECH");
        } else if ("BTECH".equalsIgnoreCase(degree)) {
            subDepts.add("IT");
        } else if ("ME".equalsIgnoreCase(degree)) {
            subDepts.add("CSE");
            subDepts.add("ECE");
            subDepts.add("EEE");
            subDepts.add("MECH");
        } else if ("MTECH".equalsIgnoreCase(degree)) {
            subDepts.add("IT");
        } else if ("MBA".equalsIgnoreCase(degree)) {
            subDepts.add("MBA");
        } else if ("MCA".equalsIgnoreCase(degree)) {
            subDepts.add("MCA");
        } else if ("VLSI".equalsIgnoreCase(degree)) {
            subDepts.add("VLSI");
        }
        return ResponseEntity.ok(subDepts);
    }

    // ==================== Dashboard Stats Endpoint ====================

    @GetMapping("/dashboard/stats")
    public ResponseEntity<Map<String, Object>> getDashboardStats() {
        long totalStudents = studentRepository.countByIsActiveTrue();
        long totalFaculty = facultyRepository.countByIsActiveTrue();
        long totalAssistants = assistantStaffRepository.countByIsActiveTrue();

        Map<String, Object> stats = new HashMap<>();
        stats.put("totalStudents", totalStudents);
        stats.put("totalFaculty", totalFaculty);
        stats.put("totalAssistants", totalAssistants);

        return ResponseEntity.ok(stats);
    }

    @GetMapping("/activity")
    public ResponseEntity<List<AuditLog>> getActivities() {
        return ResponseEntity.ok(auditLogRepository.findTop50ByOrderByTimestampDesc());
    }

    // ==================== Student Management Endpoints ====================

    @GetMapping("/staff")

    public ResponseEntity<List<Map<String, Object>>> getFaculty(
            @RequestParam(required = false) Boolean isActive,
            @RequestParam(required = false) String role) {
        List<Faculty> staffList;
        if (isActive != null) {
            staffList = facultyRepository.findByUserActive(isActive);
        } else {
            staffList = facultyRepository.findAll();
        }

        if (role != null && !role.isEmpty()) {
            staffList = staffList.stream()
                    .filter(staff -> staff.getRoles().stream()
                            .anyMatch(r -> r.getRole().name().equals(role)))
                    .collect(Collectors.toList());
        }

        return ResponseEntity.ok(staffList.stream()
                .map(this::facultyToMap)
                .collect(Collectors.toList()));
    }

    @GetMapping("/debug-students")
    public ResponseEntity<Map<String, Object>> debugStudents() {
        long totalCount = studentRepository.count();
        long activeCount = studentRepository.countByIsActiveTrue();
        List<Student> allStudents = studentRepository.findAll();

        List<String> details = allStudents.stream()
                .map(s -> "ID: " + s.getId() + ", StudentID: " + s.getStudentId() + ", Name: " + s.getFirstName()
                        + (s.getDegree() != null ? ", Degree: " + s.getDegree().getCode() : ", No Degree"))
                .collect(Collectors.toList());

        Map<String, Object> debugInfo = new HashMap<>();
        debugInfo.put("totalCount", totalCount);
        debugInfo.put("activeCount", activeCount);
        debugInfo.put("details", details);

        return ResponseEntity.ok(debugInfo);
    }

    @GetMapping("/assistant-staff")
    public ResponseEntity<List<Map<String, Object>>> getAssistantStaff(
            @RequestParam(required = false) Boolean isActive) {
        List<AssistantStaff> staffList;
        if (isActive != null) {
            staffList = assistantStaffRepository.findByUserActive(isActive);
        } else {
            staffList = assistantStaffRepository.findAll();
        }
        return ResponseEntity.ok(staffList.stream()
                .map(this::assistantStaffToMap)
                .collect(Collectors.toList()));
    }

    @GetMapping("/students")
    @Transactional(readOnly = true)
    public ResponseEntity<List<Map<String, Object>>> getStudents(
            @RequestParam(required = false) String degree,
            @RequestParam(required = false) String specialization,
            @RequestParam(required = false) Integer year,
            @RequestParam(required = false) Boolean isActive) {

        try {
            System.out
                    .println("DEBUG: getStudents request - degree: " + degree + ", spec: " + specialization + ", year: "
                            + year + ", isActive: " + isActive);
            List<Student> students = studentRepository.findAll();
            System.out.println("DEBUG: studentRepository.findAll() returned " + students.size() + " items");

            // Apply filters
            if (degree != null && !degree.isEmpty()) {
                students = students.stream()
                        .filter(s -> s.getDegree() != null && s.getDegree().getCode().equals(degree))
                        .collect(Collectors.toList());
                System.out.println("DEBUG: After degree filter (" + degree + "): " + students.size());
            }
            if (specialization != null && !specialization.isEmpty()) {
                students = students.stream()
                        .filter(s -> s.getSpecialization() != null
                                && s.getSpecialization().getCode().equals(specialization))
                        .collect(Collectors.toList());
                System.out.println("DEBUG: After specialization filter (" + specialization + "): " + students.size());
            }
            if (year != null) {
                students = students.stream()
                        .filter(s -> s.getCurrentYear() == year)
                        .collect(Collectors.toList());
                System.out.println("DEBUG: After year filter (" + year + "): " + students.size());
            }

            // Filter by isActive only if specified
            if (isActive != null) {
                students = students.stream()
                        .filter(s -> s.isActive() == isActive)
                        .collect(Collectors.toList());
                System.out.println("DEBUG: After isActive filter (" + isActive + "): " + students.size());
            }

            List<Map<String, Object>> result = students.stream().map(this::studentToMap).collect(Collectors.toList());
            System.out.println("DEBUG: Returning " + result.size() + " student maps");
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            System.err.println("FATAL ERROR in getStudents: " + e.getMessage());
            e.printStackTrace();
            Map<String, Object> errorMap = new HashMap<>();
            errorMap.put("error", "Internal Server Error");
            errorMap.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(List.of(errorMap));
        }
    }

    @PutMapping("/students/{id}")
    @Transactional
    public ResponseEntity<?> updateStudent(@PathVariable Long id, @RequestBody Map<String, Object> data) {
        try {
            Optional<Student> optStudent = studentRepository.findById(id);
            if (!optStudent.isPresent()) {
                return ResponseEntity.notFound().build();
            }

            Student student = optStudent.get();
            student.setFirstName((String) data.get("firstName"));
            student.setLastName((String) data.get("lastName"));
            student.setCurrentYear(Integer.parseInt(data.get("currentYear").toString()));
            student.setCurrentSemester(Integer.parseInt(data.get("currentSemester").toString()));
            student.setBatch((String) data.get("batch"));
            student.setParentName((String) data.get("parentName"));
            student.setParentMobile((String) data.get("parentMobile"));
            student.setDob((String) data.get("dob"));
            student.setAddress((String) data.get("address"));
            student.setPhone((String) data.get("phone"));
            student.setWhatsappNumber((String) data.get("whatsappNumber"));
            student.setBloodGroup((String) data.get("bloodGroup"));
            student.setCaste((String) data.get("caste"));
            student.setReligion((String) data.get("religion"));

            // Degree & Specialization
            if (data.get("degreeId") != null) {
                degreeRepository.findByCode((String) data.get("degreeId"))
                        .ifPresent(d -> student.setDegree(d));
            }
            if (data.get("specializationId") != null) {
                specializationRepository.findByCode((String) data.get("specializationId"))
                        .ifPresent(s -> student.setSpecialization(s));
            }

            // User updates (Email & Password)
            User user = student.getUser();
            if (data.get("email") != null) {
                user.setEmail((String) data.get("email"));
            }
            if (data.get("password") != null && !((String) data.get("password")).isEmpty()) {
                String plainPassword = (String) data.get("password");
                user.setPassword(passwordEncoder.encode(plainPassword));
                user.setVisiblePassword(plainPassword);
            }
            userRepository.save(user);

            studentRepository.save(student);

            logAction("UPDATE_STUDENT", "Updated student: " + student.getStudentId());
            return ResponseEntity.ok(Map.of("message", "Student updated successfully"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @DeleteMapping("/students/{id}")
    @Transactional
    public ResponseEntity<?> deleteStudent(@PathVariable Long id) {
        try {
            Optional<Student> optStudent = studentRepository.findById(id);
            if (!optStudent.isPresent()) {
                return ResponseEntity.notFound().build();
            }

            Student student = optStudent.get();
            User user = student.getUser();

            // Hard delete student first (foreign key owner)
            studentRepository.delete(student);

            // Then delete user if exists
            if (user != null) {
                userRepository.delete(user);
            }

            logAction("DELETE_STUDENT", "Deleted student: " + student.getStudentId());
            return ResponseEntity.ok(Map.of("message", "Student deleted successfully"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    // ... (rest of methods until deleteStaff)

    @PutMapping("/staff/{id}")
    @Transactional
    public ResponseEntity<?> updateStaff(@PathVariable Long id, @RequestBody Map<String, Object> data) {
        try {
            Optional<Faculty> optStaff = facultyRepository.findById(id);
            if (!optStaff.isPresent()) {
                return ResponseEntity.notFound().build();
            }

            Faculty staff = optStaff.get();
            staff.setFirstName((String) data.get("firstName"));
            staff.setLastName((String) data.get("lastName"));
            staff.setDesignation((String) data.get("designation"));
            staff.setPhone((String) data.get("phone"));
            staff.setWhatsappNumber((String) data.get("whatsappNumber"));
            staff.setDob((String) data.get("dob"));
            staff.setAddress((String) data.get("address"));
            staff.setBloodGroup((String) data.get("bloodGroup"));

            if (data.get("departmentId") != null) {
                // Determine if it's an ID (Long) or Code (String). Using Code based on other
                // methods.
                // Assuming payload sends 'departmentId' as code like 'CSE'
                Object deptVal = data.get("departmentId");
                if (deptVal instanceof String) {
                    departmentRepository.findByCode((String) deptVal).ifPresent(staff::setDepartment);
                }
            }

            // Role updates
            if (data.get("roles") != null) {
                List<String> roleNames = (List<String>) data.get("roles");
                // Clear existing roles logic if necessary, or just rely on manual management?
                // For now, let's assume we don't fully support complex role reassignment here
                // unless requested,
                // but we can try basic check.
                // Actually, StaffRole management is complex. Let's skip updating roles array
                // for now in this simple update,
                // or just leave it as is. The user mainly asked for password/username.
            }

            // User updates
            User user = staff.getUser();
            if (data.get("email") != null) {
                user.setEmail((String) data.get("email"));
            }
            if (data.get("password") != null && !((String) data.get("password")).isEmpty()) {
                String plainPassword = (String) data.get("password");
                user.setPassword(passwordEncoder.encode(plainPassword));
                user.setVisiblePassword(plainPassword);
            }
            userRepository.save(user);

            facultyRepository.save(staff);

            logAction("UPDATE_STAFF", "Updated staff: " + staff.getStaffId());
            return ResponseEntity.ok(Map.of("message", "Staff updated successfully"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @DeleteMapping("/staff/{id}")
    @Transactional
    public ResponseEntity<?> deleteStaff(@PathVariable Long id) {
        try {
            Optional<Faculty> optStaff = facultyRepository.findById(id);
            if (!optStaff.isPresent()) {
                return ResponseEntity.notFound().build();
            }

            Faculty staff = optStaff.get();
            User user = staff.getUser();

            // Deleting staff roles first if no cascade exists (assuming StaffRole has FK to
            // Faculty)
            // But usually Cascade DELETE is on OneToMany in Faculty -> StaffRoles. Let's
            // assume JPA handles it or we rely on DB cascade.
            // If not, we might need: staffRoleRepository.deleteByFaculty(staff);
            // Updating clean up for User:

            // Hard delete staff
            facultyRepository.delete(staff);

            // Delete user
            if (user != null) {
                userRepository.delete(user);
            }

            logAction("DELETE_STAFF", "Deleted staff: " + staff.getStaffId());
            return ResponseEntity.ok(Map.of("message", "Staff deleted successfully"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    // ... (rest of methods until deleteAssistantStaff)

    @DeleteMapping("/assistant-staff/{id}")
    @Transactional
    public ResponseEntity<?> deleteAssistantStaff(@PathVariable Long id) {
        try {
            Optional<AssistantStaff> optStaff = assistantStaffRepository.findById(id);
            if (!optStaff.isPresent()) {
                return ResponseEntity.notFound().build();
            }

            AssistantStaff staff = optStaff.get();
            User user = staff.getUser();

            // Hard delete assistant staff
            assistantStaffRepository.delete(staff);

            // Delete user
            if (user != null) {
                userRepository.delete(user);
            }

            logAction("DELETE_ASSISTANT_STAFF", "Deleted assistant staff: " + staff.getAssistantId());
            return ResponseEntity.ok(Map.of("message", "Assistant Staff deleted successfully"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PostMapping(value = "/students", consumes = org.springframework.http.MediaType.MULTIPART_FORM_DATA_VALUE)
    @Transactional
    public ResponseEntity<?> createStudent(
            @RequestPart("data") String dataJson,
            @RequestPart(value = "photo", required = false) MultipartFile photo) {
        try {
            Map<String, Object> data = objectMapper.readValue(dataJson,
                    new com.fasterxml.jackson.core.type.TypeReference<Map<String, Object>>() {
                    });

            String studentId = (String) data.get("studentId");
            String email = (String) data.get("email");

            if (userRepository.findByUsername(studentId).isPresent()) {
                return ResponseEntity.badRequest()
                        .body(Map.of("error", "Student ID already exists"));
            }

            if (userRepository.findByEmail(email).isPresent()) {
                return ResponseEntity.badRequest()
                        .body(Map.of("error", "Email already exists"));
            }

            User user = User.builder()
                    .username(studentId)
                    .password(passwordEncoder.encode((String) data.get("password")))
                    .email(email)
                    .role(Role.STUDENT)
                    .visiblePassword((String) data.get("password"))
                    .active(true)
                    .createdAt(java.time.LocalDateTime.now())
                    .build();
            userRepository.save(user);

            Degree degree = degreeRepository.findByCode((String) data.get("degreeId")).orElse(null);

            Student student = Student.builder()
                    .studentId(studentId)
                    .firstName((String) data.get("firstName"))
                    .lastName((String) data.get("lastName"))
                    .user(user)
                    .degree(degree)
                    .specialization(degree != null
                            ? specializationRepository
                                    .findByDegreeAndCode(degree, (String) data.get("specializationId")).orElse(null)
                            : null)
                    .currentYear(Integer.parseInt(data.get("currentYear").toString()))
                    .currentSemester(Integer.parseInt(data.get("currentSemester").toString()))
                    .batch((String) data.get("batch"))
                    .parentName((String) data.get("parentName"))
                    .parentMobile((String) data.get("parentMobile"))
                    .dob((String) data.get("dob"))
                    .address((String) data.get("address"))
                    .phone((String) data.get("phone"))
                    .whatsappNumber((String) data.get("whatsappNumber"))
                    .bloodGroup((String) data.get("bloodGroup"))
                    .caste((String) data.get("caste"))
                    .religion((String) data.get("religion"))
                    .isActive(true)
                    .build();

            if (photo != null && !photo.isEmpty()) {
                String photoPath = fileStorageService.savePhoto(photo, "students");
                student.setPhotoPath(photoPath);
            }

            studentRepository.save(student);

            logAction("CREATE_STUDENT", "Created student: " + studentId);
            return ResponseEntity.ok(Map.of("message", "Student created successfully", "id", student.getId(),
                    "studentId", studentId));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PostMapping(value = "/assistant-staff", consumes = org.springframework.http.MediaType.MULTIPART_FORM_DATA_VALUE)
    @Transactional
    public ResponseEntity<?> createAssistantStaff(
            @RequestPart("data") String dataJson,
            @RequestPart(value = "photo", required = false) MultipartFile photo) {
        try {
            Map<String, Object> data = objectMapper.readValue(dataJson,
                    new com.fasterxml.jackson.core.type.TypeReference<Map<String, Object>>() {
                    });

            String staffId = "AST" + System.currentTimeMillis();
            String email = (String) data.get("email");

            if (userRepository.findByUsername(staffId).isPresent()) {
                return ResponseEntity.badRequest()
                        .body(Map.of("error", "Assistant ID collision, please try again"));
            }

            Optional<User> existingUser = userRepository.findByEmail(email);
            User user;
            if (existingUser.isPresent()) {
                user = existingUser.get();
                if (assistantStaffRepository.findByUser(user).isPresent()) {
                    return ResponseEntity.badRequest().body(Map.of("error", "Staff with this email already exists"));
                }
                if (user.getRole() == Role.STUDENT) {
                    return ResponseEntity.badRequest().body(Map.of("error",
                            "This email is registered to a Student. Cross-role reuse is blocked."));
                }
            } else {
                user = User.builder()
                        .username(staffId)
                        .password(passwordEncoder.encode((String) data.get("password")))
                        .email(email)
                        .role(Role.ASSISTANT_STAFF)
                        .active(true)
                        .build();
                userRepository.save(user);
            }

            AssistantStaff staff = AssistantStaff.builder()
                    .assistantId(staffId)
                    .firstName((String) data.get("firstName"))
                    .lastName((String) data.get("lastName"))
                    .designation((String) data.get("designation"))
                    .department(departmentRepository.findByCode((String) data.get("departmentId")).orElse(null))
                    .user(user)
                    .phone((String) data.get("phone"))
                    .whatsappNumber((String) data.get("whatsappNumber"))
                    .dob((String) data.get("dob"))
                    .address((String) data.get("address"))
                    .bloodGroup((String) data.get("bloodGroup"))
                    .isActive(true)
                    .build();

            if (photo != null && !photo.isEmpty()) {
                String photoPath = fileStorageService.savePhoto(photo, "staff");
                staff.setPhotoPath(photoPath);
            }

            assistantStaffRepository.save(staff);

            // Fixed role for Assistant Staff
            // Assistant Staff uses simple Role based access, no detailed StaffRoles yet
            // If needed, we can add AssistantStaffRole entity later.

            logAction("CREATE_ASSISTANT_STAFF", "Created assistant staff: " + staffId);
            return ResponseEntity
                    .ok(Map.of("message", "Assistant Staff created successfully", "id", staff.getId(), "staffId",
                            staffId));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PutMapping("/assistant-staff/{id}")
    @Transactional
    public ResponseEntity<?> updateAssistantStaff(@PathVariable Long id, @RequestBody Map<String, Object> data) {
        try {
            Optional<AssistantStaff> optStaff = assistantStaffRepository.findById(id);
            if (!optStaff.isPresent()) {
                return ResponseEntity.notFound().build();
            }

            AssistantStaff staff = optStaff.get();
            staff.setFirstName((String) data.get("firstName"));
            staff.setLastName((String) data.get("lastName"));
            staff.setDesignation((String) data.get("designation"));
            staff.setPhone((String) data.get("phone"));
            staff.setWhatsappNumber((String) data.get("whatsappNumber"));
            staff.setDob((String) data.get("dob"));
            staff.setAddress((String) data.get("address"));
            staff.setBloodGroup((String) data.get("bloodGroup"));

            // Department update
            if (data.get("departmentId") != null) {
                String deptId = (String) data.get("departmentId");
                departmentRepository.findByCode(deptId).ifPresent(staff::setDepartment);
            }

            // Email update
            if (data.get("email") != null) {
                staff.getUser().setEmail((String) data.get("email"));
            }

            // Password update
            if (data.get("password") != null && !((String) data.get("password")).isEmpty()) {
                String plainPassword = (String) data.get("password");
                staff.getUser().setPassword(passwordEncoder.encode(plainPassword));
                staff.getUser().setVisiblePassword(plainPassword);
            }
            userRepository.save(staff.getUser());

            assistantStaffRepository.save(staff);

            logAction("UPDATE_ASSISTANT_STAFF", "Updated assistant staff: " + staff.getAssistantId());
            return ResponseEntity.ok(Map.of("message", "Assistant Staff updated successfully"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PostMapping("/assistant-staff/{id}/photo")
    public ResponseEntity<?> uploadAssistantStaffPhoto(@PathVariable Long id,
            @RequestParam("photo") MultipartFile photo) {
        try {
            Optional<AssistantStaff> optStaff = assistantStaffRepository.findById(id);
            if (!optStaff.isPresent()) {
                return ResponseEntity.notFound().build();
            }

            AssistantStaff staff = optStaff.get();

            if (staff.getPhotoPath() != null) {
                fileStorageService.deletePhoto(staff.getPhotoPath());
            }

            String photoPath = fileStorageService.savePhoto(photo, "staff");
            staff.setPhotoPath(photoPath);
            assistantStaffRepository.save(staff);

            logAction("UPLOAD_ASSISTANT_PHOTO", "Uploaded photo for assistant: " + staff.getAssistantId());
            return ResponseEntity.ok(Map.of("message", "Photo uploaded successfully", "photoPath", photoPath));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PostMapping("/assistant-staff/{id}/reset-password")
    public ResponseEntity<?> resetAssistantStaffPassword(@PathVariable Long id, @RequestBody Map<String, String> data) {
        try {
            Optional<AssistantStaff> optStaff = assistantStaffRepository.findById(id);
            if (!optStaff.isPresent()) {
                return ResponseEntity.notFound().build();
            }

            AssistantStaff staff = optStaff.get();
            staff.getUser().setPassword(passwordEncoder.encode(data.get("newPassword")));
            userRepository.save(staff.getUser());

            logAction("RESET_ASSISTANT_PASSWORD", "Reset password for assistant: " + staff.getAssistantId());
            return ResponseEntity.ok(Map.of("message", "Password reset successfully"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PutMapping("/assistant-staff/{id}/toggle-status")
    public ResponseEntity<?> toggleAssistantStaffStatus(@PathVariable Long id) {
        try {
            Optional<AssistantStaff> optStaff = assistantStaffRepository.findById(id);
            if (!optStaff.isPresent()) {
                return ResponseEntity.notFound().build();
            }

            AssistantStaff staff = optStaff.get();
            staff.setActive(!staff.isActive());
            staff.getUser().setActive(staff.isActive());

            userRepository.save(staff.getUser());
            assistantStaffRepository.save(staff);

            logAction("TOGGLE_ASSISTANT_STATUS",
                    "Toggled status for assistant: " + staff.getAssistantId() + " to " + staff.isActive());
            return ResponseEntity.ok(Map.of("message", "Status updated successfully", "active", staff.isActive()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @GetMapping("/assistant-staff/{id}")
    public ResponseEntity<Map<String, Object>> getAssistantStaffMember(@PathVariable Long id) {
        Optional<AssistantStaff> staff = assistantStaffRepository.findById(id);
        if (staff.isPresent()) {
            return ResponseEntity.ok(assistantStaffToMap(staff.get()));
        }
        return ResponseEntity.notFound().build();
    }

    // ==================== Helper Methods ====================

    private void logAction(String action, String details) {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        auditLogRepository.save(AuditLog.builder()
                .action(action)
                .username(username)
                .userRole("OFFICE")
                .details(details)
                .build());
    }

    private Map<String, Object> studentToMap(Student student) {
        Map<String, Object> map = new HashMap<>();
        map.put("id", student.getId()); // Use getId() instead of direct field access
        map.put("studentId", student.getStudentId());
        map.put("firstName", student.getFirstName());
        map.put("lastName", student.getLastName() != null ? student.getLastName() : "");

        if (student.getUser() != null) {
            map.put("email", student.getUser().getEmail());
            map.put("visiblePassword", student.getUser().getVisiblePassword());
        } else {
            map.put("email", "");
            map.put("visiblePassword", null);
        }

        if (student.getDegree() != null) {
            Map<String, Object> degreeMap = new HashMap<>();
            degreeMap.put("id", student.getDegree().getId());
            degreeMap.put("name", student.getDegree().getName());
            degreeMap.put("code", student.getDegree().getCode());
            map.put("degree", degreeMap);
        } else {
            map.put("degree", null);
        }

        if (student.getSpecialization() != null) {
            Map<String, Object> specMap = new HashMap<>();
            specMap.put("id", student.getSpecialization().getId());
            specMap.put("name", student.getSpecialization().getName());
            specMap.put("code", student.getSpecialization().getCode());
            map.put("specialization", specMap);
        } else {
            map.put("specialization", null);
        }

        map.put("currentYear", student.getCurrentYear());
        map.put("currentSemester", student.getCurrentSemester());
        map.put("batch", student.getBatch());
        map.put("parentName", student.getParentName());
        map.put("parentMobile", student.getParentMobile());
        map.put("dob", student.getDob());
        map.put("address", student.getAddress());
        map.put("phone", student.getPhone());
        map.put("whatsappNumber", student.getWhatsappNumber());
        map.put("bloodGroup", student.getBloodGroup());
        map.put("caste", student.getCaste());
        map.put("religion", student.getReligion());
        map.put("photoPath", student.getPhotoPath());
        map.put("isActive", student.isActive());
        return map;
    }

    private Map<String, Object> assistantStaffToMap(AssistantStaff staff) {
        Map<String, Object> map = new HashMap<>();
        map.put("id", staff.getId());
        map.put("staffId", staff.getAssistantId());
        map.put("firstName", staff.getFirstName());
        map.put("lastName", staff.getLastName());
        map.put("email", staff.getUser() != null ? staff.getUser().getEmail() : "");
        map.put("visiblePassword", staff.getUser() != null ? staff.getUser().getVisiblePassword() : null);
        map.put("designation", staff.getDesignation());
        map.put("department",
                staff.getDepartment() != null
                        ? Map.of("id", staff.getDepartment().getId(), "name", staff.getDepartment().getName(), "code",
                                staff.getDepartment().getCode())
                        : null);
        map.put("phone", staff.getPhone());
        map.put("whatsappNumber", staff.getWhatsappNumber());
        map.put("dob", staff.getDob());
        map.put("address", staff.getAddress());
        map.put("bloodGroup", staff.getBloodGroup());
        map.put("photoPath", staff.getPhotoPath());
        map.put("isActive", staff.isActive());
        return map;
    }

    private Map<String, Object> facultyToMap(Faculty staff) {
        Map<String, Object> map = new HashMap<>();
        map.put("id", staff.getId());
        map.put("staffId", staff.getStaffId());
        map.put("firstName", staff.getFirstName());
        map.put("lastName", staff.getLastName());
        map.put("email", staff.getUser() != null ? staff.getUser().getEmail() : "");
        map.put("visiblePassword", staff.getUser() != null ? staff.getUser().getVisiblePassword() : null);
        map.put("designation", staff.getDesignation());
        map.put("department",
                staff.getDepartment() != null
                        ? Map.of("id", staff.getDepartment().getId(), "name", staff.getDepartment().getName(), "code",
                                staff.getDepartment().getCode())
                        : null);
        map.put("phone", staff.getPhone());
        map.put("whatsappNumber", staff.getWhatsappNumber());
        map.put("dob", staff.getDob());
        map.put("address", staff.getAddress());
        map.put("bloodGroup", staff.getBloodGroup());
        map.put("photoPath", staff.getPhotoPath());
        map.put("isActive", staff.isActive());
        map.put("roles", staff.getRoles() != null
                ? staff.getRoles().stream().map(r -> r.getRole().name()).collect(Collectors.toList())
                : new ArrayList<>());
        return map;
    }
}
