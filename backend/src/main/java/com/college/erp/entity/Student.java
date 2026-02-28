package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "students")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "user_id", unique = true)
    private User user;

    @Column(unique = true, nullable = false)
    private String studentId;

    @Column(nullable = false)
    private String firstName;

    private String lastName;

    @ManyToOne
    @JoinColumn(name = "degree_id")
    private Degree degree;

    @ManyToOne
    @JoinColumn(name = "specialization_id")
    private Specialization specialization;

    private int currentYear;

    @Column(nullable = false)
    @Builder.Default
    private int currentSemester = 1;

    private String batch;

    private String parentName;
    private String parentMobile;
    private String dob;
    private String address;
    private String phone;
    private String whatsappNumber;
    private String bloodGroup;
    private String caste;
    private String religion;

    @Column(length = 255)
    private String photoPath;

    @Builder.Default
    @Column(nullable = false)
    private boolean isActive = true;
}
