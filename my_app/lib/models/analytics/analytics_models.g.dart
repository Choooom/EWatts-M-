// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AggregatedReadingResponse _$AggregatedReadingResponseFromJson(
  Map<String, dynamic> json,
) => _AggregatedReadingResponse(
  id: (json['id'] as num).toInt(),
  deviceId: (json['deviceId'] as num).toInt(),
  deviceName: json['deviceName'] as String,
  aggregationType: $enumDecode(
    _$AggregationTypeEnumMap,
    json['aggregationType'],
  ),
  periodStart: DateTime.parse(json['periodStart'] as String),
  periodEnd: DateTime.parse(json['periodEnd'] as String),
  avgVoltage: (json['avgVoltage'] as num).toDouble(),
  maxVoltage: (json['maxVoltage'] as num).toDouble(),
  minVoltage: (json['minVoltage'] as num).toDouble(),
  avgCurrent: (json['avgCurrent'] as num).toDouble(),
  maxCurrent: (json['maxCurrent'] as num).toDouble(),
  minCurrent: (json['minCurrent'] as num).toDouble(),
  avgPower: (json['avgPower'] as num).toDouble(),
  maxPower: (json['maxPower'] as num).toDouble(),
  minPower: (json['minPower'] as num).toDouble(),
  totalEnergyConsumed: (json['totalEnergyConsumed'] as num).toDouble(),
  readingCount: (json['readingCount'] as num).toInt(),
);

Map<String, dynamic> _$AggregatedReadingResponseToJson(
  _AggregatedReadingResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'deviceId': instance.deviceId,
  'deviceName': instance.deviceName,
  'aggregationType': _$AggregationTypeEnumMap[instance.aggregationType]!,
  'periodStart': instance.periodStart.toIso8601String(),
  'periodEnd': instance.periodEnd.toIso8601String(),
  'avgVoltage': instance.avgVoltage,
  'maxVoltage': instance.maxVoltage,
  'minVoltage': instance.minVoltage,
  'avgCurrent': instance.avgCurrent,
  'maxCurrent': instance.maxCurrent,
  'minCurrent': instance.minCurrent,
  'avgPower': instance.avgPower,
  'maxPower': instance.maxPower,
  'minPower': instance.minPower,
  'totalEnergyConsumed': instance.totalEnergyConsumed,
  'readingCount': instance.readingCount,
};

const _$AggregationTypeEnumMap = {
  AggregationType.hourly: 'HOURLY',
  AggregationType.daily: 'DAILY',
  AggregationType.monthly: 'MONTHLY',
  AggregationType.yearly: 'YEARLY',
};

_AnalyticsResponse _$AnalyticsResponseFromJson(Map<String, dynamic> json) =>
    _AnalyticsResponse(
      data: (json['data'] as List<dynamic>)
          .map(
            (e) =>
                AggregatedReadingResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      totalEnergyConsumed: (json['totalEnergyConsumed'] as num).toDouble(),
      avgPower: (json['avgPower'] as num).toDouble(),
      totalReadings: (json['totalReadings'] as num).toInt(),
    );

Map<String, dynamic> _$AnalyticsResponseToJson(_AnalyticsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalEnergyConsumed': instance.totalEnergyConsumed,
      'avgPower': instance.avgPower,
      'totalReadings': instance.totalReadings,
    };

_DeviceResponse _$DeviceResponseFromJson(Map<String, dynamic> json) =>
    _DeviceResponse(
      id: (json['id'] as num).toInt(),
      deviceName: json['deviceName'] as String,
      esp32Id: json['esp32Id'] as String,
      deviceToken: json['deviceToken'] as String,
      deviceType: $enumDecode(_$DeviceTypeEnumMap, json['deviceType']),
      description: json['description'] as String?,
      userId: (json['userId'] as num).toInt(),
      userEmail: json['userEmail'] as String,
      ssrEnabled: json['ssrEnabled'] as bool,
      active: json['active'] as bool,
      online: json['online'] as bool,
      lastSeenAt: json['lastSeenAt'] == null
          ? null
          : DateTime.parse(json['lastSeenAt'] as String),
      voltageCalibration: (json['voltageCalibration'] as num).toDouble(),
      currentCalibration: (json['currentCalibration'] as num).toDouble(),
      location: json['location'] as String?,
      installationNotes: json['installationNotes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DeviceResponseToJson(_DeviceResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceName': instance.deviceName,
      'esp32Id': instance.esp32Id,
      'deviceToken': instance.deviceToken,
      'deviceType': _$DeviceTypeEnumMap[instance.deviceType]!,
      'description': instance.description,
      'userId': instance.userId,
      'userEmail': instance.userEmail,
      'ssrEnabled': instance.ssrEnabled,
      'active': instance.active,
      'online': instance.online,
      'lastSeenAt': instance.lastSeenAt?.toIso8601String(),
      'voltageCalibration': instance.voltageCalibration,
      'currentCalibration': instance.currentCalibration,
      'location': instance.location,
      'installationNotes': instance.installationNotes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$DeviceTypeEnumMap = {
  DeviceType.houseMeter: 'HOUSE_METER',
  DeviceType.appliance: 'APPLIANCE',
  DeviceType.solarPanel: 'SOLAR_PANEL',
};

_CachedAnalyticsData _$CachedAnalyticsDataFromJson(Map<String, dynamic> json) =>
    _CachedAnalyticsData(
      type: $enumDecode(_$AggregationTypeEnumMap, json['type']),
      cachedAt: DateTime.parse(json['cachedAt'] as String),
      data: AnalyticsResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CachedAnalyticsDataToJson(
  _CachedAnalyticsData instance,
) => <String, dynamic>{
  'type': _$AggregationTypeEnumMap[instance.type]!,
  'cachedAt': instance.cachedAt.toIso8601String(),
  'data': instance.data,
};
