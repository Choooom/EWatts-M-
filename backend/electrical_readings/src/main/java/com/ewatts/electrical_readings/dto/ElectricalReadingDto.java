package com.ewatts.electrical_readings.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.time.LocalDateTime;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ElectricalReadingDto {
    private String deviceId;
    private Double voltage; // Vrms
    private Double current; // Irms
    private Double power;   // Watts
    private Double energy;  // kWh cumulative
    private LocalDateTime timestamp;
    private String location;
}

