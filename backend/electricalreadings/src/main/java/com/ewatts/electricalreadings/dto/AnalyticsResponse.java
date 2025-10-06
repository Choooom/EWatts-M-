package com.ewatts.electricalreadings.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AnalyticsResponse {
    private List<AggregatedReadingResponse> data;
    private Double totalEnergyConsumed;
    private Double avgPower;
    private Integer totalReadings;
}
