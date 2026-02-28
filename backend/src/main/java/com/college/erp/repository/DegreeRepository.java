package com.college.erp.repository;

import com.college.erp.entity.CourseType;
import com.college.erp.entity.Degree;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface DegreeRepository extends JpaRepository<Degree, Long> {
    List<Degree> findByProgramType(CourseType programType);

    java.util.Optional<Degree> findByCode(String code);
}
