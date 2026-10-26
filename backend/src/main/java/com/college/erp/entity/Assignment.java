package com.college.erp.entity;

import jakarta.persistence.*;
import lombok.*;
import com.college.erp.entity.Faculty;
import java.time.LocalDateTime;

@Entity
@Table(name = "assignments")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Assignment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    private String description;

    @ManyToOne
    @JoinColumn(name = "faculty_id")
    private Faculty faculty;

    @ManyToOne
    @JoinColumn(name = "section_id")
    private Section section;

    private String subjectCode;

    private LocalDateTime deadline;

    private String attachmentPath;

    @Builder.Default
    private LocalDateTime createdAt = LocalDateTime.now();
}
