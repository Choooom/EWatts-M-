package com.ewatts.electricalreadings.dto;

import ch.qos.logback.core.util.AggregationType;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
class AnalyticsRequest {
    @NotNull
    private AggregationType aggregationType;

    @NotNull
    private LocalDateTime startDate;

    @NotNull
    private LocalDateTime endDate;

    private Long deviceId; // Optional: filter by specific device
}
