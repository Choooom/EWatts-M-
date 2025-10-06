package com.ewatts.electricalreadings.dto;

import com.ewatts.electricalreadings.entity.DeviceType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RealtimeReadingEvent {
    private Long deviceId;
    private String deviceName;
    private DeviceType deviceType;
    private Long userId;
    private Double voltage;
    private Double current;
    private Double power;
    private Double energy;
    private Boolean ssrEnabled;
    private LocalDateTime timestamp;
}
