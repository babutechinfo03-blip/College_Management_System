package com.college.erp.repository;

import com.college.erp.entity.AttendanceHeader;
import com.college.erp.entity.CourseType;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface AttendanceHeaderRepository extends JpaRepository<AttendanceHeader, Long> {
    Optional<AttendanceHeader> findByProgramTypeAndDegreeIdAndSpecializationIdAndDateAndHourAndYearAndSemester(
            CourseType programType, Long degreeId, Long specializationId, LocalDate date, int hour, int year,
            int semester);

    List<AttendanceHeader> findByAssistantStaffIdOrderByDateDescHourDesc(Long assistantId);

    List<AttendanceHeader> findTop5ByAssistantStaffIdOrderByDateDescHourDesc(Long assistantId);

    List<AttendanceHeader> findByDate(LocalDate date);
}
