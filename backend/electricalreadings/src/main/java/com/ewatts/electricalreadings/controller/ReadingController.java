package com.ewatts.electricalreadings.controller;

import com.ewatts.electricalreadings.dto.ApiResponse;
import com.ewatts.electricalreadings.dto.ReadingResponse;
import com.ewatts.electricalreadings.service.ReadingService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/iot/readings")
@RequiredArgsConstructor
public class ReadingController {

    private final ReadingService readingService;

    @GetMapping("/device/{deviceId}")
    public ResponseEntity<ApiResponse<Page<ReadingResponse>>> getDeviceReadings(
            @PathVariable Long deviceId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            Authentication authentication) {

        Page<ReadingResponse> readings = readingService.getDeviceReadings(deviceId, page, size);
        return ResponseEntity.ok(ApiResponse.success(readings));
    }

    @GetMapping("/device/{deviceId}/latest")
    public ResponseEntity<ApiResponse<ReadingResponse>> getLatestReading(
            @PathVariable Long deviceId,
            Authentication authentication) {

        ReadingResponse reading = readingService.getLatestReading(deviceId);
        return ResponseEntity.ok(ApiResponse.success(reading));
    }

    @GetMapping("/device/{deviceId}/range")
    public ResponseEntity<ApiResponse<List<ReadingResponse>>> getDeviceReadingsByRange(
            @PathVariable Long deviceId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime start,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime end,
            Authentication authentication) {

        List<ReadingResponse> readings = readingService
                .getDeviceReadingsByDateRange(deviceId, start, end);
        return ResponseEntity.ok(ApiResponse.success(readings));
    }

    @GetMapping("/my-readings")
    public ResponseEntity<ApiResponse<Page<ReadingResponse>>> getMyReadings(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();
        Page<ReadingResponse> readings = readingService.getUserReadings(userId, page, size);
        return ResponseEntity.ok(ApiResponse.success(readings));
    }
}