package com.college.erp.repository;

import com.college.erp.entity.AcademicControl;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface AcademicControlRepository extends JpaRepository<AcademicControl, Long> {
    Optional<AcademicControl> findByAcademicYearAndSemester(String academicYear, String semester);
}
