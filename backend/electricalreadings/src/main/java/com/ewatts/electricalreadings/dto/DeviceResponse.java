package com.ewatts.electricalreadings.dto;

import com.ewatts.electricalreadings.entity.DeviceType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeviceResponse {
    private Long id;
    private String deviceName;
    private String esp32Id;
    private String deviceToken;
    private DeviceType deviceType;
    private String description;
    private Long userId;
    private String userEmail;
    private Boolean ssrEnabled;
    private Boolean active;
    private Boolean online;
    private LocalDateTime lastSeenAt;
    private Double voltageCalibration;
    private Double currentCalibration;
    private String location;
    private String installationNotes;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
