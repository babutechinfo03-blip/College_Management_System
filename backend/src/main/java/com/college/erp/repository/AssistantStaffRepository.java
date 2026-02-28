package com.college.erp.repository;

import com.college.erp.entity.AssistantStaff;
import com.college.erp.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface AssistantStaffRepository extends JpaRepository<AssistantStaff, Long> {
    Optional<AssistantStaff> findByAssistantId(String assistantId);

    Optional<AssistantStaff> findByUser(User user);

    long countByIsActiveTrue();

    long countByDepartmentId(Long departmentId);

    java.util.List<AssistantStaff> findByUserActive(boolean active);

    long countByDepartment_IdAndIsActiveTrue(Long departmentId);

    // Keep this for backward compatibility if used by other controllers
    java.util.List<AssistantStaff> findByDepartmentId(Long departmentId);

    java.util.List<AssistantStaff> findByDepartment_IdAndIsActiveTrue(Long departmentId);
}
