package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Entity
@Table(name = "mark_entries")
@Data
public class MarkEntry {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    @Column(nullable = false)
    private String subjectCode;

    @Column(nullable = false)
    private Double marksObtained;

    @Column(nullable = false)
    private Double maxMarks;

    @Column(nullable = false)
    private String examType; // INTERNAL, SEMESTER, ASSIGNMENT

    @Column(nullable = false)
    private Integer semester;

    // Workflow Fields
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private MarkStatus status = MarkStatus.DRAFT;

    @ManyToOne
    @JoinColumn(name = "entered_by")
    private Faculty enteredBy;

    @ManyToOne
    @JoinColumn(name = "approved_by")
    private Faculty approvedBy;

    private LocalDateTime createdAt = LocalDateTime.now();
    private LocalDateTime approvedAt;

    public enum MarkStatus {
        DRAFT, // Visible only to Faculty
        SUBMITTED, // Visible to Advisor
        VERIFIED, // Verified by Advisor, Visible to HOD
        APPROVED // Finalized by HOD
    }
}
