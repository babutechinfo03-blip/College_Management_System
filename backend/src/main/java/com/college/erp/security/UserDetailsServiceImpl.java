package com.college.erp.security;

import com.college.erp.entity.User;
import com.college.erp.repository.UserRepository;
import com.college.erp.repository.FacultyRepository;
import com.college.erp.repository.AssistantStaffRepository;
import com.college.erp.repository.StudentRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import java.util.Collections;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    private static final Logger logger = LoggerFactory.getLogger(UserDetailsServiceImpl.class);

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private FacultyRepository facultyRepository;

    @Autowired
    private AssistantStaffRepository assistantStaffRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Override
    public UserDetails loadUserByUsername(String identifier) throws UsernameNotFoundException {
        logger.debug("=== Loading User ===");
        logger.debug("Identifier: {}", identifier);

        // 1. Try Username
        User user = userRepository.findByUsername(identifier).orElse(null);
        if (user != null) {
            logger.debug("✓ User found by username");
        }

        // 2. Try Faculty ID
        if (user == null) {
            logger.debug("Trying Faculty ID lookup...");
            user = facultyRepository.findByStaffId(identifier)
                    .map(faculty -> faculty.getUser())
                    .orElse(null);
            if (user != null) {
                logger.debug("✓ User found by Faculty ID");
            }
        }

        // 3. Try Assistant Staff ID
        if (user == null) {
            logger.debug("Trying Assistant Staff ID lookup...");
            user = assistantStaffRepository.findByAssistantId(identifier)
                    .map(staff -> staff.getUser())
                    .orElse(null);
            if (user != null) {
                logger.debug("✓ User found by Assistant Staff ID");
            }
        }

        // 3. Try Student ID
        if (user == null) {
            logger.debug("Trying Student ID lookup...");
            user = studentRepository.findByStudentId(identifier)
                    .map(student -> student.getUser())
                    .orElse(null);
            if (user != null) {
                logger.debug("✓ User found by Student ID");
            }
        }

        if (user == null) {
            logger.error("✗ User Not Found with identifier: {}", identifier);
            throw new UsernameNotFoundException("User Not Found with identifier: " + identifier);
        }

        logger.info("User Details: username={}, role={}, active={}",
                user.getUsername(), user.getRole(), user.isActive());
        logger.debug("Password Hash (first 20 chars): {}",
                user.getPassword().substring(0, Math.min(20, user.getPassword().length())));

        // Return UserDetails with enabled status from database
        return new org.springframework.security.core.userdetails.User(
                user.getUsername(),
                user.getPassword(),
                user.isActive(), // enabled
                true, // accountNonExpired
                true, // credentialsNonExpired
                true, // accountNonLocked
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + user.getRole().name())));
    }
}
