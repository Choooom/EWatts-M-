// lib/services/analytics_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/constants/consts.dart';
import 'package:my_app/models/analytics/analytics_models.dart';

class AnalyticsApiService {
  static const String baseUrl = base_url;
  static const Duration timeout = Duration(seconds: 30);

  String? _accessToken;

  // Singleton pattern
  static final AnalyticsApiService _instance = AnalyticsApiService._internal();
  factory AnalyticsApiService() => _instance;
  AnalyticsApiService._internal();

  void setAccessToken(String? token) {
    _accessToken = token;
  }

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (_accessToken != null) 'Authorization': 'Bearer $_accessToken',
  };

  /// Get Analytics Data
  Future<AnalyticsResponse> getAnalytics({
    required AggregationType type,
    required DateTime startDate,
    required DateTime endDate,
    int? deviceId,
  }) async {
    final typeString = _aggregationTypeToString(type);

    final queryParams = {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      if (deviceId != null) 'deviceId': deviceId.toString(),
    };

    final uri = Uri.parse(
      '$baseUrl/api/iot/analytics/$typeString',
    ).replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri, headers: _headers).timeout(timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

        if (jsonResponse['success'] == true) {
          return AnalyticsResponse.fromJson(
            jsonResponse['data'] as Map<String, dynamic>,
          );
        } else {
          throw Exception(
            jsonResponse['message'] ?? 'Failed to load analytics',
          );
        }
      } else {
        throw Exception('Failed to load analytics: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching analytics: $e');
    }
  }

  /// Get User's Devices
  Future<List<DeviceResponse>> getMyDevices() async {
    final uri = Uri.parse('$baseUrl/api/devices/my-devices');

    try {
      final response = await http.get(uri, headers: _headers).timeout(timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

        if (jsonResponse['success'] == true) {
          final List<dynamic> devicesJson =
              jsonResponse['data'] as List<dynamic>;
          return devicesJson
              .map(
                (json) => DeviceResponse.fromJson(json as Map<String, dynamic>),
              )
              .toList();
        } else {
          throw Exception(jsonResponse['message'] ?? 'Failed to load devices');
        }
      } else {
        throw Exception('Failed to load devices: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching devices: $e');
    }
  }

  String _aggregationTypeToString(AggregationType type) {
    switch (type) {
      case AggregationType.hourly:
        return 'hourly';
      case AggregationType.daily:
        return 'daily';
      case AggregationType.monthly:
        return 'monthly';
      case AggregationType.yearly:
        return 'yearly';
    }
  }
}
