package com.college.erp.repository;

import com.college.erp.entity.Faculty;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface FacultyRepository extends JpaRepository<Faculty, Long> {
    Optional<Faculty> findByStaffId(String staffId);

    Optional<Faculty> findByUser(com.college.erp.entity.User user);

    @org.springframework.data.jpa.repository.Query("SELECT f FROM Faculty f JOIN f.roles r WHERE r.role = :role")
    java.util.List<Faculty> findByRole(
            @org.springframework.data.repository.query.Param("role") com.college.erp.entity.RoleType role);

    long countByDesignationContainingIgnoreCase(String designation);

    long countByIsActiveTrue();

    java.util.List<Faculty> findByUserActive(boolean active);

    long countByDepartmentId(Long departmentId);
}
