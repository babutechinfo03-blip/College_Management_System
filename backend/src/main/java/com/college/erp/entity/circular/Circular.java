package com.college.erp.entity.circular;

import com.college.erp.entity.User;
import com.college.erp.entity.circular.enums.CircularPriority;
import com.college.erp.entity.circular.enums.CircularStatus;
import com.college.erp.entity.circular.enums.CircularTargetRole;
import com.college.erp.entity.circular.enums.CircularType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "circulars")
@Data
public class Circular {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String content;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private CircularType type;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by", nullable = false)
    private User createdBy;

    // The role the creator was acting as when creating this (e.g., HOD vs FACULTY)
    @Column(name = "created_role", nullable = false)
    private String createdRole;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private CircularPriority priority = CircularPriority.NORMAL;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private CircularStatus status = CircularStatus.DRAFT;

    @Column(name = "scheduled_at")
    private LocalDateTime scheduledAt;

    @Column(name = "expiry_at")
    private LocalDateTime expiryAt;

    @Column(name = "requires_acknowledgement")
    private boolean requiresAcknowledgement = false;

    @Column(name = "attachment_url")
    private String attachmentUrl;

    @Column(name = "is_active")
    private boolean isActive = true;

    // For HOD approval of Faculty circulars
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "approved_by")
    private User approvedBy;

    @Column(name = "approved_at")
    private LocalDateTime approvedAt;

    @OneToMany(mappedBy = "circular", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CircularTarget> targets = new ArrayList<>();

    @OneToMany(mappedBy = "circular", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CircularRead> readStatuses = new ArrayList<>();

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}
