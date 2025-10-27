package com.ewatts.electricalreadings.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "aggregated_readings", indexes = {
        @Index(name = "idx_device_period", columnList = "deviceId,aggregationType,periodStart"),
        @Index(name = "idx_user_period", columnList = "userId,aggregationType,periodStart"),
        @Index(name = "idx_user_type_period", columnList = "userId,deviceType,aggregationType,periodStart")
})
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AggregatedReading {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = true)
    private Long deviceId;

    @Column(nullable = false)
    private Long userId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DeviceType deviceType;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private AggregationType aggregationType;

    @Column(nullable = false)
    private LocalDateTime periodStart;

    @Column(nullable = false)
    private LocalDateTime periodEnd;

    private Double avgVoltage;
    private Double maxVoltage;
    private Double minVoltage;

    private Double avgCurrent;
    private Double maxCurrent;
    private Double minCurrent;

    private Double avgPower;
    private Double maxPower;
    private Double minPower;

    private Double totalEnergyConsumed;

    private Integer readingCount;

    // Number of devices included in this aggregation
    private Integer deviceCount;

    @CreationTimestamp
    private LocalDateTime createdAt;
}