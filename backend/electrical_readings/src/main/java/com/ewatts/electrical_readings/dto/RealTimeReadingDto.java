package com.ewatts.electrical_readings.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RealTimeReadingDto {
    private String deviceId;
    private String deviceName;
    private String location;
    private Double voltage;
    private Double current;
    private Double power;
    private Double energy;
    private LocalDateTime timestamp;
    private String status;
}
