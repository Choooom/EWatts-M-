// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_forecast_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WeatherCondition _$WeatherConditionFromJson(Map<String, dynamic> json) {
  return _WeatherCondition.fromJson(json);
}

/// @nodoc
mixin _$WeatherCondition {
  @JsonKey(name: 'cloud_description')
  String get cloudDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'wind_description')
  String get windDescription => throw _privateConstructorUsedError;
  String get precipitation => throw _privateConstructorUsedError;
  double get temperature => throw _privateConstructorUsedError;
  double get humidity => throw _privateConstructorUsedError;
  @JsonKey(name: 'wind_speed')
  double get windSpeed => throw _privateConstructorUsedError;
  @JsonKey(name: 'precipitation_probability')
  double get precipitationProbability => throw _privateConstructorUsedError;

  /// Serializes this WeatherCondition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeatherCondition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeatherConditionCopyWith<WeatherCondition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherConditionCopyWith<$Res> {
  factory $WeatherConditionCopyWith(
    WeatherCondition value,
    $Res Function(WeatherCondition) then,
  ) = _$WeatherConditionCopyWithImpl<$Res, WeatherCondition>;
  @useResult
  $Res call({
    @JsonKey(name: 'cloud_description') String cloudDescription,
    @JsonKey(name: 'wind_description') String windDescription,
    String precipitation,
    double temperature,
    double humidity,
    @JsonKey(name: 'wind_speed') double windSpeed,
    @JsonKey(name: 'precipitation_probability') double precipitationProbability,
  });
}

/// @nodoc
class _$WeatherConditionCopyWithImpl<$Res, $Val extends WeatherCondition>
    implements $WeatherConditionCopyWith<$Res> {
  _$WeatherConditionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeatherCondition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cloudDescription = null,
    Object? windDescription = null,
    Object? precipitation = null,
    Object? temperature = null,
    Object? humidity = null,
    Object? windSpeed = null,
    Object? precipitationProbability = null,
  }) {
    return _then(
      _value.copyWith(
            cloudDescription: null == cloudDescription
                ? _value.cloudDescription
                : cloudDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            windDescription: null == windDescription
                ? _value.windDescription
                : windDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            precipitation: null == precipitation
                ? _value.precipitation
                : precipitation // ignore: cast_nullable_to_non_nullable
                      as String,
            temperature: null == temperature
                ? _value.temperature
                : temperature // ignore: cast_nullable_to_non_nullable
                      as double,
            humidity: null == humidity
                ? _value.humidity
                : humidity // ignore: cast_nullable_to_non_nullable
                      as double,
            windSpeed: null == windSpeed
                ? _value.windSpeed
                : windSpeed // ignore: cast_nullable_to_non_nullable
                      as double,
            precipitationProbability: null == precipitationProbability
                ? _value.precipitationProbability
                : precipitationProbability // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WeatherConditionImplCopyWith<$Res>
    implements $WeatherConditionCopyWith<$Res> {
  factory _$$WeatherConditionImplCopyWith(
    _$WeatherConditionImpl value,
    $Res Function(_$WeatherConditionImpl) then,
  ) = __$$WeatherConditionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'cloud_description') String cloudDescription,
    @JsonKey(name: 'wind_description') String windDescription,
    String precipitation,
    double temperature,
    double humidity,
    @JsonKey(name: 'wind_speed') double windSpeed,
    @JsonKey(name: 'precipitation_probability') double precipitationProbability,
  });
}

/// @nodoc
class __$$WeatherConditionImplCopyWithImpl<$Res>
    extends _$WeatherConditionCopyWithImpl<$Res, _$WeatherConditionImpl>
    implements _$$WeatherConditionImplCopyWith<$Res> {
  __$$WeatherConditionImplCopyWithImpl(
    _$WeatherConditionImpl _value,
    $Res Function(_$WeatherConditionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeatherCondition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cloudDescription = null,
    Object? windDescription = null,
    Object? precipitation = null,
    Object? temperature = null,
    Object? humidity = null,
    Object? windSpeed = null,
    Object? precipitationProbability = null,
  }) {
    return _then(
      _$WeatherConditionImpl(
        cloudDescription: null == cloudDescription
            ? _value.cloudDescription
            : cloudDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        windDescription: null == windDescription
            ? _value.windDescription
            : windDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        precipitation: null == precipitation
            ? _value.precipitation
            : precipitation // ignore: cast_nullable_to_non_nullable
                  as String,
        temperature: null == temperature
            ? _value.temperature
            : temperature // ignore: cast_nullable_to_non_nullable
                  as double,
        humidity: null == humidity
            ? _value.humidity
            : humidity // ignore: cast_nullable_to_non_nullable
                  as double,
        windSpeed: null == windSpeed
            ? _value.windSpeed
            : windSpeed // ignore: cast_nullable_to_non_nullable
                  as double,
        precipitationProbability: null == precipitationProbability
            ? _value.precipitationProbability
            : precipitationProbability // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherConditionImpl implements _WeatherCondition {
  const _$WeatherConditionImpl({
    @JsonKey(name: 'cloud_description') required this.cloudDescription,
    @JsonKey(name: 'wind_description') required this.windDescription,
    required this.precipitation,
    required this.temperature,
    required this.humidity,
    @JsonKey(name: 'wind_speed') required this.windSpeed,
    @JsonKey(name: 'precipitation_probability')
    required this.precipitationProbability,
  });

  factory _$WeatherConditionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherConditionImplFromJson(json);

  @override
  @JsonKey(name: 'cloud_description')
  final String cloudDescription;
  @override
  @JsonKey(name: 'wind_description')
  final String windDescription;
  @override
  final String precipitation;
  @override
  final double temperature;
  @override
  final double humidity;
  @override
  @JsonKey(name: 'wind_speed')
  final double windSpeed;
  @override
  @JsonKey(name: 'precipitation_probability')
  final double precipitationProbability;

  @override
  String toString() {
    return 'WeatherCondition(cloudDescription: $cloudDescription, windDescription: $windDescription, precipitation: $precipitation, temperature: $temperature, humidity: $humidity, windSpeed: $windSpeed, precipitationProbability: $precipitationProbability)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherConditionImpl &&
            (identical(other.cloudDescription, cloudDescription) ||
                other.cloudDescription == cloudDescription) &&
            (identical(other.windDescription, windDescription) ||
                other.windDescription == windDescription) &&
            (identical(other.precipitation, precipitation) ||
                other.precipitation == precipitation) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.windSpeed, windSpeed) ||
                other.windSpeed == windSpeed) &&
            (identical(
                  other.precipitationProbability,
                  precipitationProbability,
                ) ||
                other.precipitationProbability == precipitationProbability));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    cloudDescription,
    windDescription,
    precipitation,
    temperature,
    humidity,
    windSpeed,
    precipitationProbability,
  );

  /// Create a copy of WeatherCondition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherConditionImplCopyWith<_$WeatherConditionImpl> get copyWith =>
      __$$WeatherConditionImplCopyWithImpl<_$WeatherConditionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherConditionImplToJson(this);
  }
}

abstract class _WeatherCondition implements WeatherCondition {
  const factory _WeatherCondition({
    @JsonKey(name: 'cloud_description') required final String cloudDescription,
    @JsonKey(name: 'wind_description') required final String windDescription,
    required final String precipitation,
    required final double temperature,
    required final double humidity,
    @JsonKey(name: 'wind_speed') required final double windSpeed,
    @JsonKey(name: 'precipitation_probability')
    required final double precipitationProbability,
  }) = _$WeatherConditionImpl;

  factory _WeatherCondition.fromJson(Map<String, dynamic> json) =
      _$WeatherConditionImpl.fromJson;

  @override
  @JsonKey(name: 'cloud_description')
  String get cloudDescription;
  @override
  @JsonKey(name: 'wind_description')
  String get windDescription;
  @override
  String get precipitation;
  @override
  double get temperature;
  @override
  double get humidity;
  @override
  @JsonKey(name: 'wind_speed')
  double get windSpeed;
  @override
  @JsonKey(name: 'precipitation_probability')
  double get precipitationProbability;

  /// Create a copy of WeatherCondition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeatherConditionImplCopyWith<_$WeatherConditionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SolarConditions _$SolarConditionsFromJson(Map<String, dynamic> json) {
  return _SolarConditions.fromJson(json);
}

/// @nodoc
mixin _$SolarConditions {
  @JsonKey(name: 'solar_irradiance')
  double get solarIrradiance => throw _privateConstructorUsedError;
  @JsonKey(name: 'cell_temperature')
  double get cellTemperature => throw _privateConstructorUsedError;
  @JsonKey(name: 'air_mass')
  double get airMass => throw _privateConstructorUsedError;
  @JsonKey(name: 'wind_speed')
  double get windSpeed => throw _privateConstructorUsedError;
  @JsonKey(name: 'cloud_coverage')
  double get cloudCoverage => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_efficiency_factor')
  double get estimatedEfficiencyFactor => throw _privateConstructorUsedError;

  /// Serializes this SolarConditions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SolarConditions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SolarConditionsCopyWith<SolarConditions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolarConditionsCopyWith<$Res> {
  factory $SolarConditionsCopyWith(
    SolarConditions value,
    $Res Function(SolarConditions) then,
  ) = _$SolarConditionsCopyWithImpl<$Res, SolarConditions>;
  @useResult
  $Res call({
    @JsonKey(name: 'solar_irradiance') double solarIrradiance,
    @JsonKey(name: 'cell_temperature') double cellTemperature,
    @JsonKey(name: 'air_mass') double airMass,
    @JsonKey(name: 'wind_speed') double windSpeed,
    @JsonKey(name: 'cloud_coverage') double cloudCoverage,
    @JsonKey(name: 'estimated_efficiency_factor')
    double estimatedEfficiencyFactor,
  });
}

/// @nodoc
class _$SolarConditionsCopyWithImpl<$Res, $Val extends SolarConditions>
    implements $SolarConditionsCopyWith<$Res> {
  _$SolarConditionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SolarConditions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? solarIrradiance = null,
    Object? cellTemperature = null,
    Object? airMass = null,
    Object? windSpeed = null,
    Object? cloudCoverage = null,
    Object? estimatedEfficiencyFactor = null,
  }) {
    return _then(
      _value.copyWith(
            solarIrradiance: null == solarIrradiance
                ? _value.solarIrradiance
                : solarIrradiance // ignore: cast_nullable_to_non_nullable
                      as double,
            cellTemperature: null == cellTemperature
                ? _value.cellTemperature
                : cellTemperature // ignore: cast_nullable_to_non_nullable
                      as double,
            airMass: null == airMass
                ? _value.airMass
                : airMass // ignore: cast_nullable_to_non_nullable
                      as double,
            windSpeed: null == windSpeed
                ? _value.windSpeed
                : windSpeed // ignore: cast_nullable_to_non_nullable
                      as double,
            cloudCoverage: null == cloudCoverage
                ? _value.cloudCoverage
                : cloudCoverage // ignore: cast_nullable_to_non_nullable
                      as double,
            estimatedEfficiencyFactor: null == estimatedEfficiencyFactor
                ? _value.estimatedEfficiencyFactor
                : estimatedEfficiencyFactor // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SolarConditionsImplCopyWith<$Res>
    implements $SolarConditionsCopyWith<$Res> {
  factory _$$SolarConditionsImplCopyWith(
    _$SolarConditionsImpl value,
    $Res Function(_$SolarConditionsImpl) then,
  ) = __$$SolarConditionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'solar_irradiance') double solarIrradiance,
    @JsonKey(name: 'cell_temperature') double cellTemperature,
    @JsonKey(name: 'air_mass') double airMass,
    @JsonKey(name: 'wind_speed') double windSpeed,
    @JsonKey(name: 'cloud_coverage') double cloudCoverage,
    @JsonKey(name: 'estimated_efficiency_factor')
    double estimatedEfficiencyFactor,
  });
}

/// @nodoc
class __$$SolarConditionsImplCopyWithImpl<$Res>
    extends _$SolarConditionsCopyWithImpl<$Res, _$SolarConditionsImpl>
    implements _$$SolarConditionsImplCopyWith<$Res> {
  __$$SolarConditionsImplCopyWithImpl(
    _$SolarConditionsImpl _value,
    $Res Function(_$SolarConditionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SolarConditions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? solarIrradiance = null,
    Object? cellTemperature = null,
    Object? airMass = null,
    Object? windSpeed = null,
    Object? cloudCoverage = null,
    Object? estimatedEfficiencyFactor = null,
  }) {
    return _then(
      _$SolarConditionsImpl(
        solarIrradiance: null == solarIrradiance
            ? _value.solarIrradiance
            : solarIrradiance // ignore: cast_nullable_to_non_nullable
                  as double,
        cellTemperature: null == cellTemperature
            ? _value.cellTemperature
            : cellTemperature // ignore: cast_nullable_to_non_nullable
                  as double,
        airMass: null == airMass
            ? _value.airMass
            : airMass // ignore: cast_nullable_to_non_nullable
                  as double,
        windSpeed: null == windSpeed
            ? _value.windSpeed
            : windSpeed // ignore: cast_nullable_to_non_nullable
                  as double,
        cloudCoverage: null == cloudCoverage
            ? _value.cloudCoverage
            : cloudCoverage // ignore: cast_nullable_to_non_nullable
                  as double,
        estimatedEfficiencyFactor: null == estimatedEfficiencyFactor
            ? _value.estimatedEfficiencyFactor
            : estimatedEfficiencyFactor // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SolarConditionsImpl implements _SolarConditions {
  const _$SolarConditionsImpl({
    @JsonKey(name: 'solar_irradiance') required this.solarIrradiance,
    @JsonKey(name: 'cell_temperature') required this.cellTemperature,
    @JsonKey(name: 'air_mass') required this.airMass,
    @JsonKey(name: 'wind_speed') required this.windSpeed,
    @JsonKey(name: 'cloud_coverage') required this.cloudCoverage,
    @JsonKey(name: 'estimated_efficiency_factor')
    required this.estimatedEfficiencyFactor,
  });

  factory _$SolarConditionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolarConditionsImplFromJson(json);

  @override
  @JsonKey(name: 'solar_irradiance')
  final double solarIrradiance;
  @override
  @JsonKey(name: 'cell_temperature')
  final double cellTemperature;
  @override
  @JsonKey(name: 'air_mass')
  final double airMass;
  @override
  @JsonKey(name: 'wind_speed')
  final double windSpeed;
  @override
  @JsonKey(name: 'cloud_coverage')
  final double cloudCoverage;
  @override
  @JsonKey(name: 'estimated_efficiency_factor')
  final double estimatedEfficiencyFactor;

  @override
  String toString() {
    return 'SolarConditions(solarIrradiance: $solarIrradiance, cellTemperature: $cellTemperature, airMass: $airMass, windSpeed: $windSpeed, cloudCoverage: $cloudCoverage, estimatedEfficiencyFactor: $estimatedEfficiencyFactor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolarConditionsImpl &&
            (identical(other.solarIrradiance, solarIrradiance) ||
                other.solarIrradiance == solarIrradiance) &&
            (identical(other.cellTemperature, cellTemperature) ||
                other.cellTemperature == cellTemperature) &&
            (identical(other.airMass, airMass) || other.airMass == airMass) &&
            (identical(other.windSpeed, windSpeed) ||
                other.windSpeed == windSpeed) &&
            (identical(other.cloudCoverage, cloudCoverage) ||
                other.cloudCoverage == cloudCoverage) &&
            (identical(
                  other.estimatedEfficiencyFactor,
                  estimatedEfficiencyFactor,
                ) ||
                other.estimatedEfficiencyFactor == estimatedEfficiencyFactor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    solarIrradiance,
    cellTemperature,
    airMass,
    windSpeed,
    cloudCoverage,
    estimatedEfficiencyFactor,
  );

  /// Create a copy of SolarConditions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SolarConditionsImplCopyWith<_$SolarConditionsImpl> get copyWith =>
      __$$SolarConditionsImplCopyWithImpl<_$SolarConditionsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SolarConditionsImplToJson(this);
  }
}

abstract class _SolarConditions implements SolarConditions {
  const factory _SolarConditions({
    @JsonKey(name: 'solar_irradiance') required final double solarIrradiance,
    @JsonKey(name: 'cell_temperature') required final double cellTemperature,
    @JsonKey(name: 'air_mass') required final double airMass,
    @JsonKey(name: 'wind_speed') required final double windSpeed,
    @JsonKey(name: 'cloud_coverage') required final double cloudCoverage,
    @JsonKey(name: 'estimated_efficiency_factor')
    required final double estimatedEfficiencyFactor,
  }) = _$SolarConditionsImpl;

  factory _SolarConditions.fromJson(Map<String, dynamic> json) =
      _$SolarConditionsImpl.fromJson;

  @override
  @JsonKey(name: 'solar_irradiance')
  double get solarIrradiance;
  @override
  @JsonKey(name: 'cell_temperature')
  double get cellTemperature;
  @override
  @JsonKey(name: 'air_mass')
  double get airMass;
  @override
  @JsonKey(name: 'wind_speed')
  double get windSpeed;
  @override
  @JsonKey(name: 'cloud_coverage')
  double get cloudCoverage;
  @override
  @JsonKey(name: 'estimated_efficiency_factor')
  double get estimatedEfficiencyFactor;

  /// Create a copy of SolarConditions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SolarConditionsImplCopyWith<_$SolarConditionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WeatherPrediction _$WeatherPredictionFromJson(Map<String, dynamic> json) {
  return _WeatherPrediction.fromJson(json);
}

/// @nodoc
mixin _$WeatherPrediction {
  Map<String, double> get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'forecast_date')
  String get forecastDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'weather_condition')
  WeatherCondition get weatherCondition => throw _privateConstructorUsedError;
  @JsonKey(name: 'solar_conditions')
  SolarConditions get solarConditions => throw _privateConstructorUsedError;
  @JsonKey(name: 'confidence_score')
  double get confidenceScore => throw _privateConstructorUsedError;

  /// Serializes this WeatherPrediction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeatherPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeatherPredictionCopyWith<WeatherPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherPredictionCopyWith<$Res> {
  factory $WeatherPredictionCopyWith(
    WeatherPrediction value,
    $Res Function(WeatherPrediction) then,
  ) = _$WeatherPredictionCopyWithImpl<$Res, WeatherPrediction>;
  @useResult
  $Res call({
    Map<String, double> location,
    @JsonKey(name: 'forecast_date') String forecastDate,
    @JsonKey(name: 'weather_condition') WeatherCondition weatherCondition,
    @JsonKey(name: 'solar_conditions') SolarConditions solarConditions,
    @JsonKey(name: 'confidence_score') double confidenceScore,
  });

  $WeatherConditionCopyWith<$Res> get weatherCondition;
  $SolarConditionsCopyWith<$Res> get solarConditions;
}

/// @nodoc
class _$WeatherPredictionCopyWithImpl<$Res, $Val extends WeatherPrediction>
    implements $WeatherPredictionCopyWith<$Res> {
  _$WeatherPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeatherPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? forecastDate = null,
    Object? weatherCondition = null,
    Object? solarConditions = null,
    Object? confidenceScore = null,
  }) {
    return _then(
      _value.copyWith(
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>,
            forecastDate: null == forecastDate
                ? _value.forecastDate
                : forecastDate // ignore: cast_nullable_to_non_nullable
                      as String,
            weatherCondition: null == weatherCondition
                ? _value.weatherCondition
                : weatherCondition // ignore: cast_nullable_to_non_nullable
                      as WeatherCondition,
            solarConditions: null == solarConditions
                ? _value.solarConditions
                : solarConditions // ignore: cast_nullable_to_non_nullable
                      as SolarConditions,
            confidenceScore: null == confidenceScore
                ? _value.confidenceScore
                : confidenceScore // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }

  /// Create a copy of WeatherPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WeatherConditionCopyWith<$Res> get weatherCondition {
    return $WeatherConditionCopyWith<$Res>(_value.weatherCondition, (value) {
      return _then(_value.copyWith(weatherCondition: value) as $Val);
    });
  }

  /// Create a copy of WeatherPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SolarConditionsCopyWith<$Res> get solarConditions {
    return $SolarConditionsCopyWith<$Res>(_value.solarConditions, (value) {
      return _then(_value.copyWith(solarConditions: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WeatherPredictionImplCopyWith<$Res>
    implements $WeatherPredictionCopyWith<$Res> {
  factory _$$WeatherPredictionImplCopyWith(
    _$WeatherPredictionImpl value,
    $Res Function(_$WeatherPredictionImpl) then,
  ) = __$$WeatherPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Map<String, double> location,
    @JsonKey(name: 'forecast_date') String forecastDate,
    @JsonKey(name: 'weather_condition') WeatherCondition weatherCondition,
    @JsonKey(name: 'solar_conditions') SolarConditions solarConditions,
    @JsonKey(name: 'confidence_score') double confidenceScore,
  });

  @override
  $WeatherConditionCopyWith<$Res> get weatherCondition;
  @override
  $SolarConditionsCopyWith<$Res> get solarConditions;
}

/// @nodoc
class __$$WeatherPredictionImplCopyWithImpl<$Res>
    extends _$WeatherPredictionCopyWithImpl<$Res, _$WeatherPredictionImpl>
    implements _$$WeatherPredictionImplCopyWith<$Res> {
  __$$WeatherPredictionImplCopyWithImpl(
    _$WeatherPredictionImpl _value,
    $Res Function(_$WeatherPredictionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeatherPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? forecastDate = null,
    Object? weatherCondition = null,
    Object? solarConditions = null,
    Object? confidenceScore = null,
  }) {
    return _then(
      _$WeatherPredictionImpl(
        location: null == location
            ? _value._location
            : location // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        forecastDate: null == forecastDate
            ? _value.forecastDate
            : forecastDate // ignore: cast_nullable_to_non_nullable
                  as String,
        weatherCondition: null == weatherCondition
            ? _value.weatherCondition
            : weatherCondition // ignore: cast_nullable_to_non_nullable
                  as WeatherCondition,
        solarConditions: null == solarConditions
            ? _value.solarConditions
            : solarConditions // ignore: cast_nullable_to_non_nullable
                  as SolarConditions,
        confidenceScore: null == confidenceScore
            ? _value.confidenceScore
            : confidenceScore // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherPredictionImpl implements _WeatherPrediction {
  const _$WeatherPredictionImpl({
    required final Map<String, double> location,
    @JsonKey(name: 'forecast_date') required this.forecastDate,
    @JsonKey(name: 'weather_condition') required this.weatherCondition,
    @JsonKey(name: 'solar_conditions') required this.solarConditions,
    @JsonKey(name: 'confidence_score') required this.confidenceScore,
  }) : _location = location;

  factory _$WeatherPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherPredictionImplFromJson(json);

  final Map<String, double> _location;
  @override
  Map<String, double> get location {
    if (_location is EqualUnmodifiableMapView) return _location;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_location);
  }

  @override
  @JsonKey(name: 'forecast_date')
  final String forecastDate;
  @override
  @JsonKey(name: 'weather_condition')
  final WeatherCondition weatherCondition;
  @override
  @JsonKey(name: 'solar_conditions')
  final SolarConditions solarConditions;
  @override
  @JsonKey(name: 'confidence_score')
  final double confidenceScore;

  @override
  String toString() {
    return 'WeatherPrediction(location: $location, forecastDate: $forecastDate, weatherCondition: $weatherCondition, solarConditions: $solarConditions, confidenceScore: $confidenceScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherPredictionImpl &&
            const DeepCollectionEquality().equals(other._location, _location) &&
            (identical(other.forecastDate, forecastDate) ||
                other.forecastDate == forecastDate) &&
            (identical(other.weatherCondition, weatherCondition) ||
                other.weatherCondition == weatherCondition) &&
            (identical(other.solarConditions, solarConditions) ||
                other.solarConditions == solarConditions) &&
            (identical(other.confidenceScore, confidenceScore) ||
                other.confidenceScore == confidenceScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_location),
    forecastDate,
    weatherCondition,
    solarConditions,
    confidenceScore,
  );

  /// Create a copy of WeatherPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherPredictionImplCopyWith<_$WeatherPredictionImpl> get copyWith =>
      __$$WeatherPredictionImplCopyWithImpl<_$WeatherPredictionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherPredictionImplToJson(this);
  }
}

abstract class _WeatherPrediction implements WeatherPrediction {
  const factory _WeatherPrediction({
    required final Map<String, double> location,
    @JsonKey(name: 'forecast_date') required final String forecastDate,
    @JsonKey(name: 'weather_condition')
    required final WeatherCondition weatherCondition,
    @JsonKey(name: 'solar_conditions')
    required final SolarConditions solarConditions,
    @JsonKey(name: 'confidence_score') required final double confidenceScore,
  }) = _$WeatherPredictionImpl;

  factory _WeatherPrediction.fromJson(Map<String, dynamic> json) =
      _$WeatherPredictionImpl.fromJson;

  @override
  Map<String, double> get location;
  @override
  @JsonKey(name: 'forecast_date')
  String get forecastDate;
  @override
  @JsonKey(name: 'weather_condition')
  WeatherCondition get weatherCondition;
  @override
  @JsonKey(name: 'solar_conditions')
  SolarConditions get solarConditions;
  @override
  @JsonKey(name: 'confidence_score')
  double get confidenceScore;

  /// Create a copy of WeatherPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeatherPredictionImplCopyWith<_$WeatherPredictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) {
  return _WeatherResponse.fromJson(json);
}

/// @nodoc
mixin _$WeatherResponse {
  List<WeatherPrediction> get predictions => throw _privateConstructorUsedError;
  @JsonKey(name: 'model_used')
  String get modelUsed => throw _privateConstructorUsedError;
  @JsonKey(name: 'generated_at')
  String get generatedAt => throw _privateConstructorUsedError;

  /// Serializes this WeatherResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeatherResponseCopyWith<WeatherResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherResponseCopyWith<$Res> {
  factory $WeatherResponseCopyWith(
    WeatherResponse value,
    $Res Function(WeatherResponse) then,
  ) = _$WeatherResponseCopyWithImpl<$Res, WeatherResponse>;
  @useResult
  $Res call({
    List<WeatherPrediction> predictions,
    @JsonKey(name: 'model_used') String modelUsed,
    @JsonKey(name: 'generated_at') String generatedAt,
  });
}

/// @nodoc
class _$WeatherResponseCopyWithImpl<$Res, $Val extends WeatherResponse>
    implements $WeatherResponseCopyWith<$Res> {
  _$WeatherResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictions = null,
    Object? modelUsed = null,
    Object? generatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            predictions: null == predictions
                ? _value.predictions
                : predictions // ignore: cast_nullable_to_non_nullable
                      as List<WeatherPrediction>,
            modelUsed: null == modelUsed
                ? _value.modelUsed
                : modelUsed // ignore: cast_nullable_to_non_nullable
                      as String,
            generatedAt: null == generatedAt
                ? _value.generatedAt
                : generatedAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WeatherResponseImplCopyWith<$Res>
    implements $WeatherResponseCopyWith<$Res> {
  factory _$$WeatherResponseImplCopyWith(
    _$WeatherResponseImpl value,
    $Res Function(_$WeatherResponseImpl) then,
  ) = __$$WeatherResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<WeatherPrediction> predictions,
    @JsonKey(name: 'model_used') String modelUsed,
    @JsonKey(name: 'generated_at') String generatedAt,
  });
}

/// @nodoc
class __$$WeatherResponseImplCopyWithImpl<$Res>
    extends _$WeatherResponseCopyWithImpl<$Res, _$WeatherResponseImpl>
    implements _$$WeatherResponseImplCopyWith<$Res> {
  __$$WeatherResponseImplCopyWithImpl(
    _$WeatherResponseImpl _value,
    $Res Function(_$WeatherResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictions = null,
    Object? modelUsed = null,
    Object? generatedAt = null,
  }) {
    return _then(
      _$WeatherResponseImpl(
        predictions: null == predictions
            ? _value._predictions
            : predictions // ignore: cast_nullable_to_non_nullable
                  as List<WeatherPrediction>,
        modelUsed: null == modelUsed
            ? _value.modelUsed
            : modelUsed // ignore: cast_nullable_to_non_nullable
                  as String,
        generatedAt: null == generatedAt
            ? _value.generatedAt
            : generatedAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherResponseImpl implements _WeatherResponse {
  const _$WeatherResponseImpl({
    required final List<WeatherPrediction> predictions,
    @JsonKey(name: 'model_used') required this.modelUsed,
    @JsonKey(name: 'generated_at') required this.generatedAt,
  }) : _predictions = predictions;

  factory _$WeatherResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherResponseImplFromJson(json);

  final List<WeatherPrediction> _predictions;
  @override
  List<WeatherPrediction> get predictions {
    if (_predictions is EqualUnmodifiableListView) return _predictions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_predictions);
  }

  @override
  @JsonKey(name: 'model_used')
  final String modelUsed;
  @override
  @JsonKey(name: 'generated_at')
  final String generatedAt;

  @override
  String toString() {
    return 'WeatherResponse(predictions: $predictions, modelUsed: $modelUsed, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherResponseImpl &&
            const DeepCollectionEquality().equals(
              other._predictions,
              _predictions,
            ) &&
            (identical(other.modelUsed, modelUsed) ||
                other.modelUsed == modelUsed) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_predictions),
    modelUsed,
    generatedAt,
  );

  /// Create a copy of WeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherResponseImplCopyWith<_$WeatherResponseImpl> get copyWith =>
      __$$WeatherResponseImplCopyWithImpl<_$WeatherResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherResponseImplToJson(this);
  }
}

abstract class _WeatherResponse implements WeatherResponse {
  const factory _WeatherResponse({
    required final List<WeatherPrediction> predictions,
    @JsonKey(name: 'model_used') required final String modelUsed,
    @JsonKey(name: 'generated_at') required final String generatedAt,
  }) = _$WeatherResponseImpl;

  factory _WeatherResponse.fromJson(Map<String, dynamic> json) =
      _$WeatherResponseImpl.fromJson;

  @override
  List<WeatherPrediction> get predictions;
  @override
  @JsonKey(name: 'model_used')
  String get modelUsed;
  @override
  @JsonKey(name: 'generated_at')
  String get generatedAt;

  /// Create a copy of WeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeatherResponseImplCopyWith<_$WeatherResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationRequest _$LocationRequestFromJson(Map<String, dynamic> json) {
  return _LocationRequest.fromJson(json);
}

/// @nodoc
mixin _$LocationRequest {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  /// Serializes this LocationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationRequestCopyWith<LocationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationRequestCopyWith<$Res> {
  factory $LocationRequestCopyWith(
    LocationRequest value,
    $Res Function(LocationRequest) then,
  ) = _$LocationRequestCopyWithImpl<$Res, LocationRequest>;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$LocationRequestCopyWithImpl<$Res, $Val extends LocationRequest>
    implements $LocationRequestCopyWith<$Res> {
  _$LocationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? latitude = null, Object? longitude = null}) {
    return _then(
      _value.copyWith(
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocationRequestImplCopyWith<$Res>
    implements $LocationRequestCopyWith<$Res> {
  factory _$$LocationRequestImplCopyWith(
    _$LocationRequestImpl value,
    $Res Function(_$LocationRequestImpl) then,
  ) = __$$LocationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$LocationRequestImplCopyWithImpl<$Res>
    extends _$LocationRequestCopyWithImpl<$Res, _$LocationRequestImpl>
    implements _$$LocationRequestImplCopyWith<$Res> {
  __$$LocationRequestImplCopyWithImpl(
    _$LocationRequestImpl _value,
    $Res Function(_$LocationRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? latitude = null, Object? longitude = null}) {
    return _then(
      _$LocationRequestImpl(
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationRequestImpl implements _LocationRequest {
  const _$LocationRequestImpl({
    required this.latitude,
    required this.longitude,
  });

  factory _$LocationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationRequestImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'LocationRequest(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationRequestImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  /// Create a copy of LocationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationRequestImplCopyWith<_$LocationRequestImpl> get copyWith =>
      __$$LocationRequestImplCopyWithImpl<_$LocationRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationRequestImplToJson(this);
  }
}

abstract class _LocationRequest implements LocationRequest {
  const factory _LocationRequest({
    required final double latitude,
    required final double longitude,
  }) = _$LocationRequestImpl;

  factory _LocationRequest.fromJson(Map<String, dynamic> json) =
      _$LocationRequestImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;

  /// Create a copy of LocationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationRequestImplCopyWith<_$LocationRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
