package com.ewatts.weather_prediction.controller;

import com.ewatts.weather_prediction.models.*;
import com.ewatts.weather_prediction.service.PAGASAClassifier;
import com.ewatts.weather_prediction.service.WeatherModelService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.util.*;

@RestController
@RequiredArgsConstructor
public class WeatherController {

    private final WeatherModelService weatherModel;
    private final PAGASAClassifier classifier;

    @PostMapping("/predict")
    public ResponseEntity<WeatherResponse> predict(@RequestBody LocationRequest location) {
        // Simulate data call (you could replace with Open-Meteo call)
        Map<String, Object> hourly = mockForecast();

        List<WeatherPrediction> predictions = new ArrayList<>();
        for (int i = 0; i < 24; i++) {
            double temp = ((List<Double>) hourly.get("temperature_2m")).get(i);
            double humidity = ((List<Double>) hourly.get("relative_humidity_2m")).get(i);
            double cloud = ((List<Double>) hourly.get("cloud_cover")).get(i);
            double wind = ((List<Double>) hourly.get("wind_speed_10m")).get(i);
            double precip = ((List<Double>) hourly.get("precipitation")).get(i);

            WeatherCondition condition = WeatherCondition.builder()
                    .cloudDescription(classifier.classifyClouds(cloud))
                    .windDescription(classifier.classifyWind(wind))
                    .precipitation(classifier.classifyPrecipitation(precip))
                    .temperature(temp)
                    .humidity(humidity)
                    .windSpeed(wind)
                    .precipitationProbability(Math.min(100, precip * 10))
                    .build();

            SolarConditions solar = weatherModel.calculateSolarConditions(hourly, i);
            double confidence = Math.max(0.5, 0.9 - (i / 24.0 * 0.05));

            predictions.add(WeatherPrediction.builder()
                    .location(Map.of("latitude", location.getLatitude(), "longitude", location.getLongitude()))
                    .forecastDate(LocalDateTime.now().plusHours(i).toString())
                    .weatherCondition(condition)
                    .solarConditions(solar)
                    .confidenceScore(confidence)
                    .build());
        }

        WeatherResponse response = WeatherResponse.builder()
                .predictions(predictions)
                .modelUsed("Open-Meteo + PAGASA Classification (Java)")
                .generatedAt(LocalDateTime.now().toString())
                .build();

        return ResponseEntity.ok(response);
    }

    private Map<String, Object> mockForecast() {
        return Map.of(
                "temperature_2m", Collections.nCopies(24, 30.0),
                "relative_humidity_2m", Collections.nCopies(24, 70.0),
                "precipitation", Collections.nCopies(24, 0.5),
                "cloud_cover", Collections.nCopies(24, 40.0),
                "wind_speed_10m", Collections.nCopies(24, 5.0),
                "direct_radiation", Collections.nCopies(24, 200.0),
                "diffuse_radiation", Collections.nCopies(24, 100.0)
        );
    }

    @GetMapping("/health")
    public Map<String, Object> health() {
        return Map.of("status", "healthy", "timestamp", LocalDateTime.now().toString());
    }
}

