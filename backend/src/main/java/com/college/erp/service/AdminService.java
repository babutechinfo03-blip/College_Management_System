package com.college.erp.service;

import com.college.erp.repository.StudentRepository;
import com.college.erp.repository.FacultyRepository;
import com.college.erp.repository.AssistantStaffRepository;
import com.college.erp.repository.ComplaintRepository;
import com.college.erp.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.Map;

@Service
public class AdminService {
    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private FacultyRepository facultyRepository;

    @Autowired
    private AssistantStaffRepository assistantStaffRepository;

    @Autowired
    private ComplaintRepository complaintRepository;

    @Autowired
    private UserRepository userRepository;

    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();

        // Student Breakdown
        long totalStudents = studentRepository.count();
        stats.put("totalStudents", totalStudents);
        // Simplified UG/PG logic - in real world we'd use a query on department type
        stats.put("studentsUG", totalStudents > 0 ? (long) (totalStudents * 0.7) : 0L);
        stats.put("studentsPG", totalStudents > 0 ? (long) (totalStudents * 0.3) : 0L);

        // Staff Breakdown
        long totalFaculty = facultyRepository.count();
        long totalAssistants = assistantStaffRepository.count();
        stats.put("totalStaff", totalFaculty + totalAssistants);
        stats.put("staffHOD", facultyRepository.countByDesignationContainingIgnoreCase("HOD"));
        stats.put("staffFaculty", facultyRepository.countByDesignationContainingIgnoreCase("Professor")); // Adjusted to
                                                                                                          // match
                                                                                                          // typical
                                                                                                          // faculty
                                                                                                          // designations
        stats.put("staffAssistant", totalAssistants);

        // Complaints
        stats.put("activeComplaints",
                complaintRepository.countByStatusNot(com.college.erp.entity.ComplaintStatus.RESOLVED));

        // Real-time bit (Just placeholders for now as we don't have many records)
        stats.put("attendanceToday", "94%");

        return stats;
    }

    @Autowired
    private com.college.erp.repository.DepartmentRepository departmentRepository;

    public Object saveDepartment(com.college.erp.entity.Department dept) {
        return departmentRepository.save(dept);
    }

    public Object getAllDepartments() {
        return departmentRepository.findAll();
    }

    public Object getAllUsers() {
        return userRepository.findAll();
    }

    public void updateUserStatus(Long userId, boolean active) {
        userRepository.findById(userId).ifPresent(user -> {
            user.setActive(active);
            userRepository.save(user);
        });
    }

    public Object getAllStaff() {
        Map<String, Object> allStaff = new HashMap<>();
        allStaff.put("faculty", facultyRepository.findAll());
        allStaff.put("assistantStaff", assistantStaffRepository.findAll());
        return allStaff;
    }

    public Object getAllStudents() {
        return studentRepository.findAll();
    }
}
