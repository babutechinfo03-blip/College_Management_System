package com.college.erp.repository;

import com.college.erp.entity.AttendanceDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface AttendanceDetailRepository extends JpaRepository<AttendanceDetail, Long> {
    List<AttendanceDetail> findByHeaderId(Long headerId);
}
