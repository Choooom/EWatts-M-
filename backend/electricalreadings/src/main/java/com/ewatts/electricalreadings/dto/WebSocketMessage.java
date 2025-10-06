package com.ewatts.electricalreadings.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WebSocketMessage {
    private String type; // "READING", "SSR_CONTROL", "DEVICE_STATUS"
    private Object payload;
    private LocalDateTime timestamp;
}