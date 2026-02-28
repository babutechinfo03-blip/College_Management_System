package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "academic_years")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AcademicYear {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String yearRange;

    @Builder.Default
    @Column(name = "is_active")
    private boolean active = true;
}
