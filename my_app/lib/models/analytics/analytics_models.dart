// lib/models/analytics/analytics_models.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_models.freezed.dart';
part 'analytics_models.g.dart';

// ============================================================================
// ENUMS
// ============================================================================

enum AggregationType {
  @JsonValue('HOURLY')
  hourly,
  @JsonValue('DAILY')
  daily,
  @JsonValue('MONTHLY')
  monthly,
  @JsonValue('YEARLY')
  yearly,
}

enum DeviceType {
  @JsonValue('HOUSE_METER')
  houseMeter,
  @JsonValue('APPLIANCE')
  appliance,
  @JsonValue('SOLAR_PANEL')
  solarPanel,
}

// ============================================================================
// AGGREGATED READING RESPONSE
// ============================================================================

@freezed
abstract class AggregatedReadingResponse with _$AggregatedReadingResponse {
  const factory AggregatedReadingResponse({
    required int id,
    required int deviceId,
    required String deviceName,
    required AggregationType aggregationType,
    required DateTime periodStart,
    required DateTime periodEnd,
    required double avgVoltage,
    required double maxVoltage,
    required double minVoltage,
    required double avgCurrent,
    required double maxCurrent,
    required double minCurrent,
    required double avgPower,
    required double maxPower,
    required double minPower,
    required double totalEnergyConsumed,
    required int readingCount,
  }) = _AggregatedReadingResponse;

  factory AggregatedReadingResponse.fromJson(Map<String, dynamic> json) =>
      _$AggregatedReadingResponseFromJson(json);
}

// ============================================================================
// ANALYTICS RESPONSE
// ============================================================================

@freezed
abstract class AnalyticsResponse with _$AnalyticsResponse {
  const factory AnalyticsResponse({
    required List<AggregatedReadingResponse> data,
    required double totalEnergyConsumed,
    required double avgPower,
    required int totalReadings,
  }) = _AnalyticsResponse;

  factory AnalyticsResponse.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsResponseFromJson(json);
}

// ============================================================================
// API RESPONSE WRAPPER
// ============================================================================

@freezed
abstract class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required bool success,
    required String message,
    T? data,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?)? fromJsonT,
  ) {
    return ApiResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: fromJsonT != null ? fromJsonT(json['data']) : null,
    );
  }
}

// ============================================================================
// DEVICE RESPONSE
// ============================================================================

@freezed
abstract class DeviceResponse with _$DeviceResponse {
  const factory DeviceResponse({
    required int id,
    required String deviceName,
    required String esp32Id,
    required String deviceToken,
    required DeviceType deviceType,
    String? description,
    required int userId,
    required String userEmail,
    required bool ssrEnabled,
    required bool active,
    required bool online,
    DateTime? lastSeenAt,
    required double voltageCalibration,
    required double currentCalibration,
    String? location,
    String? installationNotes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DeviceResponse;

  factory DeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceResponseFromJson(json);
}

// ============================================================================
// CACHED ANALYTICS DATA
// ============================================================================

@freezed
abstract class CachedAnalyticsData with _$CachedAnalyticsData {
  const factory CachedAnalyticsData({
    required AggregationType type,
    required DateTime cachedAt,
    required AnalyticsResponse data,
  }) = _CachedAnalyticsData;

  factory CachedAnalyticsData.fromJson(Map<String, dynamic> json) =>
      _$CachedAnalyticsDataFromJson(json);
}
