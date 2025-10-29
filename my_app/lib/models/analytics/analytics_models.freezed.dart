// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AggregatedReadingResponse _$AggregatedReadingResponseFromJson(
  Map<String, dynamic> json,
) {
  return _AggregatedReadingResponse.fromJson(json);
}

/// @nodoc
mixin _$AggregatedReadingResponse {
  int get id => throw _privateConstructorUsedError;
  int get deviceId => throw _privateConstructorUsedError;
  String get deviceName => throw _privateConstructorUsedError;
  AggregationType get aggregationType => throw _privateConstructorUsedError;
  DateTime get periodStart => throw _privateConstructorUsedError;
  DateTime get periodEnd => throw _privateConstructorUsedError;
  double get avgVoltage => throw _privateConstructorUsedError;
  double get maxVoltage => throw _privateConstructorUsedError;
  double get minVoltage => throw _privateConstructorUsedError;
  double get avgCurrent => throw _privateConstructorUsedError;
  double get maxCurrent => throw _privateConstructorUsedError;
  double get minCurrent => throw _privateConstructorUsedError;
  double get avgPower => throw _privateConstructorUsedError;
  double get maxPower => throw _privateConstructorUsedError;
  double get minPower => throw _privateConstructorUsedError;
  double get totalEnergyConsumed => throw _privateConstructorUsedError;
  int get readingCount => throw _privateConstructorUsedError;

  /// Serializes this AggregatedReadingResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AggregatedReadingResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AggregatedReadingResponseCopyWith<AggregatedReadingResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AggregatedReadingResponseCopyWith<$Res> {
  factory $AggregatedReadingResponseCopyWith(
    AggregatedReadingResponse value,
    $Res Function(AggregatedReadingResponse) then,
  ) = _$AggregatedReadingResponseCopyWithImpl<$Res, AggregatedReadingResponse>;
  @useResult
  $Res call({
    int id,
    int deviceId,
    String deviceName,
    AggregationType aggregationType,
    DateTime periodStart,
    DateTime periodEnd,
    double avgVoltage,
    double maxVoltage,
    double minVoltage,
    double avgCurrent,
    double maxCurrent,
    double minCurrent,
    double avgPower,
    double maxPower,
    double minPower,
    double totalEnergyConsumed,
    int readingCount,
  });
}

/// @nodoc
class _$AggregatedReadingResponseCopyWithImpl<
  $Res,
  $Val extends AggregatedReadingResponse
>
    implements $AggregatedReadingResponseCopyWith<$Res> {
  _$AggregatedReadingResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AggregatedReadingResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceId = null,
    Object? deviceName = null,
    Object? aggregationType = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? avgVoltage = null,
    Object? maxVoltage = null,
    Object? minVoltage = null,
    Object? avgCurrent = null,
    Object? maxCurrent = null,
    Object? minCurrent = null,
    Object? avgPower = null,
    Object? maxPower = null,
    Object? minPower = null,
    Object? totalEnergyConsumed = null,
    Object? readingCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            deviceId: null == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                      as int,
            deviceName: null == deviceName
                ? _value.deviceName
                : deviceName // ignore: cast_nullable_to_non_nullable
                      as String,
            aggregationType: null == aggregationType
                ? _value.aggregationType
                : aggregationType // ignore: cast_nullable_to_non_nullable
                      as AggregationType,
            periodStart: null == periodStart
                ? _value.periodStart
                : periodStart // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            periodEnd: null == periodEnd
                ? _value.periodEnd
                : periodEnd // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            avgVoltage: null == avgVoltage
                ? _value.avgVoltage
                : avgVoltage // ignore: cast_nullable_to_non_nullable
                      as double,
            maxVoltage: null == maxVoltage
                ? _value.maxVoltage
                : maxVoltage // ignore: cast_nullable_to_non_nullable
                      as double,
            minVoltage: null == minVoltage
                ? _value.minVoltage
                : minVoltage // ignore: cast_nullable_to_non_nullable
                      as double,
            avgCurrent: null == avgCurrent
                ? _value.avgCurrent
                : avgCurrent // ignore: cast_nullable_to_non_nullable
                      as double,
            maxCurrent: null == maxCurrent
                ? _value.maxCurrent
                : maxCurrent // ignore: cast_nullable_to_non_nullable
                      as double,
            minCurrent: null == minCurrent
                ? _value.minCurrent
                : minCurrent // ignore: cast_nullable_to_non_nullable
                      as double,
            avgPower: null == avgPower
                ? _value.avgPower
                : avgPower // ignore: cast_nullable_to_non_nullable
                      as double,
            maxPower: null == maxPower
                ? _value.maxPower
                : maxPower // ignore: cast_nullable_to_non_nullable
                      as double,
            minPower: null == minPower
                ? _value.minPower
                : minPower // ignore: cast_nullable_to_non_nullable
                      as double,
            totalEnergyConsumed: null == totalEnergyConsumed
                ? _value.totalEnergyConsumed
                : totalEnergyConsumed // ignore: cast_nullable_to_non_nullable
                      as double,
            readingCount: null == readingCount
                ? _value.readingCount
                : readingCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AggregatedReadingResponseImplCopyWith<$Res>
    implements $AggregatedReadingResponseCopyWith<$Res> {
  factory _$$AggregatedReadingResponseImplCopyWith(
    _$AggregatedReadingResponseImpl value,
    $Res Function(_$AggregatedReadingResponseImpl) then,
  ) = __$$AggregatedReadingResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int deviceId,
    String deviceName,
    AggregationType aggregationType,
    DateTime periodStart,
    DateTime periodEnd,
    double avgVoltage,
    double maxVoltage,
    double minVoltage,
    double avgCurrent,
    double maxCurrent,
    double minCurrent,
    double avgPower,
    double maxPower,
    double minPower,
    double totalEnergyConsumed,
    int readingCount,
  });
}

/// @nodoc
class __$$AggregatedReadingResponseImplCopyWithImpl<$Res>
    extends
        _$AggregatedReadingResponseCopyWithImpl<
          $Res,
          _$AggregatedReadingResponseImpl
        >
    implements _$$AggregatedReadingResponseImplCopyWith<$Res> {
  __$$AggregatedReadingResponseImplCopyWithImpl(
    _$AggregatedReadingResponseImpl _value,
    $Res Function(_$AggregatedReadingResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AggregatedReadingResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceId = null,
    Object? deviceName = null,
    Object? aggregationType = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? avgVoltage = null,
    Object? maxVoltage = null,
    Object? minVoltage = null,
    Object? avgCurrent = null,
    Object? maxCurrent = null,
    Object? minCurrent = null,
    Object? avgPower = null,
    Object? maxPower = null,
    Object? minPower = null,
    Object? totalEnergyConsumed = null,
    Object? readingCount = null,
  }) {
    return _then(
      _$AggregatedReadingResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        deviceId: null == deviceId
            ? _value.deviceId
            : deviceId // ignore: cast_nullable_to_non_nullable
                  as int,
        deviceName: null == deviceName
            ? _value.deviceName
            : deviceName // ignore: cast_nullable_to_non_nullable
                  as String,
        aggregationType: null == aggregationType
            ? _value.aggregationType
            : aggregationType // ignore: cast_nullable_to_non_nullable
                  as AggregationType,
        periodStart: null == periodStart
            ? _value.periodStart
            : periodStart // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        periodEnd: null == periodEnd
            ? _value.periodEnd
            : periodEnd // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        avgVoltage: null == avgVoltage
            ? _value.avgVoltage
            : avgVoltage // ignore: cast_nullable_to_non_nullable
                  as double,
        maxVoltage: null == maxVoltage
            ? _value.maxVoltage
            : maxVoltage // ignore: cast_nullable_to_non_nullable
                  as double,
        minVoltage: null == minVoltage
            ? _value.minVoltage
            : minVoltage // ignore: cast_nullable_to_non_nullable
                  as double,
        avgCurrent: null == avgCurrent
            ? _value.avgCurrent
            : avgCurrent // ignore: cast_nullable_to_non_nullable
                  as double,
        maxCurrent: null == maxCurrent
            ? _value.maxCurrent
            : maxCurrent // ignore: cast_nullable_to_non_nullable
                  as double,
        minCurrent: null == minCurrent
            ? _value.minCurrent
            : minCurrent // ignore: cast_nullable_to_non_nullable
                  as double,
        avgPower: null == avgPower
            ? _value.avgPower
            : avgPower // ignore: cast_nullable_to_non_nullable
                  as double,
        maxPower: null == maxPower
            ? _value.maxPower
            : maxPower // ignore: cast_nullable_to_non_nullable
                  as double,
        minPower: null == minPower
            ? _value.minPower
            : minPower // ignore: cast_nullable_to_non_nullable
                  as double,
        totalEnergyConsumed: null == totalEnergyConsumed
            ? _value.totalEnergyConsumed
            : totalEnergyConsumed // ignore: cast_nullable_to_non_nullable
                  as double,
        readingCount: null == readingCount
            ? _value.readingCount
            : readingCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AggregatedReadingResponseImpl implements _AggregatedReadingResponse {
  const _$AggregatedReadingResponseImpl({
    required this.id,
    required this.deviceId,
    required this.deviceName,
    required this.aggregationType,
    required this.periodStart,
    required this.periodEnd,
    required this.avgVoltage,
    required this.maxVoltage,
    required this.minVoltage,
    required this.avgCurrent,
    required this.maxCurrent,
    required this.minCurrent,
    required this.avgPower,
    required this.maxPower,
    required this.minPower,
    required this.totalEnergyConsumed,
    required this.readingCount,
  });

  factory _$AggregatedReadingResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AggregatedReadingResponseImplFromJson(json);

  @override
  final int id;
  @override
  final int deviceId;
  @override
  final String deviceName;
  @override
  final AggregationType aggregationType;
  @override
  final DateTime periodStart;
  @override
  final DateTime periodEnd;
  @override
  final double avgVoltage;
  @override
  final double maxVoltage;
  @override
  final double minVoltage;
  @override
  final double avgCurrent;
  @override
  final double maxCurrent;
  @override
  final double minCurrent;
  @override
  final double avgPower;
  @override
  final double maxPower;
  @override
  final double minPower;
  @override
  final double totalEnergyConsumed;
  @override
  final int readingCount;

  @override
  String toString() {
    return 'AggregatedReadingResponse(id: $id, deviceId: $deviceId, deviceName: $deviceName, aggregationType: $aggregationType, periodStart: $periodStart, periodEnd: $periodEnd, avgVoltage: $avgVoltage, maxVoltage: $maxVoltage, minVoltage: $minVoltage, avgCurrent: $avgCurrent, maxCurrent: $maxCurrent, minCurrent: $minCurrent, avgPower: $avgPower, maxPower: $maxPower, minPower: $minPower, totalEnergyConsumed: $totalEnergyConsumed, readingCount: $readingCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AggregatedReadingResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.aggregationType, aggregationType) ||
                other.aggregationType == aggregationType) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            (identical(other.avgVoltage, avgVoltage) ||
                other.avgVoltage == avgVoltage) &&
            (identical(other.maxVoltage, maxVoltage) ||
                other.maxVoltage == maxVoltage) &&
            (identical(other.minVoltage, minVoltage) ||
                other.minVoltage == minVoltage) &&
            (identical(other.avgCurrent, avgCurrent) ||
                other.avgCurrent == avgCurrent) &&
            (identical(other.maxCurrent, maxCurrent) ||
                other.maxCurrent == maxCurrent) &&
            (identical(other.minCurrent, minCurrent) ||
                other.minCurrent == minCurrent) &&
            (identical(other.avgPower, avgPower) ||
                other.avgPower == avgPower) &&
            (identical(other.maxPower, maxPower) ||
                other.maxPower == maxPower) &&
            (identical(other.minPower, minPower) ||
                other.minPower == minPower) &&
            (identical(other.totalEnergyConsumed, totalEnergyConsumed) ||
                other.totalEnergyConsumed == totalEnergyConsumed) &&
            (identical(other.readingCount, readingCount) ||
                other.readingCount == readingCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    deviceId,
    deviceName,
    aggregationType,
    periodStart,
    periodEnd,
    avgVoltage,
    maxVoltage,
    minVoltage,
    avgCurrent,
    maxCurrent,
    minCurrent,
    avgPower,
    maxPower,
    minPower,
    totalEnergyConsumed,
    readingCount,
  );

  /// Create a copy of AggregatedReadingResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AggregatedReadingResponseImplCopyWith<_$AggregatedReadingResponseImpl>
  get copyWith =>
      __$$AggregatedReadingResponseImplCopyWithImpl<
        _$AggregatedReadingResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AggregatedReadingResponseImplToJson(this);
  }
}

abstract class _AggregatedReadingResponse implements AggregatedReadingResponse {
  const factory _AggregatedReadingResponse({
    required final int id,
    required final int deviceId,
    required final String deviceName,
    required final AggregationType aggregationType,
    required final DateTime periodStart,
    required final DateTime periodEnd,
    required final double avgVoltage,
    required final double maxVoltage,
    required final double minVoltage,
    required final double avgCurrent,
    required final double maxCurrent,
    required final double minCurrent,
    required final double avgPower,
    required final double maxPower,
    required final double minPower,
    required final double totalEnergyConsumed,
    required final int readingCount,
  }) = _$AggregatedReadingResponseImpl;

  factory _AggregatedReadingResponse.fromJson(Map<String, dynamic> json) =
      _$AggregatedReadingResponseImpl.fromJson;

  @override
  int get id;
  @override
  int get deviceId;
  @override
  String get deviceName;
  @override
  AggregationType get aggregationType;
  @override
  DateTime get periodStart;
  @override
  DateTime get periodEnd;
  @override
  double get avgVoltage;
  @override
  double get maxVoltage;
  @override
  double get minVoltage;
  @override
  double get avgCurrent;
  @override
  double get maxCurrent;
  @override
  double get minCurrent;
  @override
  double get avgPower;
  @override
  double get maxPower;
  @override
  double get minPower;
  @override
  double get totalEnergyConsumed;
  @override
  int get readingCount;

  /// Create a copy of AggregatedReadingResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AggregatedReadingResponseImplCopyWith<_$AggregatedReadingResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AnalyticsResponse _$AnalyticsResponseFromJson(Map<String, dynamic> json) {
  return _AnalyticsResponse.fromJson(json);
}

/// @nodoc
mixin _$AnalyticsResponse {
  List<AggregatedReadingResponse> get data =>
      throw _privateConstructorUsedError;
  double get totalEnergyConsumed => throw _privateConstructorUsedError;
  double get avgPower => throw _privateConstructorUsedError;
  int get totalReadings => throw _privateConstructorUsedError;

  /// Serializes this AnalyticsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsResponseCopyWith<AnalyticsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsResponseCopyWith<$Res> {
  factory $AnalyticsResponseCopyWith(
    AnalyticsResponse value,
    $Res Function(AnalyticsResponse) then,
  ) = _$AnalyticsResponseCopyWithImpl<$Res, AnalyticsResponse>;
  @useResult
  $Res call({
    List<AggregatedReadingResponse> data,
    double totalEnergyConsumed,
    double avgPower,
    int totalReadings,
  });
}

/// @nodoc
class _$AnalyticsResponseCopyWithImpl<$Res, $Val extends AnalyticsResponse>
    implements $AnalyticsResponseCopyWith<$Res> {
  _$AnalyticsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? totalEnergyConsumed = null,
    Object? avgPower = null,
    Object? totalReadings = null,
  }) {
    return _then(
      _value.copyWith(
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<AggregatedReadingResponse>,
            totalEnergyConsumed: null == totalEnergyConsumed
                ? _value.totalEnergyConsumed
                : totalEnergyConsumed // ignore: cast_nullable_to_non_nullable
                      as double,
            avgPower: null == avgPower
                ? _value.avgPower
                : avgPower // ignore: cast_nullable_to_non_nullable
                      as double,
            totalReadings: null == totalReadings
                ? _value.totalReadings
                : totalReadings // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnalyticsResponseImplCopyWith<$Res>
    implements $AnalyticsResponseCopyWith<$Res> {
  factory _$$AnalyticsResponseImplCopyWith(
    _$AnalyticsResponseImpl value,
    $Res Function(_$AnalyticsResponseImpl) then,
  ) = __$$AnalyticsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<AggregatedReadingResponse> data,
    double totalEnergyConsumed,
    double avgPower,
    int totalReadings,
  });
}

/// @nodoc
class __$$AnalyticsResponseImplCopyWithImpl<$Res>
    extends _$AnalyticsResponseCopyWithImpl<$Res, _$AnalyticsResponseImpl>
    implements _$$AnalyticsResponseImplCopyWith<$Res> {
  __$$AnalyticsResponseImplCopyWithImpl(
    _$AnalyticsResponseImpl _value,
    $Res Function(_$AnalyticsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? totalEnergyConsumed = null,
    Object? avgPower = null,
    Object? totalReadings = null,
  }) {
    return _then(
      _$AnalyticsResponseImpl(
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<AggregatedReadingResponse>,
        totalEnergyConsumed: null == totalEnergyConsumed
            ? _value.totalEnergyConsumed
            : totalEnergyConsumed // ignore: cast_nullable_to_non_nullable
                  as double,
        avgPower: null == avgPower
            ? _value.avgPower
            : avgPower // ignore: cast_nullable_to_non_nullable
                  as double,
        totalReadings: null == totalReadings
            ? _value.totalReadings
            : totalReadings // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyticsResponseImpl implements _AnalyticsResponse {
  const _$AnalyticsResponseImpl({
    required final List<AggregatedReadingResponse> data,
    required this.totalEnergyConsumed,
    required this.avgPower,
    required this.totalReadings,
  }) : _data = data;

  factory _$AnalyticsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyticsResponseImplFromJson(json);

  final List<AggregatedReadingResponse> _data;
  @override
  List<AggregatedReadingResponse> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final double totalEnergyConsumed;
  @override
  final double avgPower;
  @override
  final int totalReadings;

  @override
  String toString() {
    return 'AnalyticsResponse(data: $data, totalEnergyConsumed: $totalEnergyConsumed, avgPower: $avgPower, totalReadings: $totalReadings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.totalEnergyConsumed, totalEnergyConsumed) ||
                other.totalEnergyConsumed == totalEnergyConsumed) &&
            (identical(other.avgPower, avgPower) ||
                other.avgPower == avgPower) &&
            (identical(other.totalReadings, totalReadings) ||
                other.totalReadings == totalReadings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_data),
    totalEnergyConsumed,
    avgPower,
    totalReadings,
  );

  /// Create a copy of AnalyticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsResponseImplCopyWith<_$AnalyticsResponseImpl> get copyWith =>
      __$$AnalyticsResponseImplCopyWithImpl<_$AnalyticsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyticsResponseImplToJson(this);
  }
}

abstract class _AnalyticsResponse implements AnalyticsResponse {
  const factory _AnalyticsResponse({
    required final List<AggregatedReadingResponse> data,
    required final double totalEnergyConsumed,
    required final double avgPower,
    required final int totalReadings,
  }) = _$AnalyticsResponseImpl;

  factory _AnalyticsResponse.fromJson(Map<String, dynamic> json) =
      _$AnalyticsResponseImpl.fromJson;

  @override
  List<AggregatedReadingResponse> get data;
  @override
  double get totalEnergyConsumed;
  @override
  double get avgPower;
  @override
  int get totalReadings;

  /// Create a copy of AnalyticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsResponseImplCopyWith<_$AnalyticsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ApiResponse<T> {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiResponseCopyWith<T, ApiResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<T, $Res> {
  factory $ApiResponseCopyWith(
    ApiResponse<T> value,
    $Res Function(ApiResponse<T>) then,
  ) = _$ApiResponseCopyWithImpl<T, $Res, ApiResponse<T>>;
  @useResult
  $Res call({bool success, String message, T? data});
}

/// @nodoc
class _$ApiResponseCopyWithImpl<T, $Res, $Val extends ApiResponse<T>>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as T?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApiResponseImplCopyWith<T, $Res>
    implements $ApiResponseCopyWith<T, $Res> {
  factory _$$ApiResponseImplCopyWith(
    _$ApiResponseImpl<T> value,
    $Res Function(_$ApiResponseImpl<T>) then,
  ) = __$$ApiResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({bool success, String message, T? data});
}

/// @nodoc
class __$$ApiResponseImplCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$ApiResponseImpl<T>>
    implements _$$ApiResponseImplCopyWith<T, $Res> {
  __$$ApiResponseImplCopyWithImpl(
    _$ApiResponseImpl<T> _value,
    $Res Function(_$ApiResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _$ApiResponseImpl<T>(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as T?,
      ),
    );
  }
}

/// @nodoc

class _$ApiResponseImpl<T> implements _ApiResponse<T> {
  const _$ApiResponseImpl({
    required this.success,
    required this.message,
    this.data,
  });

  @override
  final bool success;
  @override
  final String message;
  @override
  final T? data;

  @override
  String toString() {
    return 'ApiResponse<$T>(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseImpl<T> &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    message,
    const DeepCollectionEquality().hash(data),
  );

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseImplCopyWith<T, _$ApiResponseImpl<T>> get copyWith =>
      __$$ApiResponseImplCopyWithImpl<T, _$ApiResponseImpl<T>>(
        this,
        _$identity,
      );
}

abstract class _ApiResponse<T> implements ApiResponse<T> {
  const factory _ApiResponse({
    required final bool success,
    required final String message,
    final T? data,
  }) = _$ApiResponseImpl<T>;

  @override
  bool get success;
  @override
  String get message;
  @override
  T? get data;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiResponseImplCopyWith<T, _$ApiResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

DeviceResponse _$DeviceResponseFromJson(Map<String, dynamic> json) {
  return _DeviceResponse.fromJson(json);
}

/// @nodoc
mixin _$DeviceResponse {
  int get id => throw _privateConstructorUsedError;
  String get deviceName => throw _privateConstructorUsedError;
  String get esp32Id => throw _privateConstructorUsedError;
  String get deviceToken => throw _privateConstructorUsedError;
  DeviceType get deviceType => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get userEmail => throw _privateConstructorUsedError;
  bool get ssrEnabled => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  bool get online => throw _privateConstructorUsedError;
  DateTime? get lastSeenAt => throw _privateConstructorUsedError;
  double get voltageCalibration => throw _privateConstructorUsedError;
  double get currentCalibration => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get installationNotes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DeviceResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceResponseCopyWith<DeviceResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceResponseCopyWith<$Res> {
  factory $DeviceResponseCopyWith(
    DeviceResponse value,
    $Res Function(DeviceResponse) then,
  ) = _$DeviceResponseCopyWithImpl<$Res, DeviceResponse>;
  @useResult
  $Res call({
    int id,
    String deviceName,
    String esp32Id,
    String deviceToken,
    DeviceType deviceType,
    String? description,
    int userId,
    String userEmail,
    bool ssrEnabled,
    bool active,
    bool online,
    DateTime? lastSeenAt,
    double voltageCalibration,
    double currentCalibration,
    String? location,
    String? installationNotes,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$DeviceResponseCopyWithImpl<$Res, $Val extends DeviceResponse>
    implements $DeviceResponseCopyWith<$Res> {
  _$DeviceResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceName = null,
    Object? esp32Id = null,
    Object? deviceToken = null,
    Object? deviceType = null,
    Object? description = freezed,
    Object? userId = null,
    Object? userEmail = null,
    Object? ssrEnabled = null,
    Object? active = null,
    Object? online = null,
    Object? lastSeenAt = freezed,
    Object? voltageCalibration = null,
    Object? currentCalibration = null,
    Object? location = freezed,
    Object? installationNotes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            deviceName: null == deviceName
                ? _value.deviceName
                : deviceName // ignore: cast_nullable_to_non_nullable
                      as String,
            esp32Id: null == esp32Id
                ? _value.esp32Id
                : esp32Id // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceToken: null == deviceToken
                ? _value.deviceToken
                : deviceToken // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceType: null == deviceType
                ? _value.deviceType
                : deviceType // ignore: cast_nullable_to_non_nullable
                      as DeviceType,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            userEmail: null == userEmail
                ? _value.userEmail
                : userEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            ssrEnabled: null == ssrEnabled
                ? _value.ssrEnabled
                : ssrEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            online: null == online
                ? _value.online
                : online // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastSeenAt: freezed == lastSeenAt
                ? _value.lastSeenAt
                : lastSeenAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            voltageCalibration: null == voltageCalibration
                ? _value.voltageCalibration
                : voltageCalibration // ignore: cast_nullable_to_non_nullable
                      as double,
            currentCalibration: null == currentCalibration
                ? _value.currentCalibration
                : currentCalibration // ignore: cast_nullable_to_non_nullable
                      as double,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            installationNotes: freezed == installationNotes
                ? _value.installationNotes
                : installationNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeviceResponseImplCopyWith<$Res>
    implements $DeviceResponseCopyWith<$Res> {
  factory _$$DeviceResponseImplCopyWith(
    _$DeviceResponseImpl value,
    $Res Function(_$DeviceResponseImpl) then,
  ) = __$$DeviceResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String deviceName,
    String esp32Id,
    String deviceToken,
    DeviceType deviceType,
    String? description,
    int userId,
    String userEmail,
    bool ssrEnabled,
    bool active,
    bool online,
    DateTime? lastSeenAt,
    double voltageCalibration,
    double currentCalibration,
    String? location,
    String? installationNotes,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$DeviceResponseImplCopyWithImpl<$Res>
    extends _$DeviceResponseCopyWithImpl<$Res, _$DeviceResponseImpl>
    implements _$$DeviceResponseImplCopyWith<$Res> {
  __$$DeviceResponseImplCopyWithImpl(
    _$DeviceResponseImpl _value,
    $Res Function(_$DeviceResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceName = null,
    Object? esp32Id = null,
    Object? deviceToken = null,
    Object? deviceType = null,
    Object? description = freezed,
    Object? userId = null,
    Object? userEmail = null,
    Object? ssrEnabled = null,
    Object? active = null,
    Object? online = null,
    Object? lastSeenAt = freezed,
    Object? voltageCalibration = null,
    Object? currentCalibration = null,
    Object? location = freezed,
    Object? installationNotes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$DeviceResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        deviceName: null == deviceName
            ? _value.deviceName
            : deviceName // ignore: cast_nullable_to_non_nullable
                  as String,
        esp32Id: null == esp32Id
            ? _value.esp32Id
            : esp32Id // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceToken: null == deviceToken
            ? _value.deviceToken
            : deviceToken // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceType: null == deviceType
            ? _value.deviceType
            : deviceType // ignore: cast_nullable_to_non_nullable
                  as DeviceType,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        userEmail: null == userEmail
            ? _value.userEmail
            : userEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        ssrEnabled: null == ssrEnabled
            ? _value.ssrEnabled
            : ssrEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        online: null == online
            ? _value.online
            : online // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastSeenAt: freezed == lastSeenAt
            ? _value.lastSeenAt
            : lastSeenAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        voltageCalibration: null == voltageCalibration
            ? _value.voltageCalibration
            : voltageCalibration // ignore: cast_nullable_to_non_nullable
                  as double,
        currentCalibration: null == currentCalibration
            ? _value.currentCalibration
            : currentCalibration // ignore: cast_nullable_to_non_nullable
                  as double,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        installationNotes: freezed == installationNotes
            ? _value.installationNotes
            : installationNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceResponseImpl implements _DeviceResponse {
  const _$DeviceResponseImpl({
    required this.id,
    required this.deviceName,
    required this.esp32Id,
    required this.deviceToken,
    required this.deviceType,
    this.description,
    required this.userId,
    required this.userEmail,
    required this.ssrEnabled,
    required this.active,
    required this.online,
    this.lastSeenAt,
    required this.voltageCalibration,
    required this.currentCalibration,
    this.location,
    this.installationNotes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$DeviceResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceResponseImplFromJson(json);

  @override
  final int id;
  @override
  final String deviceName;
  @override
  final String esp32Id;
  @override
  final String deviceToken;
  @override
  final DeviceType deviceType;
  @override
  final String? description;
  @override
  final int userId;
  @override
  final String userEmail;
  @override
  final bool ssrEnabled;
  @override
  final bool active;
  @override
  final bool online;
  @override
  final DateTime? lastSeenAt;
  @override
  final double voltageCalibration;
  @override
  final double currentCalibration;
  @override
  final String? location;
  @override
  final String? installationNotes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'DeviceResponse(id: $id, deviceName: $deviceName, esp32Id: $esp32Id, deviceToken: $deviceToken, deviceType: $deviceType, description: $description, userId: $userId, userEmail: $userEmail, ssrEnabled: $ssrEnabled, active: $active, online: $online, lastSeenAt: $lastSeenAt, voltageCalibration: $voltageCalibration, currentCalibration: $currentCalibration, location: $location, installationNotes: $installationNotes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.esp32Id, esp32Id) || other.esp32Id == esp32Id) &&
            (identical(other.deviceToken, deviceToken) ||
                other.deviceToken == deviceToken) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.ssrEnabled, ssrEnabled) ||
                other.ssrEnabled == ssrEnabled) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.online, online) || other.online == online) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt) &&
            (identical(other.voltageCalibration, voltageCalibration) ||
                other.voltageCalibration == voltageCalibration) &&
            (identical(other.currentCalibration, currentCalibration) ||
                other.currentCalibration == currentCalibration) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.installationNotes, installationNotes) ||
                other.installationNotes == installationNotes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    deviceName,
    esp32Id,
    deviceToken,
    deviceType,
    description,
    userId,
    userEmail,
    ssrEnabled,
    active,
    online,
    lastSeenAt,
    voltageCalibration,
    currentCalibration,
    location,
    installationNotes,
    createdAt,
    updatedAt,
  );

  /// Create a copy of DeviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceResponseImplCopyWith<_$DeviceResponseImpl> get copyWith =>
      __$$DeviceResponseImplCopyWithImpl<_$DeviceResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceResponseImplToJson(this);
  }
}

abstract class _DeviceResponse implements DeviceResponse {
  const factory _DeviceResponse({
    required final int id,
    required final String deviceName,
    required final String esp32Id,
    required final String deviceToken,
    required final DeviceType deviceType,
    final String? description,
    required final int userId,
    required final String userEmail,
    required final bool ssrEnabled,
    required final bool active,
    required final bool online,
    final DateTime? lastSeenAt,
    required final double voltageCalibration,
    required final double currentCalibration,
    final String? location,
    final String? installationNotes,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$DeviceResponseImpl;

  factory _DeviceResponse.fromJson(Map<String, dynamic> json) =
      _$DeviceResponseImpl.fromJson;

  @override
  int get id;
  @override
  String get deviceName;
  @override
  String get esp32Id;
  @override
  String get deviceToken;
  @override
  DeviceType get deviceType;
  @override
  String? get description;
  @override
  int get userId;
  @override
  String get userEmail;
  @override
  bool get ssrEnabled;
  @override
  bool get active;
  @override
  bool get online;
  @override
  DateTime? get lastSeenAt;
  @override
  double get voltageCalibration;
  @override
  double get currentCalibration;
  @override
  String? get location;
  @override
  String? get installationNotes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of DeviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceResponseImplCopyWith<_$DeviceResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CachedAnalyticsData _$CachedAnalyticsDataFromJson(Map<String, dynamic> json) {
  return _CachedAnalyticsData.fromJson(json);
}

/// @nodoc
mixin _$CachedAnalyticsData {
  AggregationType get type => throw _privateConstructorUsedError;
  DateTime get cachedAt => throw _privateConstructorUsedError;
  AnalyticsResponse get data => throw _privateConstructorUsedError;

  /// Serializes this CachedAnalyticsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CachedAnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CachedAnalyticsDataCopyWith<CachedAnalyticsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CachedAnalyticsDataCopyWith<$Res> {
  factory $CachedAnalyticsDataCopyWith(
    CachedAnalyticsData value,
    $Res Function(CachedAnalyticsData) then,
  ) = _$CachedAnalyticsDataCopyWithImpl<$Res, CachedAnalyticsData>;
  @useResult
  $Res call({AggregationType type, DateTime cachedAt, AnalyticsResponse data});

  $AnalyticsResponseCopyWith<$Res> get data;
}

/// @nodoc
class _$CachedAnalyticsDataCopyWithImpl<$Res, $Val extends CachedAnalyticsData>
    implements $CachedAnalyticsDataCopyWith<$Res> {
  _$CachedAnalyticsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CachedAnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? cachedAt = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as AggregationType,
            cachedAt: null == cachedAt
                ? _value.cachedAt
                : cachedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as AnalyticsResponse,
          )
          as $Val,
    );
  }

  /// Create a copy of CachedAnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnalyticsResponseCopyWith<$Res> get data {
    return $AnalyticsResponseCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CachedAnalyticsDataImplCopyWith<$Res>
    implements $CachedAnalyticsDataCopyWith<$Res> {
  factory _$$CachedAnalyticsDataImplCopyWith(
    _$CachedAnalyticsDataImpl value,
    $Res Function(_$CachedAnalyticsDataImpl) then,
  ) = __$$CachedAnalyticsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AggregationType type, DateTime cachedAt, AnalyticsResponse data});

  @override
  $AnalyticsResponseCopyWith<$Res> get data;
}

/// @nodoc
class __$$CachedAnalyticsDataImplCopyWithImpl<$Res>
    extends _$CachedAnalyticsDataCopyWithImpl<$Res, _$CachedAnalyticsDataImpl>
    implements _$$CachedAnalyticsDataImplCopyWith<$Res> {
  __$$CachedAnalyticsDataImplCopyWithImpl(
    _$CachedAnalyticsDataImpl _value,
    $Res Function(_$CachedAnalyticsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CachedAnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? cachedAt = null,
    Object? data = null,
  }) {
    return _then(
      _$CachedAnalyticsDataImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as AggregationType,
        cachedAt: null == cachedAt
            ? _value.cachedAt
            : cachedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as AnalyticsResponse,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CachedAnalyticsDataImpl implements _CachedAnalyticsData {
  const _$CachedAnalyticsDataImpl({
    required this.type,
    required this.cachedAt,
    required this.data,
  });

  factory _$CachedAnalyticsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CachedAnalyticsDataImplFromJson(json);

  @override
  final AggregationType type;
  @override
  final DateTime cachedAt;
  @override
  final AnalyticsResponse data;

  @override
  String toString() {
    return 'CachedAnalyticsData(type: $type, cachedAt: $cachedAt, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CachedAnalyticsDataImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.cachedAt, cachedAt) ||
                other.cachedAt == cachedAt) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, cachedAt, data);

  /// Create a copy of CachedAnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CachedAnalyticsDataImplCopyWith<_$CachedAnalyticsDataImpl> get copyWith =>
      __$$CachedAnalyticsDataImplCopyWithImpl<_$CachedAnalyticsDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CachedAnalyticsDataImplToJson(this);
  }
}

abstract class _CachedAnalyticsData implements CachedAnalyticsData {
  const factory _CachedAnalyticsData({
    required final AggregationType type,
    required final DateTime cachedAt,
    required final AnalyticsResponse data,
  }) = _$CachedAnalyticsDataImpl;

  factory _CachedAnalyticsData.fromJson(Map<String, dynamic> json) =
      _$CachedAnalyticsDataImpl.fromJson;

  @override
  AggregationType get type;
  @override
  DateTime get cachedAt;
  @override
  AnalyticsResponse get data;

  /// Create a copy of CachedAnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CachedAnalyticsDataImplCopyWith<_$CachedAnalyticsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
