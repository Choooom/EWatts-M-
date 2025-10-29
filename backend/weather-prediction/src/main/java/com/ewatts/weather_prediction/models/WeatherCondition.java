package com.ewatts.weather_prediction.models;

import lombok.Builder;
import lombok.Data;
@Data @Builder
public class WeatherCondition {
    private String cloudDescription;
    private String windDescription;
    private String precipitation;
    private double temperature;
    private double humidity;
    private double windSpeed;
    private double precipitationProbability;
}

