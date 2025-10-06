package com.ewatts.electricalreadings.dto;


import com.ewatts.electricalreadings.entity.AggregationType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AggregatedReadingResponse {
    private Long id;
    private Long deviceId;
    private String deviceName;
    private AggregationType aggregationType;
    private LocalDateTime periodStart;
    private LocalDateTime periodEnd;
    private Double avgVoltage;
    private Double maxVoltage;
    private Double minVoltage;
    private Double avgCurrent;
    private Double maxCurrent;
    private Double minCurrent;
    private Double avgPower;
    private Double maxPower;
    private Double minPower;
    private Double totalEnergyConsumed;
    private Integer readingCount;
}
