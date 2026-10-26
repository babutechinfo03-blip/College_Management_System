package com.college.erp.entity.circular;

import com.college.erp.entity.User;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

import java.time.LocalDateTime;

@Entity
@Table(name = "circular_reads", uniqueConstraints = {
        @UniqueConstraint(columnNames = { "circular_id", "user_id" })
})
@Data
public class CircularRead {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "circular_id", nullable = false)
    @JsonIgnore
    @ToString.Exclude
    private Circular circular;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "is_viewed")
    private boolean isViewed = false;

    @Column(name = "is_acknowledged")
    private boolean isAcknowledged = false;

    @Column(name = "viewed_at")
    private LocalDateTime viewedAt;

    @Column(name = "acknowledged_at")
    private LocalDateTime acknowledgedAt;
}
