package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "specializations", uniqueConstraints = {
        @UniqueConstraint(columnNames = { "degree_id", "code" })
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Specialization {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "degree_id", nullable = false)
    private Degree degree;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(nullable = false, length = 20)
    private String code;
}
