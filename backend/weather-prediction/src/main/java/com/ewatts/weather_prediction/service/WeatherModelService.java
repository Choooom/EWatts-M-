package com.ewatts.weather_prediction.service;

import com.ewatts.weather_prediction.models.SolarConditions;
import org.springframework.stereotype.Service;
import java.util.Map;

@Service
public class WeatherModelService {

    public SolarConditions calculateSolarConditions(Map<String, Object> hourly, int index) {
        double cloudCover = getVal(hourly, "cloud_cover", index);
        double temp = getVal(hourly, "temperature_2m", index);
        double wind = getVal(hourly, "wind_speed_10m", index);
        double direct = getVal(hourly, "direct_radiation", index);
        double diffuse = getVal(hourly, "diffuse_radiation", index);
        double totalIrradiance = direct + diffuse;

        double cellTemp = temp + (totalIrradiance / 1000) * 25;
        double cloudFactor = 1 - (cloudCover / 100) * 0.8;
        double tempFactor = 1 - Math.max(0, (cellTemp - 25) * 0.004);
        double efficiency = Math.max(0.1, cloudFactor * tempFactor);

        return SolarConditions.builder()
                .solarIrradiance(totalIrradiance)
                .cellTemperature(cellTemp)
                .airMass(1.5)
                .windSpeed(wind)
                .cloudCoverage(cloudCover)
                .estimatedEfficiencyFactor(efficiency)
                .build();
    }

    private double getVal(Map<String, Object> hourly, String key, int index) {
        try {
            var list = (java.util.List<Number>) hourly.get(key);
            return list.get(Math.min(index, list.size()-1)).doubleValue();
        } catch (Exception e) {
            return 0;
        }
    }
}

