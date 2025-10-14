// lib/providers/analytics_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/analytics/analytics_models.dart';
import 'package:my_app/models/consumption_overview.dart';
import 'package:my_app/services/analytics/analytics_api_service.dart';
import 'package:my_app/services/analytics/analytics_cache_service.dart';
import 'package:my_app/services/auth/token_storage_service.dart'; // Your existing model
// ============================================================================
// SERVICE PROVIDERS
// ============================================================================

final analyticsApiServiceProvider = Provider<AnalyticsApiService>((ref) {
  return AnalyticsApiService();
});

final analyticsCacheServiceProvider = Provider<AnalyticsCacheService>((ref) {
  return AnalyticsCacheService();
});

// ============================================================================
// STATE PROVIDERS
// ============================================================================

/// Selected Time Frame Provider (0=Daily, 1=Weekly, 2=Monthly, 3=Yearly)
final selectedTimeFrameProvider = StateProvider<int>((ref) => 0);

/// Selected Device Provider (null = all devices)
final selectedDeviceIdProvider = StateProvider<int?>((ref) => null);

// ============================================================================
// COMPUTED PROVIDERS
// ============================================================================

/// Convert selected time frame to AggregationType
final currentAggregationTypeProvider = Provider<AggregationType>((ref) {
  final selectedFrame = ref.watch(selectedTimeFrameProvider);

  switch (selectedFrame) {
    case 0: // Daily
      return AggregationType.hourly; // Show hourly data for daily view
    case 1: // Weekly
      return AggregationType.daily; // Show daily data for weekly view
    case 2: // Monthly
      return AggregationType.daily; // Show daily data for monthly view
    case 3: // Yearly
      return AggregationType.monthly; // Show monthly data for yearly view
    default:
      return AggregationType.daily;
  }
});

/// Date Range Provider based on selected time frame
final dateRangeProvider = Provider<DateRange>((ref) {
  final selectedFrame = ref.watch(selectedTimeFrameProvider);
  final now = DateTime.now();

  switch (selectedFrame) {
    case 0: // Daily - last 24 hours
      return DateRange(
        start: DateTime(now.year, now.month, now.day, 0, 0),
        end: DateTime(now.year, now.month, now.day, 23, 59),
      );
    case 1: // Weekly - last 7 days
      final startOfWeek = now.subtract(Duration(days: 6));
      return DateRange(
        start: DateTime(
          startOfWeek.year,
          startOfWeek.month,
          startOfWeek.day,
          0,
          0,
        ),
        end: DateTime(now.year, now.month, now.day, 23, 59),
      );
    case 2: // Monthly - current month
      return DateRange(
        start: DateTime(now.year, now.month, 1, 0, 0),
        end: DateTime(now.year, now.month + 1, 0, 23, 59),
      );
    case 3: // Yearly - last 12 months
      return DateRange(
        start: DateTime(now.year - 1, now.month, 1, 0, 0),
        end: DateTime(now.year, now.month + 1, 0, 23, 59),
      );
    default:
      return DateRange(start: now, end: now);
  }
});

// ============================================================================
// DATA PROVIDERS
// ============================================================================

/// My Devices Provider
final myDevicesProvider = FutureProvider<List<DeviceResponse>>((ref) async {
  final apiService = ref.read(analyticsApiServiceProvider);
  final tokenStorage = TokenStorageService();

  // Set access token
  final accessToken = await tokenStorage.getAccessToken();
  apiService.setAccessToken(accessToken);

  return await apiService.getMyDevices();
});

/// Analytics Data Provider (with caching)
final analyticsDataProvider = FutureProvider<AnalyticsResponse>((ref) async {
  final apiService = ref.read(analyticsApiServiceProvider);
  final cacheService = ref.read(analyticsCacheServiceProvider);
  final tokenStorage = TokenStorageService();

  final aggregationType = ref.watch(currentAggregationTypeProvider);
  final dateRange = ref.watch(dateRangeProvider);
  final deviceId = ref.watch(selectedDeviceIdProvider);

  // Set access token
  final accessToken = await tokenStorage.getAccessToken();
  apiService.setAccessToken(accessToken);

  try {
    // Try to fetch fresh data from API
    final data = await apiService.getAnalytics(
      type: aggregationType,
      startDate: dateRange.start,
      endDate: dateRange.end,
      deviceId: deviceId,
    );

    // Cache the fresh data
    await cacheService.cacheAnalyticsData(aggregationType, data);

    return data;
  } catch (e) {
    // If API fails, try to return cached data
    final cachedData = await cacheService.getCachedAnalyticsData(
      aggregationType,
      ignoreExpiry: true, // Use cache even if expired in case of error
    );

    if (cachedData != null) {
      return cachedData;
    }

    // If no cache available, rethrow error
    throw Exception('Failed to load analytics data: $e');
  }
});

// ============================================================================
// CONSUMPTION OVERVIEW PROVIDER
// ============================================================================

/// Consumption Overview Data Provider (converted for your graph)
final consumptionOverviewProvider = Provider<List<ConsumptionOverview>>((ref) {
  final analyticsAsync = ref.watch(analyticsDataProvider);

  return analyticsAsync.when(
    data: (analytics) {
      // Convert backend data to ConsumptionOverview for your graph
      if (analytics.data.isEmpty) {
        return [];
      }

      return analytics.data.map((reading) {
        // Calculate percentages based on energy sources
        final totalEnergy = reading.totalEnergyConsumed;

        if (totalEnergy == 0) {
          return ConsumptionOverview(directSolar: 0, battery: 0, grid: 0);
        }

        // Example calculation - adjust based on your device types
        // TODO: You might need to categorize devices and sum their contributions
        return ConsumptionOverview(
          directSolar: 30.0, // Calculate from solar panel devices
          battery: 40.0, // Calculate from battery storage
          grid: 30.0, // Calculate from grid usage
        );
      }).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

// ============================================================================
// CALCULATED PROVIDERS
// ============================================================================

/// Total Energy Consumed Provider
final totalEnergyConsumedProvider = Provider<double>((ref) {
  final analyticsAsync = ref.watch(analyticsDataProvider);

  return analyticsAsync.when(
    data: (analytics) => analytics.totalEnergyConsumed,
    loading: () => 0.0,
    error: (_, __) => 0.0,
  );
});

/// Cost Saved Provider (example calculation)
final costSavedProvider = Provider<double>((ref) {
  final totalEnergy = ref.watch(totalEnergyConsumedProvider);
  const costPerKWh = 0.15; // Adjust based on your electricity rate (PHP/kWh)
  return totalEnergy * costPerKWh;
});

/// Carbon Emission Saved Provider (example calculation)
final carbonSavedProvider = Provider<double>((ref) {
  final totalEnergy = ref.watch(totalEnergyConsumedProvider);
  const kgCO2PerKWh = 0.5; // Adjust based on your region
  return totalEnergy * kgCO2PerKWh;
});

// ============================================================================
// HELPER CLASSES
// ============================================================================

class DateRange {
  final DateTime start;
  final DateTime end;

  DateRange({required this.start, required this.end});
}
