package com.ewatts.electricalreadings.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReadingMessage {
    private String deviceToken;
    private Double voltage;
    private Double current;
    private Double power;
    private Double energy;
    private Long timestamp; // Unix timestamp from ESP32
}
