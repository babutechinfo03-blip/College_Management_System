package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "timetable_entries", uniqueConstraints = {
        // Constraint 1: A Faculty cannot be in two places at the same time
        @UniqueConstraint(columnNames = { "dayOfWeek", "hour", "faculty_id" }, name = "uk_faculty_timeline"),

        // Constraint 2: A Class (Dept+Year+Sec) cannot have two subjects at the same
        // time
        @UniqueConstraint(columnNames = { "dayOfWeek", "hour", "department_id", "year",
                "section_id" }, name = "uk_class_timeline")
})
@Data
public class TimetableEntry {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "department_id", nullable = false)
    private Department department;

    @Column(nullable = false)
    private Integer year; // 1, 2, 3, 4

    @Column(nullable = false)
    private Integer semester;

    @ManyToOne(optional = false)
    @JoinColumn(name = "section_id", nullable = false)
    private Section section;

    @Column(nullable = false)
    private String dayOfWeek; // MONDAY, TUESDAY, ...

    @Column(nullable = false)
    private Integer hour; // 1 to 8

    @Column(nullable = false)
    private String subjectName; // Storing name for flexibility, or link to Subject entity if stricter

    @Column(nullable = false)
    private String subjectCode;

    @ManyToOne(optional = false)
    @JoinColumn(name = "faculty_id", nullable = false)
    private Faculty faculty;

    // Optional: Type (Lecture, Lab, etc.)
    private String type = "LECTURE";
}
