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

    @Scheduled(cron = "${aggregation.hourly-cron}")
    @Transactional
    public void aggregateHourlyData() {
        log.info("Starting hourly aggregation...");
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime hourStart = now.truncatedTo(ChronoUnit.HOURS).minusHours(1);
        LocalDateTime hourEnd = hourStart.plusHours(1);

        aggregateForAllDevices(AggregationType.HOURLY, hourStart, hourEnd);
        log.info("Hourly aggregation completed");
    }

    @Scheduled(cron = "${aggregation.daily-cron}")
    @Transactional
    public void aggregateDailyData() {
        log.info("Starting daily aggregation...");
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime dayStart = now.truncatedTo(ChronoUnit.DAYS).minusDays(1);
        LocalDateTime dayEnd = dayStart.plusDays(1);

        aggregateForAllDevices(AggregationType.DAILY, dayStart, dayEnd);
        log.info("Daily aggregation completed");
    }

    @Scheduled(cron = "${aggregation.monthly-cron}")
    @Transactional
    public void aggregateMonthlyData() {
        log.info("Starting monthly aggregation...");
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime monthStart = now.withDayOfMonth(1).truncatedTo(ChronoUnit.DAYS).minusMonths(1);
        LocalDateTime monthEnd = monthStart.plusMonths(1);

        aggregateForAllDevices(AggregationType.MONTHLY, monthStart, monthEnd);
        log.info("Monthly aggregation completed");
    }

    private void aggregateForAllDevices(AggregationType type,
                                        LocalDateTime start,
                                        LocalDateTime end) {
        List<ElectricalDevice> devices = deviceRepository.findAll();

        for (ElectricalDevice device : devices) {
            try {
                aggregateDeviceData(device, type, start, end);
            } catch (Exception e) {
                log.error("Error aggregating data for device {}: {}",
                        device.getId(), e.getMessage(), e);
            }
        }
    }

    @Transactional
    public void aggregateDeviceData(ElectricalDevice device,
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

        double energyStart = readings.get(readings.size() - 1).getEnergy();
        double energyEnd = readings.get(0).getEnergy();
        double totalEnergyConsumed = energyEnd - energyStart;

        AggregatedReading aggregated = new AggregatedReading();
        aggregated.setDeviceId(device.getId());
        aggregated.setUserId(device.getUserId());
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

        aggregated.setTotalEnergyConsumed(Math.max(0, totalEnergyConsumed));
        aggregated.setReadingCount(readings.size());

        aggregatedRepository.save(aggregated);

        log.info("Created {} aggregation for device {}: {} readings, {} kWh",
                type, device.getId(), readings.size(), totalEnergyConsumed);
    }

    public AnalyticsResponse getAnalytics(Long userId,
                                          AggregationType type,
                                          LocalDateTime start,
                                          LocalDateTime end,
                                          Long deviceId) {
        List<AggregatedReading> aggregations;

        if (deviceId != null) {
            aggregations = aggregatedRepository
                    .findByDeviceIdAndAggregationTypeAndPeriodStartBetweenOrderByPeriodStartDesc(
                            deviceId, type, start, end);
        } else {
            aggregations = aggregatedRepository
                    .findByUserIdAndAggregationTypeAndPeriodStartBetweenOrderByPeriodStartDesc(
                            userId, type, start, end);
        }

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
        return new AggregatedReadingResponse(
                agg.getId(),
                agg.getDeviceId(),
                device != null ? device.getDeviceName() : "Unknown",
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