package com.college.erp.repository;

import com.college.erp.entity.TimetableApproval;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface TimetableApprovalRepository extends JpaRepository<TimetableApproval, Long> {
    Optional<TimetableApproval> findByDepartmentIdAndAcademicYearAndSemester(Long departmentId, String academicYear,
            String semester);

    List<TimetableApproval> findByStatus(TimetableApproval.ApprovalStatus status);
}
