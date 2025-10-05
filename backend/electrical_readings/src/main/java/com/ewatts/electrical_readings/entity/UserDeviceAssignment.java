package com.ewatts.electrical_readings.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "user_device_assignments")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDeviceAssignment {
    @Id
    @GeneratedValue
    private UUID id;

    @Column(name = "user_id", nullable = false)
    private UUID userId; // From auth service

    @Column(name = "device_id", nullable = false)
    private UUID deviceId;

    @Column(name = "assigned_at")
    private LocalDateTime assignedAt = LocalDateTime.now();

    @Column(name = "assigned_by")
    private UUID assignedBy; // Admin who assigned

    private boolean active = true;
}
