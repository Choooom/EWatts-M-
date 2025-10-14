package com.example.solar.service;

import com.example.solar.model.WeatherData;
import com.example.solar.repository.WeatherRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
public class WeatherForecastService {

    private static final Logger logger = LoggerFactory.getLogger(WeatherForecastService.class);
    private final WeatherRepository repository;

    public WeatherForecastService(WeatherRepository repository) {
        this.repository = repository;
    }

    public Map<String, Object> getCurrentWeatherByLocation(String location) {
        try {
            String normalizedLocation = normalizeLocation(location);
            logger.info("🌤️ Getting current weather for location: {}", normalizedLocation);
            LocalDate today = LocalDate.now();
            Map<String, Object> currentWeather = new HashMap<>();

            Optional<WeatherData> todayWeather = repository.findByLocationAndDate(
                    normalizedLocation, today.getYear(), today.getMonthValue(), today.getDayOfMonth()
            );

            if (todayWeather.isPresent()) {
                currentWeather = buildWeatherMap(location, today, todayWeather.get(), false);
            } else {
                List<WeatherData> latestList = repository.findLatestByLocation(normalizedLocation);
                Optional<WeatherData> latestWeather = latestList.stream().findFirst();

                if (latestWeather.isPresent()) {
                    currentWeather = buildWeatherMap(location, today, latestWeather.get(), true);
                } else {
                    currentWeather.put("error", "No weather data available for " + location);
                }
            }

            return currentWeather;

        } catch (Exception e) {
            logger.error("❌ Error getting current weather: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to get current weather", e);
        }
    }

    public Map<String, Object> getWeeklyForecast(String location) {
        try {
            String normalizedLocation = normalizeLocation(location);
            logger.info("📅 Getting weekly forecast for location: {}", normalizedLocation);

            LocalDate startDate = LocalDate.now();
            List<Map<String, Object>> weeklyForecast = new ArrayList<>();

            for (int i = 0; i < 7; i++) {
                LocalDate forecastDate = startDate.plusDays(i);
                Map<String, Object> dayForecast = generateDayForecast(normalizedLocation, forecastDate, i == 0);
                weeklyForecast.add(dayForecast);
            }

            Map<String, Object> result = new HashMap<>();
            result.put("location", location);
            result.put("weeklyForecast", weeklyForecast);

            return result;

        } catch (Exception e) {
            logger.error("❌ Error getting weekly forecast: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to get weekly forecast", e);
        }
    }

    private Map<String, Object> generateDayForecast(String location, LocalDate date, boolean isToday) {
        Map<String, Object> dayForecast = new HashMap<>();

        Optional<WeatherData> actualData = repository.findByLocationAndDate(
                location, date.getYear(), date.getMonthValue(), date.getDayOfMonth()
        );

        dayForecast.put("day", isToday ? "Today" : date.format(DateTimeFormatter.ofPattern("EEE")));
        dayForecast.put("date", date.format(DateTimeFormatter.ofPattern("MMM dd")));

        if (actualData.isPresent()) {
            WeatherData weather = actualData.get();
            dayForecast.put("maxTemp", weather.getTmax());
            dayForecast.put("minTemp", weather.getTmin());
            dayForecast.put("weatherCondition", generateCondition(weather.getTmax(), weather.getRainfall())); // FIXED
            dayForecast.put("rainfall", weather.getRainfall());
            dayForecast.put("humidity", weather.getRh());
        } else {
            Map<String, Object> predictedWeather = generatePredictedWeather(location, date);
            dayForecast.putAll(predictedWeather);
            dayForecast.put("predicted", true);
        }

        return dayForecast;
    }

    private Map<String, Object> generatePredictedWeather(String location, LocalDate date) {
        List<WeatherData> historicalData = repository.findByLocationAndMonth(location, date.getMonthValue());

        if (!historicalData.isEmpty()) {
            double avgMaxTemp = historicalData.stream().mapToDouble(WeatherData::getTmax).average().orElse(30.0);
            double avgMinTemp = historicalData.stream().mapToDouble(WeatherData::getTmin).average().orElse(24.0);
            double avgRainfall = historicalData.stream().mapToDouble(WeatherData::getRainfall).average().orElse(5.0);
            double avgHumidity = historicalData.stream().mapToDouble(WeatherData::getRh).average().orElse(75.0);

            Random random = new Random();
            double tempVariation = (random.nextDouble() - 0.5) * 4;

            Map<String, Object> predicted = new HashMap<>();
            double maxT = avgMaxTemp + tempVariation;
            predicted.put("maxTemp", Math.round(maxT * 10.0) / 10.0);
            predicted.put("minTemp", Math.round((avgMinTemp + tempVariation) * 10.0) / 10.0);
            predicted.put("rainfall", Math.round(avgRainfall * 10.0) / 10.0);
            predicted.put("humidity", Math.round(avgHumidity));
            predicted.put("weatherCondition", generateCondition(maxT, avgRainfall));

            return predicted;
        }

        Map<String, Object> defaultPrediction = new HashMap<>();
        defaultPrediction.put("maxTemp", 32.0);
        defaultPrediction.put("minTemp", 25.0);
        defaultPrediction.put("rainfall", 2.0);
        defaultPrediction.put("humidity", 75);
        defaultPrediction.put("weatherCondition", "Partly Cloudy");

        return defaultPrediction;
    }

    private Map<String, Object> buildWeatherMap(String location, LocalDate date, WeatherData weather, boolean isFallback) {
        Map<String, Object> map = new HashMap<>();
        map.put("location", location);
        map.put("date", date.format(DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy")));
        map.put("temperature", weather.getTmax());
        map.put("minTemperature", weather.getTmin());
        map.put("windSpeed", weather.getWindSpeed());
        map.put("windDirection", getWindDirectionText(weather.getWindDirection()));
        map.put("humidity", weather.getRh());
        map.put("rainfall", weather.getRainfall());
        map.put("weatherCondition", generateCondition(weather.getTmax(), weather.getRainfall())); // FIXED
        map.put("hourlyForecast", generateHourlyForecast(weather));
        if (isFallback) {
            map.put("note", "Using latest available data");
        }
        return map;
    }

    private List<Map<String, Object>> generateHourlyForecast(WeatherData baseWeather) {
        List<Map<String, Object>> hourlyForecast = new ArrayList<>();
        String[] hours = {"12 PM", "3 PM", "6 PM", "9 PM", "12 AM", "3 AM", "6 AM", "9 AM"};
        double[] tempMultipliers = {0.9, 1.0, 0.8, 0.6, 0.4, 0.3, 0.4, 0.7};

        double maxTemp = baseWeather.getTmax();
        double minTemp = baseWeather.getTmin();

        for (int i = 0; i < hours.length; i++) {
            double hourTemp = minTemp + (maxTemp - minTemp) * tempMultipliers[i];

            Map<String, Object> hourData = new HashMap<>();
            hourData.put("time", hours[i]);
            hourData.put("temperature", Math.round(hourTemp * 10.0) / 10.0);
            hourData.put("condition", getHourlyCondition(hourTemp, baseWeather.getRainfall(), i));

            hourlyForecast.add(hourData);
        }

        return hourlyForecast;
    }

    private String getHourlyCondition(double temp, double rainfall, int hourIndex) {
        if (rainfall > 10 && hourIndex >= 2 && hourIndex <= 5) return "Rainy";
        if (temp > 35) return "Very Hot";
        if (temp > 30) return "Hot";
        if (temp < 25) return "Cool";
        return "Warm";
    }

    private String getWindDirectionText(int degrees) {
        String[] directions = {
                "N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE",
                "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"
        };
        int index = (int) Math.round(degrees / 22.5) % 16;
        return directions[index];
    }

    private String generateCondition(double tmax, double rainfall) {
        if (rainfall > 10) return "Rainy";
        if (tmax > 35) return "Very Hot";
        if (tmax > 30) return "Hot";
        if (tmax < 25) return "Cool";
        return "Partly Cloudy";
    }

    public List<String> getAvailableLocations() {
        return repository.findDistinctLocations();
    }

    private String normalizeLocation(String location) {
        return location.trim().replaceAll("\\s+", " ").toLowerCase();
    }
}
