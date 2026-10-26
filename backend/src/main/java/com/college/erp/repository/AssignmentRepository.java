package com.college.erp.repository;

import com.college.erp.entity.Assignment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface AssignmentRepository extends JpaRepository<Assignment, Long> {
    List<Assignment> findBySectionId(Long sectionId);

    List<Assignment> findByFacultyId(Long facultyId);

    List<Assignment> findBySectionIdAndSubjectCode(Long sectionId, String subjectCode);
}
