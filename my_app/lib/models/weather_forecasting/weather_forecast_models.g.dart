// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherConditionImpl _$$WeatherConditionImplFromJson(
  Map<String, dynamic> json,
) => _$WeatherConditionImpl(
  cloudDescription: json['cloud_description'] as String,
  windDescription: json['wind_description'] as String,
  precipitation: json['precipitation'] as String,
  temperature: (json['temperature'] as num).toDouble(),
  humidity: (json['humidity'] as num).toDouble(),
  windSpeed: (json['wind_speed'] as num).toDouble(),
  precipitationProbability: (json['precipitation_probability'] as num)
      .toDouble(),
);

Map<String, dynamic> _$$WeatherConditionImplToJson(
  _$WeatherConditionImpl instance,
) => <String, dynamic>{
  'cloud_description': instance.cloudDescription,
  'wind_description': instance.windDescription,
  'precipitation': instance.precipitation,
  'temperature': instance.temperature,
  'humidity': instance.humidity,
  'wind_speed': instance.windSpeed,
  'precipitation_probability': instance.precipitationProbability,
};

_$SolarConditionsImpl _$$SolarConditionsImplFromJson(
  Map<String, dynamic> json,
) => _$SolarConditionsImpl(
  solarIrradiance: (json['solar_irradiance'] as num).toDouble(),
  cellTemperature: (json['cell_temperature'] as num).toDouble(),
  airMass: (json['air_mass'] as num).toDouble(),
  windSpeed: (json['wind_speed'] as num).toDouble(),
  cloudCoverage: (json['cloud_coverage'] as num).toDouble(),
  estimatedEfficiencyFactor: (json['estimated_efficiency_factor'] as num)
      .toDouble(),
);

Map<String, dynamic> _$$SolarConditionsImplToJson(
  _$SolarConditionsImpl instance,
) => <String, dynamic>{
  'solar_irradiance': instance.solarIrradiance,
  'cell_temperature': instance.cellTemperature,
  'air_mass': instance.airMass,
  'wind_speed': instance.windSpeed,
  'cloud_coverage': instance.cloudCoverage,
  'estimated_efficiency_factor': instance.estimatedEfficiencyFactor,
};

_$WeatherPredictionImpl _$$WeatherPredictionImplFromJson(
  Map<String, dynamic> json,
) => _$WeatherPredictionImpl(
  location: (json['location'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
  forecastDate: json['forecast_date'] as String,
  weatherCondition: WeatherCondition.fromJson(
    json['weather_condition'] as Map<String, dynamic>,
  ),
  solarConditions: SolarConditions.fromJson(
    json['solar_conditions'] as Map<String, dynamic>,
  ),
  confidenceScore: (json['confidence_score'] as num).toDouble(),
);

Map<String, dynamic> _$$WeatherPredictionImplToJson(
  _$WeatherPredictionImpl instance,
) => <String, dynamic>{
  'location': instance.location,
  'forecast_date': instance.forecastDate,
  'weather_condition': instance.weatherCondition,
  'solar_conditions': instance.solarConditions,
  'confidence_score': instance.confidenceScore,
};

_$WeatherResponseImpl _$$WeatherResponseImplFromJson(
  Map<String, dynamic> json,
) => _$WeatherResponseImpl(
  predictions: (json['predictions'] as List<dynamic>)
      .map((e) => WeatherPrediction.fromJson(e as Map<String, dynamic>))
      .toList(),
  modelUsed: json['model_used'] as String,
  generatedAt: json['generated_at'] as String,
);

Map<String, dynamic> _$$WeatherResponseImplToJson(
  _$WeatherResponseImpl instance,
) => <String, dynamic>{
  'predictions': instance.predictions,
  'model_used': instance.modelUsed,
  'generated_at': instance.generatedAt,
};

_$LocationRequestImpl _$$LocationRequestImplFromJson(
  Map<String, dynamic> json,
) => _$LocationRequestImpl(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$$LocationRequestImplToJson(
  _$LocationRequestImpl instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
