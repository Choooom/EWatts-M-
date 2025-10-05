package com.ewatts.electrical_readings.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeviceAssignmentRequest {
    private UUID deviceId;
    private UUID userId;
}
