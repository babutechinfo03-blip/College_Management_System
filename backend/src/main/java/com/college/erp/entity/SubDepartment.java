package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "sub_departments")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SubDepartment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;

    @Column(nullable = false)
    private String name;
}
