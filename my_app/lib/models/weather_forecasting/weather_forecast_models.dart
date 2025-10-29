// lib/models/weather_forecast_models.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_forecast_models.freezed.dart';
part 'weather_forecast_models.g.dart';

/// Weather Condition Details
@freezed
class WeatherCondition with _$WeatherCondition {
  const factory WeatherCondition({
    @JsonKey(name: 'cloud_description') required String cloudDescription,
    @JsonKey(name: 'wind_description') required String windDescription,
    required String precipitation,
    required double temperature,
    required double humidity,
    @JsonKey(name: 'wind_speed') required double windSpeed,
    @JsonKey(name: 'precipitation_probability')
    required double precipitationProbability,
  }) = _WeatherCondition;

  factory WeatherCondition.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionFromJson(json);
}

/// Solar Conditions
@freezed
class SolarConditions with _$SolarConditions {
  const factory SolarConditions({
    @JsonKey(name: 'solar_irradiance') required double solarIrradiance,
    @JsonKey(name: 'cell_temperature') required double cellTemperature,
    @JsonKey(name: 'air_mass') required double airMass,
    @JsonKey(name: 'wind_speed') required double windSpeed,
    @JsonKey(name: 'cloud_coverage') required double cloudCoverage,
    @JsonKey(name: 'estimated_efficiency_factor')
    required double estimatedEfficiencyFactor,
  }) = _SolarConditions;

  factory SolarConditions.fromJson(Map<String, dynamic> json) =>
      _$SolarConditionsFromJson(json);
}

/// Weather Prediction for a specific time
@freezed
class WeatherPrediction with _$WeatherPrediction {
  const factory WeatherPrediction({
    required Map<String, double> location,
    @JsonKey(name: 'forecast_date') required String forecastDate,
    @JsonKey(name: 'weather_condition')
    required WeatherCondition weatherCondition,
    @JsonKey(name: 'solar_conditions') required SolarConditions solarConditions,
    @JsonKey(name: 'confidence_score') required double confidenceScore,
  }) = _WeatherPrediction;

  factory WeatherPrediction.fromJson(Map<String, dynamic> json) =>
      _$WeatherPredictionFromJson(json);
}

/// Complete Weather Response
@freezed
class WeatherResponse with _$WeatherResponse {
  const factory WeatherResponse({
    required List<WeatherPrediction> predictions,
    @JsonKey(name: 'model_used') required String modelUsed,
    @JsonKey(name: 'generated_at') required String generatedAt,
  }) = _WeatherResponse;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}

/// Location Request
@freezed
class LocationRequest with _$LocationRequest {
  const factory LocationRequest({
    required double latitude,
    required double longitude,
  }) = _LocationRequest;

  factory LocationRequest.fromJson(Map<String, dynamic> json) =>
      _$LocationRequestFromJson(json);
}

/// Daily Weather Summary (aggregated from hourly data)
class DailyWeatherSummary {
  final DateTime date;
  final String weatherStatus; // sunny, cloudy, rainy, storm
  final double avgTemperature;
  final double maxTemperature;
  final double minTemperature;
  final double avgSolarEfficiency;
  final double maxSolarEfficiency;
  final double totalEstimatedOutput; // kWh for the day
  final double precipitationProbability;
  final String cloudDescription;
  final double confidenceScore;

  DailyWeatherSummary({
    required this.date,
    required this.weatherStatus,
    required this.avgTemperature,
    required this.maxTemperature,
    required this.minTemperature,
    required this.avgSolarEfficiency,
    required this.maxSolarEfficiency,
    required this.totalEstimatedOutput,
    required this.precipitationProbability,
    required this.cloudDescription,
    required this.confidenceScore,
  });

  /// Create from list of hourly predictions
  factory DailyWeatherSummary.fromHourlyPredictions(
    DateTime date,
    List<WeatherPrediction> hourlyPredictions,
  ) {
    if (hourlyPredictions.isEmpty) {
      return DailyWeatherSummary(
        date: date,
        weatherStatus: 'unknown',
        avgTemperature: 0,
        maxTemperature: 0,
        minTemperature: 0,
        avgSolarEfficiency: 0,
        maxSolarEfficiency: 0,
        totalEstimatedOutput: 0,
        precipitationProbability: 0,
        cloudDescription: 'Unknown',
        confidenceScore: 0,
      );
    }

    final temperatures = hourlyPredictions
        .map((p) => p.weatherCondition.temperature)
        .toList();
    final efficiencies = hourlyPredictions
        .map((p) => p.solarConditions.estimatedEfficiencyFactor)
        .toList();

    // Calculate total output from solar irradiance and efficiency
    final outputs = hourlyPredictions.map((p) {
      // Estimate output: irradiance * efficiency * panel_area * hours
      // Assuming 1kW system (approximately 6-7 m² of panels)
      final irradiance =
          p.solarConditions.solarIrradiance / 1000; // Convert W/m² to kW/m²
      final efficiency = p.solarConditions.estimatedEfficiencyFactor;
      return irradiance * efficiency * 6.5; // Approximate kW for 1kW system
    }).toList();

    // Determine weather status based on cloud description and precipitation
    String determineWeatherStatus() {
      final precipProbs = hourlyPredictions
          .map((p) => p.weatherCondition.precipitationProbability)
          .toList();
      final avgPrecipProb =
          precipProbs.reduce((a, b) => a + b) / precipProbs.length;

      final cloudDescs = hourlyPredictions
          .map((p) => p.weatherCondition.cloudDescription.toLowerCase())
          .toList();

      if (avgPrecipProb > 60 || cloudDescs.any((d) => d.contains('storm'))) {
        return 'storm';
      } else if (avgPrecipProb > 30 ||
          cloudDescs.any((d) => d.contains('rain'))) {
        return 'rainy';
      } else if (cloudDescs.any(
        (d) => d.contains('overcast') || d.contains('cloudy'),
      )) {
        return 'cloudy';
      } else if (cloudDescs.any((d) => d.contains('partly'))) {
        return 'partly_cloudy';
      } else {
        return 'sunny';
      }
    }

    return DailyWeatherSummary(
      date: date,
      weatherStatus: determineWeatherStatus(),
      avgTemperature:
          temperatures.reduce((a, b) => a + b) / temperatures.length,
      maxTemperature: temperatures.reduce((a, b) => a > b ? a : b),
      minTemperature: temperatures.reduce((a, b) => a < b ? a : b),
      avgSolarEfficiency:
          efficiencies.reduce((a, b) => a + b) / efficiencies.length,
      maxSolarEfficiency: efficiencies.reduce((a, b) => a > b ? a : b),
      totalEstimatedOutput: outputs.reduce((a, b) => a + b),
      precipitationProbability:
          hourlyPredictions
              .map((p) => p.weatherCondition.precipitationProbability)
              .reduce((a, b) => a + b) /
          hourlyPredictions.length,
      cloudDescription:
          hourlyPredictions.first.weatherCondition.cloudDescription,
      confidenceScore:
          hourlyPredictions
              .map((p) => p.confidenceScore)
              .reduce((a, b) => a + b) /
          hourlyPredictions.length,
    );
  }
}
