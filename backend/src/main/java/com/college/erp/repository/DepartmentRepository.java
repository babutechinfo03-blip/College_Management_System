package com.college.erp.repository;

import com.college.erp.entity.CourseType;
import com.college.erp.entity.Department;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface DepartmentRepository extends JpaRepository<Department, Long> {
    List<Department> findByType(CourseType type);

    java.util.Optional<Department> findByCode(String code);
}
