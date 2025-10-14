package com.example.solar.controller;

import com.example.solar.service.WeatherForecastService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Map;

import static org.springframework.http.HttpStatus.NOT_FOUND;

@RestController
@RequestMapping("/api/weather")
@CrossOrigin(origins = "http://localhost:3000")
public class WeatherController {

    private final WeatherForecastService weatherService;

    public WeatherController(WeatherForecastService weatherService) {
        this.weatherService = weatherService;
    }

    @GetMapping("/current/{location}")
    public ResponseEntity<Map<String, Object>> getCurrentWeather(@PathVariable String location) {
        Map<String, Object> weather = weatherService.getCurrentWeatherByLocation(location);
        if (weather == null || weather.isEmpty()) {
            throw new ResponseStatusException(NOT_FOUND, "No weather data available for " + location);
        }
        return ResponseEntity.ok(weather);
    }

    @GetMapping("/forecast/{location}")
    public ResponseEntity<Map<String, Object>> getWeeklyForecast(@PathVariable String location) {
        Map<String, Object> forecast = weatherService.getWeeklyForecast(location);
        if (forecast == null || forecast.isEmpty()) {
            throw new ResponseStatusException(NOT_FOUND, "No forecast data available for " + location);
        }
        return ResponseEntity.ok(forecast);
    }

    @GetMapping("/locations")
    public ResponseEntity<List<String>> getAvailableLocations() {
        List<String> locations = weatherService.getAvailableLocations();
        return ResponseEntity.ok(locations);
    }
}
