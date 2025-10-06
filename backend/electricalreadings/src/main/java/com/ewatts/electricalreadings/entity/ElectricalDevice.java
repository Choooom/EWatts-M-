package com.ewatts.electricalreadings.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "electrical_devices", indexes = {
        @Index(name = "idx_device_token", columnList = "deviceToken"),
        @Index(name = "idx_user_id", columnList = "userId"),
        @Index(name = "idx_esp32_id", columnList = "esp32Id")
})
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ElectricalDevice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String deviceName;

    @Column(nullable = false, unique = true)
    private String esp32Id;

    @Column(nullable = false, unique = true)
    private String deviceToken;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DeviceType deviceType;

    @Column(length = 500)
    private String description;

    @Column(nullable = false)
    private Long userId;

    @Column(nullable = false)
    private String userEmail;

    @Column(nullable = false)
    private Boolean ssrEnabled = true;

    @Column(nullable = false)
    private Boolean active = true;

    @Column(nullable = false)
    private Boolean online = false;

    private LocalDateTime lastSeenAt;

    private Double voltageCalibration = 83.3;
    private Double currentCalibration = 0.50;

    private String location;
    private String installationNotes;

    @CreationTimestamp
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;
}
