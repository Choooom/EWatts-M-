package com.ewatts.electricalreadings.controller;

import com.ewatts.electricalreadings.dto.AnalyticsResponse;
import com.ewatts.electricalreadings.dto.ApiResponse;
import com.ewatts.electricalreadings.dto.EnergyBreakdownResponse;
import com.ewatts.electricalreadings.entity.AggregationType;
import com.ewatts.electricalreadings.entity.DeviceType;
import com.ewatts.electricalreadings.service.AggregationService;
import com.ewatts.electricalreadings.service.EnergyAnalysisService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Map;

@RestController
@RequestMapping("/api/iot/analytics")
@RequiredArgsConstructor
public class AnalyticsController {

    private final AggregationService aggregationService;
    private final EnergyAnalysisService energyAnalysisService;

    // ========== DEVICE TYPE ANALYTICS ENDPOINTS ==========

    /**
     * Get analytics for all devices of a specific type
     * Example: All SOLAR_PANEL devices, all HOUSE_METER devices, etc.
     */
    @GetMapping("/device-type/{deviceType}")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getAnalyticsByDeviceType(
            @PathVariable DeviceType deviceType,
            @RequestParam AggregationType type,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        AnalyticsResponse analytics = aggregationService.getAnalyticsByDeviceType(
                userId, deviceType, type, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    @GetMapping("/device-type/{deviceType}/hourly")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getHourlyAnalyticsByDeviceType(
            @PathVariable DeviceType deviceType,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        AnalyticsResponse analytics = aggregationService.getAnalyticsByDeviceType(
                userId, deviceType, AggregationType.HOURLY, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    @GetMapping("/device-type/{deviceType}/daily")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getDailyAnalyticsByDeviceType(
            @PathVariable DeviceType deviceType,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        AnalyticsResponse analytics = aggregationService.getAnalyticsByDeviceType(
                userId, deviceType, AggregationType.DAILY, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    @GetMapping("/device-type/{deviceType}/monthly")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getMonthlyAnalyticsByDeviceType(
            @PathVariable DeviceType deviceType,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        AnalyticsResponse analytics = aggregationService.getAnalyticsByDeviceType(
                userId, deviceType, AggregationType.MONTHLY, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    // ========== INDIVIDUAL DEVICE ANALYTICS ENDPOINTS ==========

    /**
     * Get analytics for a specific device by ID
     */
    @GetMapping("/device/{deviceId}")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getAnalyticsByDevice(
            @PathVariable Long deviceId,
            @RequestParam AggregationType type,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        AnalyticsResponse analytics = aggregationService.getAnalyticsByDevice(
                deviceId, type, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    @GetMapping("/device/{deviceId}/hourly")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getHourlyAnalyticsByDevice(
            @PathVariable Long deviceId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        AnalyticsResponse analytics = aggregationService.getAnalyticsByDevice(
                deviceId, AggregationType.HOURLY, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    @GetMapping("/device/{deviceId}/daily")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getDailyAnalyticsByDevice(
            @PathVariable Long deviceId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        AnalyticsResponse analytics = aggregationService.getAnalyticsByDevice(
                deviceId, AggregationType.DAILY, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    @GetMapping("/device/{deviceId}/monthly")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getMonthlyAnalyticsByDevice(
            @PathVariable Long deviceId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        AnalyticsResponse analytics = aggregationService.getAnalyticsByDevice(
                deviceId, AggregationType.MONTHLY, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    // ========== USER OVERVIEW ANALYTICS ENDPOINTS ==========

    /**
     * Get combined analytics for all user devices across all types
     */
    @GetMapping("/overview")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getOverviewAnalytics(
            @RequestParam AggregationType type,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        AnalyticsResponse analytics = aggregationService.getAnalyticsForUser(
                userId, type, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    @GetMapping("/overview/hourly")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getHourlyOverviewAnalytics(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        AnalyticsResponse analytics = aggregationService.getAnalyticsForUser(
                userId, AggregationType.HOURLY, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    @GetMapping("/overview/daily")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getDailyOverviewAnalytics(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        AnalyticsResponse analytics = aggregationService.getAnalyticsForUser(
                userId, AggregationType.DAILY, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    @GetMapping("/overview/monthly")
    public ResponseEntity<ApiResponse<AnalyticsResponse>> getMonthlyOverviewAnalytics(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        AnalyticsResponse analytics = aggregationService.getAnalyticsForUser(
                userId, AggregationType.MONTHLY, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(analytics));
    }

    // ========== ENERGY BREAKDOWN ENDPOINTS (SOLAR SYSTEM ANALYSIS) ==========

    /**
     * Get comprehensive energy breakdown showing grid vs solar vs battery usage
     */
    @GetMapping("/energy-breakdown")
    public ResponseEntity<ApiResponse<EnergyBreakdownResponse>> getEnergyBreakdown(
            @RequestParam AggregationType type,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        EnergyBreakdownResponse breakdown = energyAnalysisService.getEnergyBreakdown(
                userId, type, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(breakdown));
    }

    @GetMapping("/energy-breakdown/hourly")
    public ResponseEntity<ApiResponse<EnergyBreakdownResponse>> getHourlyEnergyBreakdown(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        EnergyBreakdownResponse breakdown = energyAnalysisService.getEnergyBreakdown(
                userId, AggregationType.HOURLY, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(breakdown));
    }

    @GetMapping("/energy-breakdown/daily")
    public ResponseEntity<ApiResponse<EnergyBreakdownResponse>> getDailyEnergyBreakdown(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        EnergyBreakdownResponse breakdown = energyAnalysisService.getEnergyBreakdown(
                userId, AggregationType.DAILY, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(breakdown));
    }

    @GetMapping("/energy-breakdown/monthly")
    public ResponseEntity<ApiResponse<EnergyBreakdownResponse>> getMonthlyEnergyBreakdown(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        EnergyBreakdownResponse breakdown = energyAnalysisService.getEnergyBreakdown(
                userId, AggregationType.MONTHLY, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(breakdown));
    }

    /**
     * Get simplified energy flow metrics
     */
    @GetMapping("/energy-flow")
    public ResponseEntity<ApiResponse<Map<String, Double>>> getEnergyFlow(
            @RequestParam AggregationType type,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            Authentication authentication) {

        Long userId = (Long) authentication.getPrincipal();

        Map<String, Double> energyFlow = energyAnalysisService.calculateEnergyFlow(
                userId, type, startDate, endDate);

        return ResponseEntity.ok(ApiResponse.success(energyFlow));
    }

    // ========== LEGACY ENDPOINTS (BACKWARD COMPATIBILITY) ==========

    /**
     * @deprecated Use specific endpoints instead:
     * - /device-type/{deviceType} for device type analytics
     * - /device/{deviceId} for individual device analytics
     * - /overview for all devices
     */
    @Deprecated
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

    @Deprecated
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

    @Deprecated
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

    @Deprecated
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

    @Deprecated
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