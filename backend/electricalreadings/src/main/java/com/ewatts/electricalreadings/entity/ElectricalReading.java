package com.ewatts.electricalreadings.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "electrical_readings", indexes = {
        @Index(name = "idx_device_timestamp", columnList = "deviceId,timestamp"),
        @Index(name = "idx_timestamp", columnList = "timestamp"),
        @Index(name = "idx_user_timestamp", columnList = "userId,timestamp")
})
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ElectricalReading {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long deviceId;

    @Column(nullable = false)
    private Long userId;

    @Column(nullable = false)
    private Double voltage;

    @Column(nullable = false)
    private Double current;

    @Column(nullable = false)
    private Double power;

    @Column(nullable = false)
    private Double energy;

    @Column(nullable = false)
    private LocalDateTime timestamp;

    @CreationTimestamp
    private LocalDateTime createdAt;
}