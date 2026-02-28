package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "staff_roles", uniqueConstraints = {
        @UniqueConstraint(columnNames = { "faculty_id", "role" })
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StaffRole {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "faculty_id", nullable = false)
    private Faculty faculty;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private RoleType role;
}
