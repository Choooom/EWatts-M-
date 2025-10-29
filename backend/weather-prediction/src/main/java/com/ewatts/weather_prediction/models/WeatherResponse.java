package com.ewatts.weather_prediction.models;

import lombok.Builder;
import lombok.Data;
import java.util.List;
@Data @Builder
public class WeatherResponse {
    private List<WeatherPrediction> predictions;
    private String modelUsed;
    private String generatedAt;
}

