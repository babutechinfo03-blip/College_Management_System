package com.college.erp.repository;

import com.college.erp.entity.TimetableEntry;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TimetableRepository extends JpaRepository<TimetableEntry, Long> {

    // Fetch timetable for a specific class (e.g. CSE Year 2 Section A)
    List<TimetableEntry> findByDepartmentIdAndYearAndSectionId(Long departmentId, Integer year, Long sectionId);

    // Fetch timetable for a specific faculty (across all departments they teach)
    List<TimetableEntry> findByFacultyId(Long facultyId);

    // Find specific slot to check for existence
    // Optional: could rely on DB constraints, but this helps pre-check in service
    boolean existsByDayOfWeekAndHourAndFacultyId(String dayOfWeek, Integer hour, Long facultyId);

    boolean existsByDayOfWeekAndHourAndDepartmentIdAndYearAndSectionId(String dayOfWeek, Integer hour,
            Long departmentId, Integer year, Long sectionId);

    long countByDepartmentIdAndDayOfWeek(Long departmentId, String dayOfWeek);
}
