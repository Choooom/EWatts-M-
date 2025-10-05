package com.ewatts.electrical_readings.controller;

import com.ewatts.electrical_readings.dto.*;
import com.ewatts.electrical_readings.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import java.util.UUID;

@RestController
@RequestMapping("/readings/readings")
@RequiredArgsConstructor
public class ReadingsController {

    private final ElectricalReadingsService readingsService;

    @PostMapping("/submit")
    public ResponseEntity<ApiResponse<String>> submitReading(
            @RequestBody ElectricalReadingDto reading,
            @RequestHeader("Device-ID") String deviceId) {

        // Validate device ID matches request
        if (!deviceId.equals(reading.getDeviceId())) {
            return ResponseEntity.badRequest()
                    .body(new ApiResponse<>(false, "Device ID mismatch", null));
        }

        try {
            readingsService.processReading(reading);
            return ResponseEntity.ok(
                    new ApiResponse<>(true, "Reading processed successfully", "OK"));
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(new ApiResponse<>(false, "Error processing reading: " + e.getMessage(), null));
        }
    }
}
