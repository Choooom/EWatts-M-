package com.ewatts.electrical_readings.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeviceDto {
    private UUID id;
    private String deviceId;
    private String deviceName;
    private String deviceType;
    private String location;
    private String status;
    private Double voltageCalibration;
    private Double currentCalibration;
    private LocalDateTime createdAt;
    private LocalDateTime lastSeen;
    private String firmwareVersion;
    private String hardwareVersion;
}