package com.ewatts.electrical_readings.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class DeviceStatusDto {
    private String deviceId;
    private String deviceName;
    private String status;
    private LocalDateTime lastSeen;
    private Double lastVoltage;
    private Double lastCurrent;
    private Double lastPower;
    private Double totalEnergy;
    private boolean isOnline;
    private String location;
}
