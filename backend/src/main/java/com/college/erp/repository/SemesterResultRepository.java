package com.college.erp.repository;

import com.college.erp.entity.SemesterResult;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SemesterResultRepository extends JpaRepository<SemesterResult, Long> {
    List<SemesterResult> findByStudentId(Long studentId);

    List<SemesterResult> findByStudentIdAndSemester(Long studentId, Integer semester);
}
