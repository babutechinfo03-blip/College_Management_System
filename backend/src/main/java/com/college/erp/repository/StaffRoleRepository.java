package com.college.erp.repository;

import com.college.erp.entity.StaffRole;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface StaffRoleRepository extends JpaRepository<StaffRole, Long> {
    List<StaffRole> findByFacultyId(Long facultyId);

    void deleteByFacultyId(Long facultyId);

    long countByRole(com.college.erp.entity.RoleType role);

    long countByRoleAndFacultyIsActiveTrue(com.college.erp.entity.RoleType role);
}
