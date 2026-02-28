package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.*;
import java.util.List;

@Entity
@Table(name = "degrees")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Degree {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private CourseType programType;

    @Column(nullable = false, length = 50)
    private String name;

    @Column(unique = true, nullable = false, length = 10)
    private String code;

    @ManyToOne(optional = false)
    @JoinColumn(name = "department_id", nullable = false)
    private Department department;

    @com.fasterxml.jackson.annotation.JsonIgnore
    @OneToMany(mappedBy = "degree", cascade = CascadeType.ALL)
    private List<Specialization> specializations;
}
