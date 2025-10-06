package com.ewatts.electricalreadings.controller;

import com.ewatts.electricalreadings.dto.AnalyticsResponse;
import com.ewatts.electricalreadings.dto.ApiResponse;
import com.ewatts.electricalreadings.entity.AggregationType;
import com.ewatts.electricalreadings.service.AggregationService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/api/iot/analytics")
@RequiredArgsConstructor
public class AnalyticsController {

    private final AggregationService aggregationService;

    @GetMapping
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getAnalytics(
            @RequestParam AggregationType type,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            @RequestParam(required = false) Long deviceId,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        AnalyticsResponse analytics = aggregationService.getAnalytics(
                userId, type, startDate, endDate, deviceId);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    @GetMapping("/hourly")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getHourlyAnalytics(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            @RequestParam(required = false) Long deviceId,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        AnalyticsResponse analytics = aggregationService.getAnalytics(
                userId, AggregationType.HOURLY, startDate, endDate, deviceId);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    @GetMapping("/daily")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getDailyAnalytics(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            @RequestParam(required = false) Long deviceId,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        AnalyticsResponse analytics = aggregationService.getAnalytics(
                userId, AggregationType.DAILY, startDate, endDate, deviceId);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    @GetMapping("/monthly")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getMonthlyAnalytics(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            @RequestParam(required = false) Long deviceId,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        AnalyticsResponse analytics = aggregationService.getAnalytics(
                userId, AggregationType.MONTHLY, startDate, endDate, deviceId);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    @GetMapping("/yearly")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getYearlyAnalytics(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            @RequestParam(required = false) Long deviceId,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        AnalyticsResponse analytics = aggregationService.getAnalytics(
                userId, AggregationType.YEARLY, startDate, endDate, deviceId);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }
}