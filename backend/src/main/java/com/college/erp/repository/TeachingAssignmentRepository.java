package com.college.erp.repository;

import com.college.erp.entity.TeachingAssignment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface TeachingAssignmentRepository extends JpaRepository<TeachingAssignment, Long> {
    List<TeachingAssignment> findByFacultyId(Long facultyId);

    List<TeachingAssignment> findByDepartmentId(Long departmentId);
}
