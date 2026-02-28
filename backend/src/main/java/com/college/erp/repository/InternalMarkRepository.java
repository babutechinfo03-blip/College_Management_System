package com.college.erp.repository;

import com.college.erp.entity.InternalMark;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface InternalMarkRepository extends JpaRepository<InternalMark, Long> {
    List<InternalMark> findByStudentId(Long studentId);

    List<InternalMark> findByStudentIdAndSemesterId(Long studentId, Long semesterId);
}
