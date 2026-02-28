package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.*;
import java.util.List;

@Entity
@Table(name = "faculty")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Faculty {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "user_id", unique = true)
    private User user;

    @Column(unique = true, nullable = false)
    private String staffId;

    @Column(nullable = false)
    private String firstName;

    private String lastName;

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;

    private String designation;

    private String phone;
    private String whatsappNumber;
    private String dob;
    private String address;
    private String bloodGroup;

    @Column(length = 255)
    private String photoPath;

    @Builder.Default
    @Column(nullable = false)
    private boolean isActive = true;

    @OneToMany(mappedBy = "faculty", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<StaffRole> roles;
}
