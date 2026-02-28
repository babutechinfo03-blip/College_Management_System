package com.college.erp.repository;

import com.college.erp.entity.Specialization;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SpecializationRepository extends JpaRepository<Specialization, Long> {
    List<Specialization> findByDegreeId(Long degreeId);

    java.util.Optional<Specialization> findByDegreeAndCode(com.college.erp.entity.Degree degree, String code);

    java.util.Optional<Specialization> findByCode(String code);
}
