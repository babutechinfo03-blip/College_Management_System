package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "sections")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Section {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;

    @ManyToOne
    @JoinColumn(name = "semester_id")
    private Semester semester;

    private int year;

    @Column(nullable = false)
    private String name;
    @ManyToOne
    @JoinColumn(name = "class_advisor_id")
    private Faculty classAdvisor;
}
