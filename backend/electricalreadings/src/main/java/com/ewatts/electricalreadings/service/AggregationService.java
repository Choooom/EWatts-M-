package com.ewatts.electricalreadings.service;

import com.ewatts.electricalreadings.dto.AggregatedReadingResponse;
import com.ewatts.electricalreadings.dto.AnalyticsResponse;
import com.ewatts.electricalreadings.entity.*;
import com.ewatts.electricalreadings.repository.AggregatedReadingRepository;
import com.ewatts.electricalreadings.repository.ElectricalDeviceRepository;
import com.ewatts.electricalreadings.repository.ElectricalReadingRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class AggregationService {

    private final ElectricalReadingRepository readingRepository;
    private final AggregatedReadingRepository aggregatedRepository;
    private final ElectricalDeviceRepository deviceRepository;

    // ========== SCHEDULED JOBS ==========

    @Scheduled(cron = "${aggregation.hourly-cron}")
    @Transactional
    public void aggregateHourlyData() {
        log.info("Starting hourly aggregation...");
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime hourStart = now.truncatedTo(ChronoUnit.HOURS).minusHours(1);
        LocalDateTime hourEnd = hourStart.plusHours(1);

        aggregateForAllUsersAndDeviceTypes(AggregationType.HOURLY, hourStart, hourEnd);
        log.info("Hourly aggregation completed");
    }

    @Scheduled(cron = "${aggregation.daily-cron}")
    @Transactional
    public void aggregateDailyData() {
        log.info("Starting daily aggregation...");
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime dayStart = now.truncatedTo(ChronoUnit.DAYS).minusDays(1);
        LocalDateTime dayEnd = dayStart.plusDays(1);

        aggregateForAllUsersAndDeviceTypes(AggregationType.DAILY, dayStart, dayEnd);
        log.info("Daily aggregation completed");
    }

    @Scheduled(cron = "${aggregation.monthly-cron}")
    @Transactional
    public void aggregateMonthlyData() {
        log.info("Starting monthly aggregation...");
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime monthStart = now.withDayOfMonth(1).truncatedTo(ChronoUnit.DAYS).minusMonths(1);
        LocalDateTime monthEnd = monthStart.plusMonths(1);

        aggregateForAllUsersAndDeviceTypes(AggregationType.MONTHLY, monthStart, monthEnd);
        log.info("Monthly aggregation completed");
    }

    // ========== CORE AGGREGATION LOGIC ==========

    /**
     * Main aggregation method - creates both grouped (by device type) and individual device aggregations
     */
    private void aggregateForAllUsersAndDeviceTypes(AggregationType type,
                                                    LocalDateTime start,
                                                    LocalDateTime end) {
        List<ElectricalDevice> devices = deviceRepository.findAll();

        // GROUP 1: Aggregate by User + Device Type (for device type analytics)
        Map<String, List<ElectricalDevice>> deviceGroups = devices.stream()
                .collect(Collectors.groupingBy(device ->
                        device.getUserId() + "_" + device.getDeviceType()));

        for (Map.Entry<String, List<ElectricalDevice>> entry : deviceGroups.entrySet()) {
            List<ElectricalDevice> groupDevices = entry.getValue();
            if (groupDevices.isEmpty()) continue;

            ElectricalDevice firstDevice = groupDevices.get(0);
            Long userId = firstDevice.getUserId();
            DeviceType deviceType = firstDevice.getDeviceType();

            try {
                aggregateByUserAndDeviceType(userId, deviceType, groupDevices, type, start, end);
            } catch (Exception e) {
                log.error("Error aggregating data for user {} deviceType {}: {}",
                        userId, deviceType, e.getMessage(), e);
            }
        }

        // GROUP 2: Aggregate each individual device (for device-specific analytics)
        for (ElectricalDevice device : devices) {
            try {
                aggregateIndividualDevice(device, type, start, end);
            } catch (Exception e) {
                log.error("Error aggregating individual device data for device {}: {}",
                        device.getId(), e.getMessage(), e);
            }
        }
    }

    /**
     * Aggregate all devices of the same type for a user
     * Creates one aggregation record per (userId + deviceType + period)
     */
    @Transactional
    public void aggregateByUserAndDeviceType(Long userId,
                                             DeviceType deviceType,
                                             List<ElectricalDevice> devices,
                                             AggregationType type,
                                             LocalDateTime start,
                                             LocalDateTime end) {

        // Check if aggregation already exists
        Optional<AggregatedReading> existing = aggregatedRepository
                .findByUserIdAndDeviceTypeAndAggregationTypeAndPeriodStart(
                        userId, deviceType, type, start);

        if (existing.isPresent()) {
            log.debug("Aggregation already exists for user {} deviceType {} period {}",
                    userId, deviceType, start);
            return;
        }

        // Collect all readings from all devices of this type for this user
        List<ElectricalReading> allReadings = new ArrayList<>();
        for (ElectricalDevice device : devices) {
            List<ElectricalReading> deviceReadings = readingRepository
                    .findReadingsForAggregation(device.getId(), start, end);
            allReadings.addAll(deviceReadings);
        }

        if (allReadings.isEmpty()) {
            log.debug("No readings found for user {} deviceType {} in period {}",
                    userId, deviceType, start);
            return;
        }

        // Calculate statistics across all readings
        DoubleSummaryStatistics voltageStats = allReadings.stream()
                .mapToDouble(ElectricalReading::getVoltage)
                .summaryStatistics();

        DoubleSummaryStatistics currentStats = allReadings.stream()
                .mapToDouble(ElectricalReading::getCurrent)
                .summaryStatistics();

        DoubleSummaryStatistics powerStats = allReadings.stream()
                .mapToDouble(ElectricalReading::getPower)
                .summaryStatistics();

        // Calculate total energy consumed across all devices of this type
        double totalEnergyConsumed = 0.0;
        for (ElectricalDevice device : devices) {
            List<ElectricalReading> deviceReadings = readingRepository
                    .findReadingsForAggregation(device.getId(), start, end);

            if (!deviceReadings.isEmpty()) {
                // Sort by timestamp to get first and last readings
                deviceReadings.sort(Comparator.comparing(ElectricalReading::getTimestamp));
                double energyStart = deviceReadings.get(0).getEnergy();
                double energyEnd = deviceReadings.get(deviceReadings.size() - 1).getEnergy();
                totalEnergyConsumed += Math.max(0, energyEnd - energyStart);
            }
        }

        // Create grouped aggregation record
        AggregatedReading aggregated = new AggregatedReading();
        aggregated.setDeviceId(null); // NULL for grouped aggregations
        aggregated.setUserId(userId);
        aggregated.setDeviceType(deviceType);
        aggregated.setAggregationType(type);
        aggregated.setPeriodStart(start);
        aggregated.setPeriodEnd(end);

        aggregated.setAvgVoltage(voltageStats.getAverage());
        aggregated.setMaxVoltage(voltageStats.getMax());
        aggregated.setMinVoltage(voltageStats.getMin());

        aggregated.setAvgCurrent(currentStats.getAverage());
        aggregated.setMaxCurrent(currentStats.getMax());
        aggregated.setMinCurrent(currentStats.getMin());

        aggregated.setAvgPower(powerStats.getAverage());
        aggregated.setMaxPower(powerStats.getMax());
        aggregated.setMinPower(powerStats.getMin());

        aggregated.setTotalEnergyConsumed(totalEnergyConsumed);
        aggregated.setReadingCount(allReadings.size());
        aggregated.setDeviceCount(devices.size());

        aggregatedRepository.save(aggregated);

        log.info("Created {} aggregation for user {} deviceType {}: {} devices, {} readings, {} kWh",
                type, userId, deviceType, devices.size(), allReadings.size(), totalEnergyConsumed);
    }

    /**
     * Aggregate individual device
     * Creates one aggregation record per (deviceId + period)
     */
    @Transactional
    public void aggregateIndividualDevice(ElectricalDevice device,
                                          AggregationType type,
                                          LocalDateTime start,
                                          LocalDateTime end) {

        Optional<AggregatedReading> existing = aggregatedRepository
                .findByDeviceIdAndAggregationTypeAndPeriodStart(device.getId(), type, start);

        if (existing.isPresent()) {
            log.debug("Aggregation already exists for device {} period {}",
                    device.getId(), start);
            return;
        }

        List<ElectricalReading> readings = readingRepository
                .findReadingsForAggregation(device.getId(), start, end);

        if (readings.isEmpty()) {
            log.debug("No readings found for device {} in period {}",
                    device.getId(), start);
            return;
        }

        DoubleSummaryStatistics voltageStats = readings.stream()
                .mapToDouble(ElectricalReading::getVoltage)
                .summaryStatistics();

        DoubleSummaryStatistics currentStats = readings.stream()
                .mapToDouble(ElectricalReading::getCurrent)
                .summaryStatistics();

        DoubleSummaryStatistics powerStats = readings.stream()
                .mapToDouble(ElectricalReading::getPower)
                .summaryStatistics();

        readings.sort(Comparator.comparing(ElectricalReading::getTimestamp));
        double energyStart = readings.get(0).getEnergy();
        double energyEnd = readings.get(readings.size() - 1).getEnergy();
        double totalEnergyConsumed = Math.max(0, energyEnd - energyStart);

        AggregatedReading aggregated = new AggregatedReading();
        aggregated.setDeviceId(device.getId());
        aggregated.setUserId(device.getUserId());
        aggregated.setDeviceType(device.getDeviceType());
        aggregated.setAggregationType(type);
        aggregated.setPeriodStart(start);
        aggregated.setPeriodEnd(end);

        aggregated.setAvgVoltage(voltageStats.getAverage());
        aggregated.setMaxVoltage(voltageStats.getMax());
        aggregated.setMinVoltage(voltageStats.getMin());

        aggregated.setAvgCurrent(currentStats.getAverage());
        aggregated.setMaxCurrent(currentStats.getMax());
        aggregated.setMinCurrent(currentStats.getMin());

        aggregated.setAvgPower(powerStats.getAverage());
        aggregated.setMaxPower(powerStats.getMax());
        aggregated.setMinPower(powerStats.getMin());

        aggregated.setTotalEnergyConsumed(totalEnergyConsumed);
        aggregated.setReadingCount(readings.size());
        aggregated.setDeviceCount(1);

        aggregatedRepository.save(aggregated);

        log.info("Created {} aggregation for device {}: {} readings, {} kWh",
                type, device.getId(), readings.size(), totalEnergyConsumed);
    }

    // ========== ANALYTICS QUERY METHODS ==========

    /**
     * Get analytics by device type (e.g., all SOLAR_PANEL devices for a user)
     */
    public AnalyticsResponse getAnalyticsByDeviceType(Long userId,
                                                      DeviceType deviceType,
                                                      AggregationType type,
                                                      LocalDateTime start,
                                                      LocalDateTime end) {
        List<AggregatedReading> aggregations = aggregatedRepository
                .findByUserIdAndDeviceTypeAndAggregationTypeAndPeriodStartBetweenOrderByPeriodStartDesc(
                        userId, deviceType, type, start, end);

        return buildAnalyticsResponse(aggregations);
    }

    /**
     * Get analytics for a specific device by ID
     */
    public AnalyticsResponse getAnalyticsByDevice(Long deviceId,
                                                  AggregationType type,
                                                  LocalDateTime start,
                                                  LocalDateTime end) {
        List<AggregatedReading> aggregations = aggregatedRepository
                .findByDeviceIdAndAggregationTypeAndPeriodStartBetweenOrderByPeriodStartDesc(
                        deviceId, type, start, end);

        return buildAnalyticsResponse(aggregations);
    }

    /**
     * Get analytics for all devices of a user (combined overview)
     */
    public AnalyticsResponse getAnalyticsForUser(Long userId,
                                                 AggregationType type,
                                                 LocalDateTime start,
                                                 LocalDateTime end) {
        List<AggregatedReading> aggregations = aggregatedRepository
                .findByUserIdAndAggregationTypeAndPeriodStartBetweenOrderByPeriodStartDesc(
                        userId, type, start, end);

        return buildAnalyticsResponse(aggregations);
    }

    /**
     * Legacy method - kept for backward compatibility
     * Can be used by old API endpoints if they still exist
     */
    @Deprecated
    public AnalyticsResponse getAnalytics(Long userId,
                                          AggregationType type,
                                          LocalDateTime start,
                                          LocalDateTime end,
                                          Long deviceId) {
        if (deviceId != null) {
            return getAnalyticsByDevice(deviceId, type, start, end);
        } else {
            return getAnalyticsForUser(userId, type, start, end);
        }
    }

    // ========== HELPER METHODS ==========

    private AnalyticsResponse buildAnalyticsResponse(List<AggregatedReading> aggregations) {
        Map<Long, ElectricalDevice> deviceMap = deviceRepository.findAll().stream()
                .collect(Collectors.toMap(ElectricalDevice::getId, d -> d));

        List<AggregatedReadingResponse> responses = aggregations.stream()
                .map(agg -> mapToResponse(agg, deviceMap.get(agg.getDeviceId())))
                .collect(Collectors.toList());

        double totalEnergy = aggregations.stream()
                .mapToDouble(AggregatedReading::getTotalEnergyConsumed)
                .sum();

        double avgPower = aggregations.stream()
                .mapToDouble(AggregatedReading::getAvgPower)
                .average()
                .orElse(0.0);

        int totalReadings = aggregations.stream()
                .mapToInt(AggregatedReading::getReadingCount)
                .sum();

        return new AnalyticsResponse(responses, totalEnergy, avgPower, totalReadings);
    }

    private AggregatedReadingResponse mapToResponse(AggregatedReading agg,
                                                    ElectricalDevice device) {
        String deviceName;

        if (device != null) {
            // Individual device aggregation
            deviceName = device.getDeviceName();
        } else if (agg.getDeviceType() != null) {
            // Grouped aggregation - show device type with device count
            deviceName = agg.getDeviceType().toString() +
                    " (" + agg.getDeviceCount() + " devices)";
        } else {
            deviceName = "Unknown";
        }

        return new AggregatedReadingResponse(
                agg.getId(),
                agg.getDeviceId(),
                deviceName,
                agg.getAggregationType(),
                agg.getPeriodStart(),
                agg.getPeriodEnd(),
                agg.getAvgVoltage(),
                agg.getMaxVoltage(),
                agg.getMinVoltage(),
                agg.getAvgCurrent(),
                agg.getMaxCurrent(),
                agg.getMinCurrent(),
                agg.getAvgPower(),
                agg.getMaxPower(),
                agg.getMinPower(),
                agg.getTotalEnergyConsumed(),
                agg.getReadingCount()
        );
    }
}