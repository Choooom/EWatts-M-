package com.ewatts.electricalreadings.service;

import com.ewatts.electricalreadings.dto.EnergyBreakdownResponse;
import com.ewatts.electricalreadings.entity.AggregatedReading;
import com.ewatts.electricalreadings.entity.AggregationType;
import com.ewatts.electricalreadings.entity.DeviceType;
import com.ewatts.electricalreadings.repository.AggregatedReadingRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service for analyzing energy consumption patterns across different device types
 * Provides insights into solar generation, grid consumption, battery usage, and appliance consumption
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class EnergyAnalysisService {

    private final AggregatedReadingRepository aggregatedRepository;

    // Default electricity rate (PHP per kWh) - can be made configurable per user
    private static final double DEFAULT_GRID_RATE = 11.50; // PHP per kWh (Meralco average)

    /**
     * Get comprehensive energy breakdown for a user across all device types
     */
    public EnergyBreakdownResponse getEnergyBreakdown(Long userId,
                                                      AggregationType type,
                                                      LocalDateTime start,
                                                      LocalDateTime end) {

        EnergyBreakdownResponse breakdown = new EnergyBreakdownResponse();
        Map<DeviceType, EnergyBreakdownResponse.DeviceTypeStats> deviceTypeBreakdown = new HashMap<>();

        // Get aggregated data for each device type
        for (DeviceType deviceType : DeviceType.values()) {
            List<AggregatedReading> aggregations = aggregatedRepository
                    .findByUserIdAndDeviceTypeAndAggregationTypeAndPeriodStartBetweenOrderByPeriodStartDesc(
                            userId, deviceType, type, start, end);

            if (!aggregations.isEmpty()) {
                double totalEnergy = aggregations.stream()
                        .mapToDouble(AggregatedReading::getTotalEnergyConsumed)
                        .sum();

                double avgPower = aggregations.stream()
                        .mapToDouble(AggregatedReading::getAvgPower)
                        .average()
                        .orElse(0.0);

                double maxPower = aggregations.stream()
                        .mapToDouble(AggregatedReading::getMaxPower)
                        .max()
                        .orElse(0.0);

                int totalReadings = aggregations.stream()
                        .mapToInt(AggregatedReading::getReadingCount)
                        .sum();

                int deviceCount = aggregations.stream()
                        .mapToInt(AggregatedReading::getDeviceCount)
                        .max()
                        .orElse(0);

                EnergyBreakdownResponse.DeviceTypeStats stats =
                        new EnergyBreakdownResponse.DeviceTypeStats(
                                deviceType, totalEnergy, avgPower, maxPower,
                                deviceCount, totalReadings);

                deviceTypeBreakdown.put(deviceType, stats);

                // Set individual device type energies
                switch (deviceType) {
                    case HOUSE_METER:
                        breakdown.setHouseMeterEnergy(totalEnergy);
                        break;
                    case SOLAR_PANEL:
                        breakdown.setSolarPanelEnergy(totalEnergy);
                        break;
                    case BATTERY:
                        breakdown.setBatteryEnergy(totalEnergy);
                        break;
                    case APPLIANCE:
                        breakdown.setApplianceEnergy(totalEnergy);
                        break;
                }
            }
        }

        breakdown.setDeviceTypeBreakdown(deviceTypeBreakdown);

        // Calculate derived metrics
        calculateDerivedMetrics(breakdown);

        log.info("Generated energy breakdown for user {}: Grid={} kWh, Solar={} kWh, Battery={} kWh, Appliances={} kWh",
                userId,
                breakdown.getHouseMeterEnergy(),
                breakdown.getSolarPanelEnergy(),
                breakdown.getBatteryEnergy(),
                breakdown.getApplianceEnergy());

        return breakdown;
    }

    private void calculateDerivedMetrics(EnergyBreakdownResponse breakdown) {
        double gridEnergy = breakdown.getHouseMeterEnergy() != null ? breakdown.getHouseMeterEnergy() : 0.0;
        double solarEnergy = breakdown.getSolarPanelEnergy() != null ? breakdown.getSolarPanelEnergy() : 0.0;
        double batteryEnergy = breakdown.getBatteryEnergy() != null ? breakdown.getBatteryEnergy() : 0.0;
        double applianceEnergy = breakdown.getApplianceEnergy() != null ? breakdown.getApplianceEnergy() : 0.0;

        // Net grid consumption (positive = importing from grid, negative = exporting to grid)
        double netGridConsumption = gridEnergy - solarEnergy;
        breakdown.setNetGridConsumption(netGridConsumption);

        // Solar self-consumption (solar energy used directly, not exported)
        double solarSelfConsumption = Math.min(solarEnergy, applianceEnergy);
        breakdown.setSolarSelfConsumption(solarSelfConsumption);

        // Solar exported to grid (if solar generation exceeds consumption)
        double solarToGrid = Math.max(0, solarEnergy - applianceEnergy);
        breakdown.setSolarToGrid(solarToGrid);

        // Battery metrics (simplified - assumes battery energy is net charged/discharged)
        if (batteryEnergy >= 0) {
            breakdown.setBatteryCharged(batteryEnergy);
            breakdown.setBatteryDischarged(0.0);
        } else {
            breakdown.setBatteryCharged(0.0);
            breakdown.setBatteryDischarged(Math.abs(batteryEnergy));
        }

        // Calculate total consumption (house meter energy is the actual consumption from grid)
        double totalConsumption = gridEnergy + solarSelfConsumption;

        // Percentage calculations
        if (totalConsumption > 0) {
            double solarContribution = (solarSelfConsumption / totalConsumption) * 100;
            double gridContribution = (gridEnergy / totalConsumption) * 100;
            double selfSufficiency = ((solarSelfConsumption + Math.abs(batteryEnergy)) / totalConsumption) * 100;

            breakdown.setSolarContributionPercent(Math.round(solarContribution * 100.0) / 100.0);
            breakdown.setGridContributionPercent(Math.round(gridContribution * 100.0) / 100.0);
            breakdown.setSelfSufficiencyPercent(Math.min(100.0, Math.round(selfSufficiency * 100.0) / 100.0));
        } else {
            breakdown.setSolarContributionPercent(0.0);
            breakdown.setGridContributionPercent(0.0);
            breakdown.setSelfSufficiencyPercent(0.0);
        }

        // Cost estimates
        double estimatedGridCost = gridEnergy * DEFAULT_GRID_RATE;
        double estimatedSolarSavings = solarSelfConsumption * DEFAULT_GRID_RATE;

        breakdown.setEstimatedGridCost(Math.round(estimatedGridCost * 100.0) / 100.0);
        breakdown.setEstimatedSolarSavings(Math.round(estimatedSolarSavings * 100.0) / 100.0);
    }

    /**
     * Calculate energy flow for a specific period
     * Shows how energy flows from solar -> battery -> appliances -> grid
     */
    public Map<String, Double> calculateEnergyFlow(Long userId,
                                                   AggregationType type,
                                                   LocalDateTime start,
                                                   LocalDateTime end) {
        EnergyBreakdownResponse breakdown = getEnergyBreakdown(userId, type, start, end);

        Map<String, Double> energyFlow = new HashMap<>();
        energyFlow.put("solarGeneration", breakdown.getSolarPanelEnergy());
        energyFlow.put("gridImport", breakdown.getHouseMeterEnergy());
        energyFlow.put("batteryStorage", breakdown.getBatteryEnergy());
        energyFlow.put("applianceConsumption", breakdown.getApplianceEnergy());
        energyFlow.put("solarToAppliances", breakdown.getSolarSelfConsumption());
        energyFlow.put("solarToGrid", breakdown.getSolarToGrid());
        energyFlow.put("netConsumption", breakdown.getNetGridConsumption());

        return energyFlow;
    }
}