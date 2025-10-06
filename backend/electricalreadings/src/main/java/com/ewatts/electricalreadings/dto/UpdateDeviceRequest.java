package com.ewatts.electricalreadings.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UpdateDeviceRequest {
    private String deviceName;
    private String description;
    private String location;
    private String installationNotes;
    private Double voltageCalibration;
    private Double currentCalibration;
    private Boolean active;
}