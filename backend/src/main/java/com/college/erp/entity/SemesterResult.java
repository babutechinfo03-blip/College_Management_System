package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "semester_results")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SemesterResult {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    private String subjectCode;
    private String subjectName;
    private String grade; // O, A+, A, B+, B, C, P, F
    private Integer credits;
    private Integer semester;
    private String resultStatus; // PASS / FAIL
}
