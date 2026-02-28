package com.college.erp.repository;

import com.college.erp.entity.MarkEntry;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MarkEntryRepository extends JpaRepository<MarkEntry, Long> {

    // For Faculty: View drafts and submitted
    List<MarkEntry> findByEnteredById(Long facultyId);

    // For Advisor: View submitted marks for verification (by class context roughly)
    // Complex query usually needed here joining student -> class
    // For MVP: List by subject/semester
    List<MarkEntry> findBySubjectCodeAndSemester(String subjectCode, Integer semester);

    long countByStudentDegreeDepartmentIdAndStatus(Long departmentId, MarkEntry.MarkStatus status);

    long countByStudentDegreeDepartmentIdAndStatusIn(Long departmentId,
            java.util.Collection<MarkEntry.MarkStatus> statuses);

    java.util.List<MarkEntry> findByStudentDegreeDepartmentIdAndStatusIn(Long departmentId,
            java.util.Collection<MarkEntry.MarkStatus> statuses);
}
