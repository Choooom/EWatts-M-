// lib/services/weather_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/constants/api_config.dart';
import 'package:my_app/models/weather_forecasting/weather_forecast_models.dart';

class WeatherService {
  // Import the config at the top: import 'package:my_app/config/api_config.dart';
  static const String baseUrl = ApiConfig.baseUrl;

  /// Fetch weather forecast from backend
  Future<WeatherResponse> getWeatherForecast({
    required double latitude,
    required double longitude,
    bool useFreeAI = false,
  }) async {
    try {
      final endpoint = useFreeAI
          ? '/predict-weather-free-ai'
          : '/predict-weather';
      final url = Uri.parse('$baseUrl$endpoint');

      final body = json.encode({'latitude': latitude, 'longitude': longitude});

      final response = await http
          .post(url, headers: {'Content-Type': 'application/json'}, body: body)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception(
                'Request timeout - server took too long to respond',
              );
            },
          );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return WeatherResponse.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to fetch weather data: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Weather service error: $e');
      throw Exception('Failed to connect to weather service: $e');
    }
  }

  /// Check if backend is healthy
  Future<bool> checkHealth() async {
    try {
      final url = Uri.parse('$baseUrl/health');
      final response = await http.get(url).timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (e) {
      print('Health check failed: $e');
      return false;
    }
  }

  /// Get weather icon/animation name from weather status
  static String getWeatherAnimationName(String weatherStatus) {
    final status = weatherStatus.toLowerCase();

    if (status.contains('storm') || status.contains('thunder')) {
      return 'storm';
    } else if (status.contains('rain') || status.contains('drizzle')) {
      return 'rainy';
    } else if (status.contains('cloud')) {
      if (status.contains('partly')) {
        return 'partly_cloudy';
      }
      return 'cloudy';
    } else if (status.contains('clear') || status.contains('sunny')) {
      return 'sunny';
    } else if (status.contains('snow')) {
      return 'snowy';
    } else if (status.contains('fog') || status.contains('mist')) {
      return 'foggy';
    }

    return 'sunny'; // default
  }

  /// Format temperature
  static String formatTemperature(double temp, {bool showUnit = true}) {
    final rounded = temp.toStringAsFixed(0);
    return showUnit ? '$rounded°C' : rounded;
  }

  /// Format solar efficiency as percentage
  static String formatEfficiency(double efficiency) {
    final percentage = (efficiency * 100).toStringAsFixed(1);
    return '$percentage%';
  }

  /// Format power output
  static String formatPowerOutput(double output) {
    if (output >= 1000) {
      return '${(output / 1000).toStringAsFixed(2)} MW';
    } else if (output >= 1) {
      return '${output.toStringAsFixed(2)} kW';
    } else {
      return '${(output * 1000).toStringAsFixed(0)} W';
    }
  }
}
