package com.ewatts.electrical_readings.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeviceRegistrationRequest {
    private String deviceId;
    private String deviceName;
    private String location;
    private Double voltageCalibration;
    private Double currentCalibration;
    private String firmwareVersion;
    private String hardwareVersion;
}
