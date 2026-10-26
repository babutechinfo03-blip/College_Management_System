package com.college.erp.repository;

import com.college.erp.entity.circular.Circular;
import com.college.erp.entity.circular.enums.CircularStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CircularRepository extends JpaRepository<Circular, Long>, JpaSpecificationExecutor<Circular> {

    List<Circular> findByCreatedByIdOrderByCreatedAtDesc(Long userId);

    List<Circular> findByStatusOrderByCreatedAtDesc(CircularStatus status);

    @Query("SELECT c FROM Circular c WHERE c.isActive = true AND c.status = 'PENDING_APPROVAL' AND " +
            "(c.createdBy.id IN (SELECT f.user.id FROM Faculty f WHERE f.department.id = :departmentId))")
    List<Circular> findPendingValidationsForHod(@Param("departmentId") Long departmentId);

    // Advanced dynamic query will be used via Specifications in the service layer
}
