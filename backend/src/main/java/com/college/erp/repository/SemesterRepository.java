package com.college.erp.repository;

import com.college.erp.entity.Semester;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SemesterRepository extends JpaRepository<Semester, Long> {
    java.util.List<Semester> findByAcademicYearAndSemesterNumber(com.college.erp.entity.AcademicYear academicYear,
            int semesterNumber);
}
