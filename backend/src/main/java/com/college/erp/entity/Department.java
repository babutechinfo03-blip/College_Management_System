package com.college.erp.entity;

import com.college.erp.entity.Faculty;
import jakarta.persistence.*;
import lombok.*;
import java.util.List;

@Entity
@Table(name = "departments")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Department {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String name;

    @Column(unique = true, nullable = false)
    private String code;

    @Enumerated(EnumType.STRING)
    private CourseType type;

    private String description;

    private String discipline; // BE, BTech, ME, MTech, MBA, MCA

    @OneToOne
    @JoinColumn(name = "hod_id")
    private Faculty hod;

    private int maxStudentCapacity;

    @Builder.Default
    private boolean isActive = true;

    @OneToMany(mappedBy = "department", cascade = CascadeType.ALL)
    private List<SubDepartment> subDepartments;
}
