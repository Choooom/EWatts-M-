package com.example.solar.service;

import com.example.solar.model.WeatherData;
import com.example.solar.repository.WeatherRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WeatherService {

    private static final Logger logger = LoggerFactory.getLogger(WeatherService.class);
    private final WeatherRepository repository;

    public WeatherService(WeatherRepository repository) {
        this.repository = repository;
    }

    public List<WeatherData> getAllWeatherData() {
        try {
            logger.info("🔧 WeatherService: Fetching all weather data");
            List<WeatherData> data = repository.findAllOrderedByDateDesc();
            logger.info("✅ Successfully retrieved {} records", data.size());
            return data;
        } catch (Exception e) {
            logger.error("❌ Error fetching weather data: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to retrieve weather data", e);
        }
    }

    public List<WeatherData> getRecentWeatherData(int limit) {
        try {
            logger.info("🔧 WeatherService: Fetching {} recent weather records", limit);
            List<WeatherData> allData = repository.findAllOrderedByDateDesc();
            return allData.stream().limit(limit).toList();
        } catch (Exception e) {
            logger.error("❌ Error fetching recent weather data: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to retrieve recent weather data", e);
        }
    }
}
