package com.college.erp.config;

import com.college.erp.entity.*;
import com.college.erp.repository.*;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Arrays;

@Component
public class DataSeeder implements CommandLineRunner {

        private final UserRepository userRepository;
        private final DepartmentRepository departmentRepository;
        private final FacultyRepository facultyRepository;
        private final AssistantStaffRepository assistantStaffRepository;
        private final AcademicYearRepository academicYearRepository;
        private final SemesterRepository semesterRepository;
        private final SectionRepository sectionRepository;
        private final DegreeRepository degreeRepository;
        private final SpecializationRepository specializationRepository;
        private final StaffRoleRepository staffRoleRepository;
        private final TeachingAssignmentRepository teachingAssignmentRepository;
        private final StudentRepository studentRepository;
        private final PasswordEncoder passwordEncoder;
        private final org.springframework.jdbc.core.JdbcTemplate jdbcTemplate;

        public DataSeeder(UserRepository userRepository,
                        DepartmentRepository departmentRepository,
                        FacultyRepository facultyRepository,
                        AssistantStaffRepository assistantStaffRepository,
                        StudentRepository studentRepository,
                        AcademicYearRepository academicYearRepository,
                        SemesterRepository semesterRepository,
                        SectionRepository sectionRepository,
                        DegreeRepository degreeRepository,
                        SpecializationRepository specializationRepository,
                        StaffRoleRepository staffRoleRepository,
                        TeachingAssignmentRepository teachingAssignmentRepository,
                        PasswordEncoder passwordEncoder,
                        org.springframework.jdbc.core.JdbcTemplate jdbcTemplate) {
                this.userRepository = userRepository;
                this.departmentRepository = departmentRepository;
                this.facultyRepository = facultyRepository;
                this.assistantStaffRepository = assistantStaffRepository;
                this.academicYearRepository = academicYearRepository;
                this.semesterRepository = semesterRepository;
                this.sectionRepository = sectionRepository;
                this.degreeRepository = degreeRepository;
                this.specializationRepository = specializationRepository;
                this.staffRoleRepository = staffRoleRepository;
                this.teachingAssignmentRepository = teachingAssignmentRepository;
                this.studentRepository = studentRepository;
                this.passwordEncoder = passwordEncoder;
                this.jdbcTemplate = jdbcTemplate;
        }

        @Override
        @Transactional
        public void run(String... args) throws Exception {
                System.out.println("Data Seeding Check...");

                // 0. Native Wipe (REMOVED for Persistence)
                // System.out.println("DEBUG: Cleaning corrupted data via Native SQL...");
                // try {
                // jdbcTemplate.execute("SET FOREIGN_KEY_CHECKS = 0");
                // // ... TRUNCATE skipped ...
                // jdbcTemplate.execute("SET FOREIGN_KEY_CHECKS = 1");
                // System.out.println("DEBUG: Native Wipe Skipped.");
                // } catch (Exception e) {
                // System.out.println("DEBUG: Native Wipe failed (non-critical): " +
                // e.getMessage());
                // }

                // 1. Academic Year
                final AcademicYear academicYear;
                if (academicYearRepository.count() == 0) {
                        academicYear = academicYearRepository.save(AcademicYear.builder()
                                        .yearRange("2023-2024")
                                        .active(true)
                                        .build());
                } else {
                        academicYear = academicYearRepository.findAll().get(0);
                }
                final AcademicYear year2024 = academicYear;

                // 3. Departments
                Department deptCse = departmentRepository.findByCode("CSE")
                                .orElseGet(() -> departmentRepository.save(Department.builder()
                                                .name("Computer Science").code("CSE").type(CourseType.UG).build()));

                Department deptIt = departmentRepository.findByCode("IT")
                                .orElseGet(() -> departmentRepository.save(Department.builder()
                                                .name("Information Technology").code("IT").type(CourseType.UG)
                                                .build()));

                Department deptEce = departmentRepository.findByCode("ECE")
                                .orElseGet(() -> departmentRepository.save(Department.builder()
                                                .name("Electronics & Communication Engg").code("ECE")
                                                .type(CourseType.UG).build()));

                Department deptEee = departmentRepository.findByCode("EEE")
                                .orElseGet(() -> departmentRepository.save(Department.builder()
                                                .name("Electrical & Electronics Engg").code("EEE").type(CourseType.UG)
                                                .build()));

                Department deptMech = departmentRepository.findByCode("MECH")
                                .orElseGet(() -> departmentRepository.save(Department.builder()
                                                .name("Mechanical Engineering").code("MECH").type(CourseType.UG)
                                                .build()));

                Department deptCivil = departmentRepository.findByCode("CIVIL")
                                .orElseGet(() -> departmentRepository.save(Department.builder()
                                                .name("Civil Engineering").code("CIVIL").type(CourseType.UG).build()));

                Department deptAids = departmentRepository.findByCode("AIDS")
                                .orElseGet(() -> departmentRepository.save(Department.builder()
                                                .name("Artificial Intelligence & Data Science").code("AIDS")
                                                .type(CourseType.UG).build()));

                // 2. Degrees & Specializations
                // Since we just truncated, count will be 0.
                if (degreeRepository.count() == 0) {
                        System.out.println("DEBUG: Seeding Degrees...");
                        Degree be = Degree.builder().programType(CourseType.UG).name("Bachelor of Engineering")
                                        .code("BE").department(deptCse).build();
                        Degree btech = Degree.builder().programType(CourseType.UG)
                                        .name("Bachelor of Technology")
                                        .code("BTECH").department(deptIt).build();
                        Degree me = Degree.builder().programType(CourseType.PG).name("Master of Engineering")
                                        .code("ME")
                                        .department(deptCse).build();
                        Degree mtech = Degree.builder().programType(CourseType.PG).name("Master of Technology")
                                        .code("MTECH").department(deptCse).build();
                        Degree mba = Degree.builder().programType(CourseType.PG)
                                        .name("Master of Business Administration").code("MBA")
                                        .department(deptIt)
                                        .build();
                        Degree mca = Degree.builder().programType(CourseType.PG)
                                        .name("Master of Computer Applications")
                                        .code("MCA").department(deptCse).build();

                        degreeRepository.saveAll(Arrays.asList(be, btech, me, mtech, mba, mca));

                        specializationRepository.save(Specialization.builder().degree(be)
                                        .name("Computer Science and Engineering").code("CSE").build());
                        specializationRepository.save(Specialization.builder().degree(be)
                                        .name("Electronics and Communication Engineering").code("ECE").build());
                        specializationRepository.save(Specialization.builder().degree(btech)
                                        .name("Information Technology").code("IT").build());
                        specializationRepository.save(Specialization.builder().degree(me)
                                        .name("Computer Science and Engineering").code("CSE").build());
                        specializationRepository.save(Specialization.builder().degree(mba)
                                        .name("Business Administration").code("MBA").build());
                        specializationRepository
                                        .save(Specialization.builder().degree(mca).name("Computer Applications")
                                                        .code("MCA").build());
                }

                AcademicYear currentYear = year2024;
                Semester sem1 = semesterRepository.findByAcademicYearAndSemesterNumber(currentYear, 1).stream()
                                .findFirst().orElseGet(() -> semesterRepository.save(Semester.builder()
                                                .academicYear(year2024).semesterNumber(1).type(CourseType.UG).build()));

                if (sectionRepository.count() == 0) {
                        sectionRepository.saveAll(Arrays.asList(
                                        Section.builder().semester(sem1).name("A").year(1).build(),
                                        Section.builder().semester(sem1).name("B").year(1).build()));
                }

                // 4. Users and Staff
                boolean staffSeeded = userRepository.count() > 0;
                if (!staffSeeded) {
                        // Seeding Users and Staff
                        createUser("principal", "Demo@1234", Role.PRINCIPAL, "principal@college.edu");
                        createUser("office01", "Demo@1234", Role.OFFICE, "office@college.edu");

                        User hodUser = createUser("STF001", "Demo@1234", Role.HOD, "hod.cse@college.edu");
                        Faculty s1 = facultyRepository
                                        .save(Faculty.builder().user(hodUser).staffId("STF001").firstName("Suresh")
                                                        .lastName("Kumar").department(deptCse).designation("HOD")
                                                        .build());
                        staffRoleRepository.save(StaffRole.builder().faculty(s1).role(RoleType.HOD).build());
                        staffRoleRepository.save(StaffRole.builder().faculty(s1).role(RoleType.FACULTY).build());

                        // HOD Teaching Assignment
                        teachingAssignmentRepository.save(TeachingAssignment.builder()
                                        .faculty(s1).department(deptCse).year(4).semester(7)
                                        .subjectName("Professional Ethics")
                                        .subjectCode("ETHICS101").build());

                        User facUser = createUser("STF002", "Demo@1234", Role.FACULTY, "faculty@college.edu");
                        Faculty s2 = facultyRepository.save(Faculty.builder().user(facUser).staffId("STF002")
                                        .firstName("Alan")
                                        .lastName("Turing").department(deptCse).designation("Asst Professor").build());
                        staffRoleRepository.save(StaffRole.builder().faculty(s2).role(RoleType.FACULTY).build());
                        staffRoleRepository.save(StaffRole.builder().faculty(s2).role(RoleType.CLASS_ADVISOR).build());

                        // Multi-Dept Assignments for STF002
                        teachingAssignmentRepository.save(TeachingAssignment.builder()
                                        .faculty(s2).department(deptCse).year(2).semester(3)
                                        .subjectName("Data Structures")
                                        .subjectCode("CS301").build());

                        teachingAssignmentRepository.save(TeachingAssignment.builder()
                                        .faculty(s2).department(deptIt).year(2).semester(3)
                                        .subjectName("Object Oriented Programming").subjectCode("IT302").build());

                        User astUser = createUser("AST001", "Demo@1234", Role.ASSISTANT_STAFF, "assistant@college.edu");
                        AssistantStaff s3 = assistantStaffRepository
                                        .save(AssistantStaff.builder().user(astUser).assistantId("AST001")
                                                        .firstName("Murali").lastName("Krishnan").department(deptCse)
                                                        .designation("Lab Assistant").build());
                        // AssistantStaff doesn't use StaffRole currently

                        createUser("PAR001", "Demo@1234", Role.PARENT, "parent01@college.edu");

                        System.out.println("Data Seeding: Core Staff & Users Created.");
                } else {
                        System.out.println("Data Seeding: Core Users skipped (already exist).");
                }

                // ── Seed all department HODs (idempotent — always runs) ──────────────────
                seedHOD("STF001", "Demo@1234", "hod.cse@college.edu", deptCse);
                seedHOD("STF-IT001", "Demo@1234", "hod.it@college.edu", deptIt);
                seedHOD("STF-ECE001", "Demo@1234", "hod.ece@college.edu", deptEce);
                seedHOD("STF-EEE001", "Demo@1234", "hod.eee@college.edu", deptEee);
                seedHOD("STF-MECH001", "Demo@1234", "hod.mech@college.edu", deptMech);
                seedHOD("STF-CIV001", "Demo@1234", "hod.civil@college.edu", deptCivil);
                seedHOD("STF-AIDS001", "Demo@1234", "hod.aids@college.edu", deptAids);
                System.out.println("Data Seeding: All HODs ensured.");

                // 5. Students (Bulk Seeding)
                System.out.println("DEBUG: Checking student count: " + studentRepository.count());
                if (studentRepository.count() < 50) {
                        System.out.println("DEBUG: Seeding BULK students (~600)...");

                        Degree be = degreeRepository.findByCode("BE").orElse(null);
                        Specialization cseSpec = specializationRepository.findByDegreeAndCode(be, "CSE").orElse(null);

                        Degree btech = degreeRepository.findByCode("BTECH").orElse(null);
                        Specialization itSpec = specializationRepository.findByDegreeAndCode(btech, "IT").orElse(null);

                        if (be != null && cseSpec != null && btech != null && itSpec != null) {
                                // Academic Year assumes 2023-2024 is current
                                // Year 1: Batch 2023-2027
                                // Year 2: Batch 2022-2026
                                // Year 3: Batch 2021-2025
                                // Year 4: Batch 2020-2024

                                int baseYear = 2023; // Entry year for current 1st years

                                for (int year = 1; year <= 4; year++) {
                                        int entryYear = baseYear - (year - 1);
                                        String batch = entryYear + "-" + (entryYear + 4);
                                        int currentSemester = (year * 2) - 1; // 1, 3, 5, 7

                                        // Seed 75 CSE Students
                                        generateStudents(entryYear, "CSE", be, cseSpec, year, currentSemester, batch,
                                                        75);

                                        // Seed 75 IT Students
                                        generateStudents(entryYear, "IT", btech, itSpec, year, currentSemester, batch,
                                                        75);
                                }
                                System.out.println("Data Seeding: Bulk Students Created.");
                        } else {
                                System.out.println("DEBUG: Skipping Student Seed - Degrees/Specs not found.");
                        }
                }

                // 6. Ensure all student passwords are valid (One-time Fix for legacy data)
                System.out.println("DEBUG: Ensuring all student passwords are valid...");
                String studentHash = passwordEncoder.encode("Demo@1234");
                int updatedCount = jdbcTemplate.update(
                                "UPDATE users SET password = ?, visible_password = 'Demo@1234' WHERE role = 'STUDENT'",
                                studentHash);
                System.out.println("DEBUG: Updated " + updatedCount + " student passwords.");

                // 7. Seed Sample Timetable
                seedTimetable(deptCse, deptIt);

                System.out.println("Data Seeding: Full Seed Completed.");
        }

        private void generateStudents(int entryYear, String deptCode, Degree degree, Specialization spec,
                        int currentYear, int currentSemester, String batch, int count) {
                for (int i = 1; i <= count; i++) {
                        String rollNo = String.format("%d%s%03d", entryYear, deptCode, i); // e.g. 2023CSE001
                        String email = rollNo.toLowerCase() + "@college.edu";

                        // Create User (Default Pass: 'Demo@1234')
                        User user = createUser(rollNo, "Demo@1234", Role.STUDENT, email);

                        // Check if student exists to avoid dupes (though count check handles most)
                        if (!studentRepository.existsByStudentId(rollNo)) {
                                Section section = sectionRepository.findAll().get(i % 2); // Assign A or B
                                studentRepository.save(Student.builder()
                                                .user(user)
                                                .studentId(rollNo)
                                                .firstName("Student")
                                                .lastName(String.format("%s-%03d", deptCode, i))
                                                .degree(degree)
                                                .specialization(spec)
                                                .section(section)
                                                .currentYear(currentYear)
                                                .currentSemester(currentSemester)
                                                .batch(batch)
                                                .parentName("Parent " + i)
                                                .parentMobile("90000" + String.format("%05d", i))
                                                .dob("2000-01-01")
                                                .address("Hostel Block " + currentYear)
                                                .phone("9" + String.format("%09d", i))
                                                .bloodGroup("O+")
                                                .isActive(true)
                                                .build());
                        }
                }
                System.out.println("Seeded " + count + " students for " + batch + " " + deptCode);
        }

        private User createUser(String username, String password, Role role, String email) {
                return userRepository.findByUsername(username)
                                .or(() -> userRepository.findByEmail(email))
                                .orElseGet(() -> userRepository.save(User.builder()
                                                .username(username)
                                                .password(passwordEncoder.encode(password))
                                                .role(role)
                                                .email(email)
                                                .active(true)
                                                .createdAt(LocalDateTime.now())
                                                .build()));
        }

        /**
         * Idempotent HOD seeder — creates or updates password for a HOD.
         * If the user already exists, updates password to ensure it's correct.
         */
        private void seedHOD(String staffId, String password, String email, Department dept) {
                // Check by staffId first
                java.util.Optional<Faculty> existingFaculty = facultyRepository.findByStaffId(staffId);
                if (existingFaculty.isPresent()) {
                        // Update password to ensure it's correct
                        User u = existingFaculty.get().getUser();
                        u.setPassword(passwordEncoder.encode(password));
                        u.setActive(true);
                        userRepository.save(u);
                        // Ensure HOD role in staff_roles
                        Faculty f = existingFaculty.get();
                        boolean hasHod = f.getRoles() != null &&
                                        f.getRoles().stream().anyMatch(r -> r.getRole() == RoleType.HOD);
                        if (!hasHod) {
                                staffRoleRepository.save(StaffRole.builder().faculty(f).role(RoleType.HOD).build());
                        }
                        return;
                }
                // Create new HOD user
                String username = staffId.replace("-", "_");
                User hodUser = createUser(username, password, Role.HOD, email);
                Faculty f = facultyRepository.save(Faculty.builder()
                                .user(hodUser).staffId(staffId)
                                .firstName("HOD").lastName(dept.getCode())
                                .department(dept).designation("Professor & HOD")
                                .isActive(true).build());
                staffRoleRepository.save(StaffRole.builder().faculty(f).role(RoleType.HOD).build());
                staffRoleRepository.save(StaffRole.builder().faculty(f).role(RoleType.FACULTY).build());
        }

        private void seedTimetable(Department cse, Department it) {
                if (jdbcTemplate.queryForObject("SELECT count(*) FROM timetable_entries", Integer.class) > 0)
                        return;

                Section secA = sectionRepository.findAll().stream().filter(s -> s.getName().equals("A")).findFirst()
                                .get();
                Faculty fac1 = facultyRepository.findByStaffId("STF001").get();
                Faculty fac2 = facultyRepository.findByStaffId("STF002").get();

                String[] days = { "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY" };
                for (String day : days) {
                        // CSE Year 1 Section A
                        createTimetableEntry(cse, 1, 1, secA, day, 1, "Engineering Mathematics", "MAT101", fac1);
                        createTimetableEntry(cse, 1, 1, secA, day, 2, "Physics for Computing", "PHY102", fac2);
                        createTimetableEntry(cse, 1, 1, secA, day, 3, "Programming in C", "CSE103", fac1);
                }
        }

        private void createTimetableEntry(Department dept, int year, int sem, Section sec, String day, int hour,
                        String sub, String code, Faculty fac) {
                jdbcTemplate.update(
                                "INSERT INTO timetable_entries (department_id, year, semester, section_id, day_of_week, hour, subject_name, subject_code, faculty_id, type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                                dept.getId(), year, sem, sec.getId(), day, hour, sub, code, fac.getId(), "LECTURE");
        }
}
