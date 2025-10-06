package com.ewatts.electricalreadings.dto;

import com.ewatts.electricalreadings.entity.DeviceType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CreateDeviceRequest {
    @NotBlank(message = "Device name is required")
    private String deviceName;

    @NotBlank(message = "ESP32 ID is required")
    private String esp32Id;

    @NotNull(message = "Device type is required")
    private DeviceType deviceType;

    @NotNull(message = "User ID is required")
    private Long userId;

    @NotBlank(message = "User email is required")
    private String userEmail;

    private String description;
    private String location;
    private String installationNotes;
    private Double voltageCalibration;
    private Double currentCalibration;
}
