package com.college.erp.repository;

import com.college.erp.entity.Complaint;
import com.college.erp.entity.ComplaintStatus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ComplaintRepository extends JpaRepository<Complaint, Long> {
    long countByStatusNot(ComplaintStatus status);
}
