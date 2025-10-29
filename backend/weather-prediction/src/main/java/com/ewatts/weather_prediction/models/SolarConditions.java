package com.ewatts.weather_prediction.models;

import lombok.Builder;
import lombok.Data;
@Data @Builder
public class SolarConditions {
    private double solarIrradiance;
    private double cellTemperature;
    private double airMass;
    private double windSpeed;
    private double cloudCoverage;
    private double estimatedEfficiencyFactor;
}

