// lib/providers/weather_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/weather_forecasting/weather_forecast_models.dart';
import 'package:my_app/services/weather_forecasting/weather_service.dart';

/// Provider for WeatherService
final weatherServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService();
});

/// Provider for fetching weather forecast
final weatherForecastProvider = FutureProvider<WeatherResponse?>((ref) async {
  final weatherService = ref.watch(weatherServiceProvider);

  // Default location (Manila, Philippines - from your user context)
  // You can make this dynamic based on user's actual location
  const latitude = 14.5995;
  const longitude = 120.9842;

  try {
    final forecast = await weatherService.getWeatherForecast(
      latitude: latitude,
      longitude: longitude,
    );
    return forecast;
  } catch (e) {
    print('Error fetching weather forecast: $e');
    return null;
  }
});

/// Provider for daily weather summaries grouped by date
final dailyWeatherSummariesProvider = Provider<List<DailyWeatherSummary>>((
  ref,
) {
  final forecastAsync = ref.watch(weatherForecastProvider);

  return forecastAsync.when(
    data: (weatherResponse) {
      if (weatherResponse == null) return [];

      // Group predictions by date
      final Map<DateTime, List<WeatherPrediction>> groupedByDate = {};

      for (var prediction in weatherResponse.predictions) {
        final dateTime = DateTime.parse(prediction.forecastDate);
        final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);

        if (!groupedByDate.containsKey(dateOnly)) {
          groupedByDate[dateOnly] = [];
        }
        groupedByDate[dateOnly]!.add(prediction);
      }

      // Create daily summaries
      final summaries = groupedByDate.entries.map((entry) {
        return DailyWeatherSummary.fromHourlyPredictions(
          entry.key,
          entry.value,
        );
      }).toList();

      // Sort by date
      summaries.sort((a, b) => a.date.compareTo(b.date));

      return summaries;
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

/// Provider for today's weather summary
final todayWeatherSummaryProvider = Provider<DailyWeatherSummary?>((ref) {
  final dailySummaries = ref.watch(dailyWeatherSummariesProvider);

  if (dailySummaries.isEmpty) return null;

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  try {
    return dailySummaries.firstWhere(
      (summary) =>
          summary.date.year == today.year &&
          summary.date.month == today.month &&
          summary.date.day == today.day,
    );
  } catch (e) {
    // If today's data not found, return first available
    return dailySummaries.first;
  }
});

/// Provider for hourly predictions for a specific date
final hourlyPredictionsForDateProvider =
    Provider.family<List<WeatherPrediction>, DateTime>((ref, date) {
      final forecastAsync = ref.watch(weatherForecastProvider);

      return forecastAsync.when(
        data: (weatherResponse) {
          if (weatherResponse == null) return [];

          final dateOnly = DateTime(date.year, date.month, date.day);

          return weatherResponse.predictions.where((prediction) {
            final predictionDate = DateTime.parse(prediction.forecastDate);
            final predictionDateOnly = DateTime(
              predictionDate.year,
              predictionDate.month,
              predictionDate.day,
            );
            return predictionDateOnly == dateOnly;
          }).toList();
        },
        loading: () => [],
        error: (_, __) => [],
      );
    });

/// Provider to track selected date for detailed view
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

/// Provider to trigger weather refresh
final weatherRefreshProvider = StateProvider<int>((ref) => 0);
