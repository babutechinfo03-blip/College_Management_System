package com.college.erp.repository;

import com.college.erp.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);

    Optional<User> findByEmail(String email);

    boolean existsByEmail(String email);

    java.util.List<User> findByRole(com.college.erp.entity.Role role);

    long countByRoleAndActive(com.college.erp.entity.Role role, boolean active);
}
