package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "teaching_assignments")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TeachingAssignment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "faculty_id", nullable = false)
    private Faculty faculty;

    @ManyToOne
    @JoinColumn(name = "department_id", nullable = false)
    private Department department;

    @Column(nullable = false)
    private int year;

    @Column(nullable = false)
    private int semester;

    @Column(nullable = false)
    private String subjectName;

    @Column(nullable = false)
    private String subjectCode;

    // Optional: Link to a Section if assignments are section-specific
    @ManyToOne
    @JoinColumn(name = "section_id")
    private Section section;

    @Column(name = "assigned_by_hod_id")
    private Long assignedByHodId;

    @Column(name = "faculty_department_id")
    private Long facultyDepartmentId;

    @Column(name = "requesting_department_id")
    private Long requestingDepartmentId;

    @Enumerated(EnumType.STRING)
    @Column(name = "approval_status")
    private ApprovalStatus approvalStatus = ApprovalStatus.APPROVED;

    @Column(name = "approved_by_hod_id")
    private Long approvedByHodId;

    @Column(name = "approved_at")
    private java.time.LocalDateTime approvedAt;
}
