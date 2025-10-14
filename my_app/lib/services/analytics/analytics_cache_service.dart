// lib/services/analytics_cache_service.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/models/analytics/analytics_models.dart';

class AnalyticsCacheService {
  static const String _cacheKeyPrefix = 'analytics_cache_';
  static const Duration _cacheValidityDuration = Duration(hours: 1);

  // Singleton pattern
  static final AnalyticsCacheService _instance =
      AnalyticsCacheService._internal();
  factory AnalyticsCacheService() => _instance;
  AnalyticsCacheService._internal();

  /// Save analytics data to cache
  Future<void> cacheAnalyticsData(
    AggregationType type,
    AnalyticsResponse data,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = _getCacheKey(type);

    final cachedData = CachedAnalyticsData(
      type: type,
      cachedAt: DateTime.now(),
      data: data,
    );

    await prefs.setString(cacheKey, jsonEncode(cachedData.toJson()));
  }

  /// Get cached analytics data
  Future<AnalyticsResponse?> getCachedAnalyticsData(
    AggregationType type, {
    bool ignoreExpiry = false,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = _getCacheKey(type);
    final cachedString = prefs.getString(cacheKey);

    if (cachedString == null) {
      return null;
    }

    try {
      final cachedData = CachedAnalyticsData.fromJson(
        jsonDecode(cachedString) as Map<String, dynamic>,
      );

      // Check if cache is still valid
      if (!ignoreExpiry) {
        final now = DateTime.now();
        final cacheAge = now.difference(cachedData.cachedAt);

        if (cacheAge > _cacheValidityDuration) {
          // Cache expired, remove it
          await clearCache(type);
          return null;
        }
      }

      return cachedData.data;
    } catch (e) {
      // If there's an error parsing, clear the cache
      await clearCache(type);
      return null;
    }
  }

  /// Check if cache exists and is valid
  Future<bool> hasFreshCache(AggregationType type) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = _getCacheKey(type);
    final cachedString = prefs.getString(cacheKey);

    if (cachedString == null) {
      return false;
    }

    try {
      final cachedData = CachedAnalyticsData.fromJson(
        jsonDecode(cachedString) as Map<String, dynamic>,
      );

      final now = DateTime.now();
      final cacheAge = now.difference(cachedData.cachedAt);

      return cacheAge <= _cacheValidityDuration;
    } catch (e) {
      return false;
    }
  }

  /// Clear cache for specific type
  Future<void> clearCache(AggregationType type) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = _getCacheKey(type);
    await prefs.remove(cacheKey);
  }

  /// Clear all analytics cache
  Future<void> clearAllCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    for (final key in keys) {
      if (key.startsWith(_cacheKeyPrefix)) {
        await prefs.remove(key);
      }
    }
  }

  String _getCacheKey(AggregationType type) {
    return '$_cacheKeyPrefix${type.name}';
  }
}
