package com.ewatts.electricalreadings.dto;

import com.ewatts.electricalreadings.entity.DeviceType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

/**
 * Response DTO for energy breakdown by device type
 * Useful for comparing solar generation vs grid consumption vs battery storage
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class EnergyBreakdownResponse {

    // Energy by device type (kWh)
    private Double houseMeterEnergy;      // Total grid consumption
    private Double solarPanelEnergy;      // Total solar generation
    private Double batteryEnergy;         // Total battery storage
    private Double applianceEnergy;       // Total appliance consumption

    // Calculated metrics
    private Double netGridConsumption;    // Grid - Solar (positive = importing, negative = exporting)
    private Double solarSelfConsumption;  // Solar energy used directly
    private Double solarToGrid;           // Solar energy exported to grid
    private Double batteryCharged;        // Energy stored in battery
    private Double batteryDischarged;     // Energy used from battery

    // Percentages
    private Double solarContributionPercent;  // % of consumption from solar
    private Double gridContributionPercent;   // % of consumption from grid
    private Double selfSufficiencyPercent;    // % of total consumption met by solar+battery

    // Cost estimates (if applicable)
    private Double estimatedGridCost;
    private Double estimatedSolarSavings;

    // Detailed breakdown by device type
    private Map<DeviceType, DeviceTypeStats> deviceTypeBreakdown;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class DeviceTypeStats {
        private DeviceType deviceType;
        private Double totalEnergy;
        private Double avgPower;
        private Double maxPower;
        private Integer deviceCount;
        private Integer readingCount;
    }
}