package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "internal_marks")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InternalMark {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;

    @ManyToOne
    @JoinColumn(name = "semester_id")
    private Semester semester;

    private String subjectCode;

    private Integer marks;

    private Integer maxMarks;

    private String examType; // e.g., INTERNAL 1, INTERNAL 2
}
