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
                                        Section.builder().semester(sem1).name("A").build(),
                                        Section.builder().semester(sem1).name("B").build()));
                }

                // 4. Users and Staff
                boolean staffSeeded = userRepository.count() > 0;
                if (!staffSeeded) {
                        // Seeding Users and Staff
                        createUser("principal", "admin123", Role.PRINCIPAL, "principal@college.edu");
                        createUser("office01", "admin123", Role.OFFICE, "office@college.edu");

                        User hodUser = createUser("STF001", "admin123", Role.HOD, "hod.cse@college.edu");
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

                        User facUser = createUser("STF002", "admin123", Role.FACULTY, "faculty@college.edu");
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

                        User astUser = createUser("AST001", "admin123", Role.ASSISTANT_STAFF, "assistant@college.edu");
                        AssistantStaff s3 = assistantStaffRepository
                                        .save(AssistantStaff.builder().user(astUser).assistantId("AST001")
                                                        .firstName("Murali").lastName("Krishnan").department(deptCse)
                                                        .designation("Lab Assistant").build());
                        // AssistantStaff doesn't use StaffRole currently

                        createUser("PAR001", "admin123", Role.PARENT, "parent01@college.edu");

                        System.out.println("Data Seeding: Core Staff & Users Created.");
                } else {
                        System.out.println("Data Seeding: Core Users skipped (already exist).");
                }

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

                System.out.println("Data Seeding: Full Seed Completed.");
        }

        private void generateStudents(int entryYear, String deptCode, Degree degree, Specialization spec,
                        int currentYear, int currentSemester, String batch, int count) {
                for (int i = 1; i <= count; i++) {
                        String rollNo = String.format("%d%s%03d", entryYear, deptCode, i); // e.g. 2023CSE001
                        String email = rollNo.toLowerCase() + "@college.edu";

                        // Create User (Default Pass: 'password')
                        User user = createUser(rollNo, "password", Role.STUDENT, email);

                        // Check if student exists to avoid dupes (though count check handles most)
                        if (!studentRepository.existsByStudentId(rollNo)) {
                                studentRepository.save(Student.builder()
                                                .user(user)
                                                .studentId(rollNo)
                                                .firstName("Student")
                                                .lastName(String.format("%s-%03d", deptCode, i))
                                                .degree(degree)
                                                .specialization(spec)
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
}
