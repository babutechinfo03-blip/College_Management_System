package com.college.erp.entity.circular;

import com.college.erp.entity.Department;
import com.college.erp.entity.Section;
import com.college.erp.entity.circular.enums.CircularTargetRole;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

@Entity
@Table(name = "circular_targets")
@Data
public class CircularTarget {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "circular_id", nullable = false)
    @JsonIgnore
    @ToString.Exclude
    private Circular circular;

    // Filter by department (null = all departments)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "department_id")
    private Department department;

    // Filter by year (null = all years)
    private Integer year;

    // Filter by semester (null = all semesters)
    private Integer semester;

    // Filter by section (null = all sections)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "section_id")
    private Section section;

    // Filter by role (e.g., STUDENT, FACULTY, HOD, ALL)
    @Enumerated(EnumType.STRING)
    @Column(name = "target_role")
    private CircularTargetRole targetRole = CircularTargetRole.ALL;
}
