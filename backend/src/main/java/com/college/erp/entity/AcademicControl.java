package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "academic_controls")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AcademicControl {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String academicYear; // e.g., "2023-2024"

    @Column(nullable = false)
    private String semester; // e.g., "ODD", "EVEN"

    @Column(nullable = false)
    @Builder.Default
    private boolean attendanceFrozen = false;

    @Column(nullable = false)
    @Builder.Default
    private boolean marksFrozen = false;

    @Column(nullable = false)
    @Builder.Default
    private boolean timetableFrozen = false;
}
