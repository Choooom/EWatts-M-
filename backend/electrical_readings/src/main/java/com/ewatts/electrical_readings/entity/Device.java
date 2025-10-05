package com.ewatts.electrical_readings.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "devices")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Device {
    @Id
    @GeneratedValue
    private UUID id;

    @Column(unique = true, nullable = false)
    private String deviceId; // Unique identifier for ESP32

    @Column(nullable = false)
    private String deviceName;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DeviceType deviceType = DeviceType.ENERGY_MONITOR;

    @Column(nullable = false)
    private String location;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DeviceStatus status = DeviceStatus.INACTIVE;

    @Column(name = "calibration_voltage")
    private Double voltageCalibration = 83.3;

    @Column(name = "calibration_current")
    private Double currentCalibration = 0.50;

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "last_seen")
    private LocalDateTime lastSeen;

    private String firmwareVersion;
    private String hardwareVersion;
}

