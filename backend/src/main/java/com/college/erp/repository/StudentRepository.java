package com.college.erp.repository;

import com.college.erp.entity.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface StudentRepository extends JpaRepository<Student, Long> {
    Optional<Student> findByStudentId(String studentId);

    boolean existsByStudentId(String studentId);

    long countByIsActiveTrue();

    java.util.List<Student> findByDegreeDepartmentIdAndCurrentYear(Long departmentId, Integer currentYear);

    long countByDegree_Department_IdAndIsActiveTrue(Long departmentId);

    long countByDegreeDepartmentId(Long departmentId);

    java.util.List<Student> findByDegreeDepartmentId(Long departmentId);
}
