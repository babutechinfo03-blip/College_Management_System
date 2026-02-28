package com.college.erp.repository;

import com.college.erp.entity.Section;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SectionRepository extends JpaRepository<Section, Long> {
    List<Section> findByDepartmentId(Long departmentId);
}
