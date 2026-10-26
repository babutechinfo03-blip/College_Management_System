package com.college.erp.repository;

import com.college.erp.entity.circular.CircularRead;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CircularReadRepository extends JpaRepository<CircularRead, Long> {
    Optional<CircularRead> findByCircularIdAndUserId(Long circularId, Long userId);
}
