package com.ewatts.weather_prediction.models;

import lombok.Builder;
import lombok.Data;
import java.util.Map;
@Data @Builder
public class WeatherPrediction {
    private Map<String, Double> location;
    private String forecastDate;
    private WeatherCondition weatherCondition;
    private SolarConditions solarConditions;
    private double confidenceScore;
}

