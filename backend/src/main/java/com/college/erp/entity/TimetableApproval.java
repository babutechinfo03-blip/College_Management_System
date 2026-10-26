package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "timetable_approvals", uniqueConstraints = {
        @UniqueConstraint(columnNames = { "department_id", "academic_year", "semester" })
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TimetableApproval {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "department_id", nullable = false)
    private Department department;

    @Column(name = "academic_year", nullable = false)
    private String academicYear;

    @Column(nullable = false)
    private String semester;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ApprovalStatus status;

    @Column(length = 500)
    private String remarks;

    @Builder.Default
    private LocalDateTime submittedAt = LocalDateTime.now();

    private LocalDateTime reviewedAt;

    public enum ApprovalStatus {
        DRAFT,
        SUBMITTED,
        APPROVED,
        REJECTED
    }
}
