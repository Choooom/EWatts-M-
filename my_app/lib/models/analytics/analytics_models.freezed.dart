// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AggregatedReadingResponse {

 int get id; int get deviceId; String get deviceName; AggregationType get aggregationType; DateTime get periodStart; DateTime get periodEnd; double get avgVoltage; double get maxVoltage; double get minVoltage; double get avgCurrent; double get maxCurrent; double get minCurrent; double get avgPower; double get maxPower; double get minPower; double get totalEnergyConsumed; int get readingCount;
/// Create a copy of AggregatedReadingResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AggregatedReadingResponseCopyWith<AggregatedReadingResponse> get copyWith => _$AggregatedReadingResponseCopyWithImpl<AggregatedReadingResponse>(this as AggregatedReadingResponse, _$identity);

  /// Serializes this AggregatedReadingResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AggregatedReadingResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.aggregationType, aggregationType) || other.aggregationType == aggregationType)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.avgVoltage, avgVoltage) || other.avgVoltage == avgVoltage)&&(identical(other.maxVoltage, maxVoltage) || other.maxVoltage == maxVoltage)&&(identical(other.minVoltage, minVoltage) || other.minVoltage == minVoltage)&&(identical(other.avgCurrent, avgCurrent) || other.avgCurrent == avgCurrent)&&(identical(other.maxCurrent, maxCurrent) || other.maxCurrent == maxCurrent)&&(identical(other.minCurrent, minCurrent) || other.minCurrent == minCurrent)&&(identical(other.avgPower, avgPower) || other.avgPower == avgPower)&&(identical(other.maxPower, maxPower) || other.maxPower == maxPower)&&(identical(other.minPower, minPower) || other.minPower == minPower)&&(identical(other.totalEnergyConsumed, totalEnergyConsumed) || other.totalEnergyConsumed == totalEnergyConsumed)&&(identical(other.readingCount, readingCount) || other.readingCount == readingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deviceId,deviceName,aggregationType,periodStart,periodEnd,avgVoltage,maxVoltage,minVoltage,avgCurrent,maxCurrent,minCurrent,avgPower,maxPower,minPower,totalEnergyConsumed,readingCount);

@override
String toString() {
  return 'AggregatedReadingResponse(id: $id, deviceId: $deviceId, deviceName: $deviceName, aggregationType: $aggregationType, periodStart: $periodStart, periodEnd: $periodEnd, avgVoltage: $avgVoltage, maxVoltage: $maxVoltage, minVoltage: $minVoltage, avgCurrent: $avgCurrent, maxCurrent: $maxCurrent, minCurrent: $minCurrent, avgPower: $avgPower, maxPower: $maxPower, minPower: $minPower, totalEnergyConsumed: $totalEnergyConsumed, readingCount: $readingCount)';
}


}

/// @nodoc
abstract mixin class $AggregatedReadingResponseCopyWith<$Res>  {
  factory $AggregatedReadingResponseCopyWith(AggregatedReadingResponse value, $Res Function(AggregatedReadingResponse) _then) = _$AggregatedReadingResponseCopyWithImpl;
@useResult
$Res call({
 int id, int deviceId, String deviceName, AggregationType aggregationType, DateTime periodStart, DateTime periodEnd, double avgVoltage, double maxVoltage, double minVoltage, double avgCurrent, double maxCurrent, double minCurrent, double avgPower, double maxPower, double minPower, double totalEnergyConsumed, int readingCount
});




}
/// @nodoc
class _$AggregatedReadingResponseCopyWithImpl<$Res>
    implements $AggregatedReadingResponseCopyWith<$Res> {
  _$AggregatedReadingResponseCopyWithImpl(this._self, this._then);

  final AggregatedReadingResponse _self;
  final $Res Function(AggregatedReadingResponse) _then;

/// Create a copy of AggregatedReadingResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? deviceId = null,Object? deviceName = null,Object? aggregationType = null,Object? periodStart = null,Object? periodEnd = null,Object? avgVoltage = null,Object? maxVoltage = null,Object? minVoltage = null,Object? avgCurrent = null,Object? maxCurrent = null,Object? minCurrent = null,Object? avgPower = null,Object? maxPower = null,Object? minPower = null,Object? totalEnergyConsumed = null,Object? readingCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as int,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,aggregationType: null == aggregationType ? _self.aggregationType : aggregationType // ignore: cast_nullable_to_non_nullable
as AggregationType,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,avgVoltage: null == avgVoltage ? _self.avgVoltage : avgVoltage // ignore: cast_nullable_to_non_nullable
as double,maxVoltage: null == maxVoltage ? _self.maxVoltage : maxVoltage // ignore: cast_nullable_to_non_nullable
as double,minVoltage: null == minVoltage ? _self.minVoltage : minVoltage // ignore: cast_nullable_to_non_nullable
as double,avgCurrent: null == avgCurrent ? _self.avgCurrent : avgCurrent // ignore: cast_nullable_to_non_nullable
as double,maxCurrent: null == maxCurrent ? _self.maxCurrent : maxCurrent // ignore: cast_nullable_to_non_nullable
as double,minCurrent: null == minCurrent ? _self.minCurrent : minCurrent // ignore: cast_nullable_to_non_nullable
as double,avgPower: null == avgPower ? _self.avgPower : avgPower // ignore: cast_nullable_to_non_nullable
as double,maxPower: null == maxPower ? _self.maxPower : maxPower // ignore: cast_nullable_to_non_nullable
as double,minPower: null == minPower ? _self.minPower : minPower // ignore: cast_nullable_to_non_nullable
as double,totalEnergyConsumed: null == totalEnergyConsumed ? _self.totalEnergyConsumed : totalEnergyConsumed // ignore: cast_nullable_to_non_nullable
as double,readingCount: null == readingCount ? _self.readingCount : readingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AggregatedReadingResponse].
extension AggregatedReadingResponsePatterns on AggregatedReadingResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AggregatedReadingResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AggregatedReadingResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AggregatedReadingResponse value)  $default,){
final _that = this;
switch (_that) {
case _AggregatedReadingResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AggregatedReadingResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AggregatedReadingResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int deviceId,  String deviceName,  AggregationType aggregationType,  DateTime periodStart,  DateTime periodEnd,  double avgVoltage,  double maxVoltage,  double minVoltage,  double avgCurrent,  double maxCurrent,  double minCurrent,  double avgPower,  double maxPower,  double minPower,  double totalEnergyConsumed,  int readingCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AggregatedReadingResponse() when $default != null:
return $default(_that.id,_that.deviceId,_that.deviceName,_that.aggregationType,_that.periodStart,_that.periodEnd,_that.avgVoltage,_that.maxVoltage,_that.minVoltage,_that.avgCurrent,_that.maxCurrent,_that.minCurrent,_that.avgPower,_that.maxPower,_that.minPower,_that.totalEnergyConsumed,_that.readingCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int deviceId,  String deviceName,  AggregationType aggregationType,  DateTime periodStart,  DateTime periodEnd,  double avgVoltage,  double maxVoltage,  double minVoltage,  double avgCurrent,  double maxCurrent,  double minCurrent,  double avgPower,  double maxPower,  double minPower,  double totalEnergyConsumed,  int readingCount)  $default,) {final _that = this;
switch (_that) {
case _AggregatedReadingResponse():
return $default(_that.id,_that.deviceId,_that.deviceName,_that.aggregationType,_that.periodStart,_that.periodEnd,_that.avgVoltage,_that.maxVoltage,_that.minVoltage,_that.avgCurrent,_that.maxCurrent,_that.minCurrent,_that.avgPower,_that.maxPower,_that.minPower,_that.totalEnergyConsumed,_that.readingCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int deviceId,  String deviceName,  AggregationType aggregationType,  DateTime periodStart,  DateTime periodEnd,  double avgVoltage,  double maxVoltage,  double minVoltage,  double avgCurrent,  double maxCurrent,  double minCurrent,  double avgPower,  double maxPower,  double minPower,  double totalEnergyConsumed,  int readingCount)?  $default,) {final _that = this;
switch (_that) {
case _AggregatedReadingResponse() when $default != null:
return $default(_that.id,_that.deviceId,_that.deviceName,_that.aggregationType,_that.periodStart,_that.periodEnd,_that.avgVoltage,_that.maxVoltage,_that.minVoltage,_that.avgCurrent,_that.maxCurrent,_that.minCurrent,_that.avgPower,_that.maxPower,_that.minPower,_that.totalEnergyConsumed,_that.readingCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AggregatedReadingResponse implements AggregatedReadingResponse {
  const _AggregatedReadingResponse({required this.id, required this.deviceId, required this.deviceName, required this.aggregationType, required this.periodStart, required this.periodEnd, required this.avgVoltage, required this.maxVoltage, required this.minVoltage, required this.avgCurrent, required this.maxCurrent, required this.minCurrent, required this.avgPower, required this.maxPower, required this.minPower, required this.totalEnergyConsumed, required this.readingCount});
  factory _AggregatedReadingResponse.fromJson(Map<String, dynamic> json) => _$AggregatedReadingResponseFromJson(json);

@override final  int id;
@override final  int deviceId;
@override final  String deviceName;
@override final  AggregationType aggregationType;
@override final  DateTime periodStart;
@override final  DateTime periodEnd;
@override final  double avgVoltage;
@override final  double maxVoltage;
@override final  double minVoltage;
@override final  double avgCurrent;
@override final  double maxCurrent;
@override final  double minCurrent;
@override final  double avgPower;
@override final  double maxPower;
@override final  double minPower;
@override final  double totalEnergyConsumed;
@override final  int readingCount;

/// Create a copy of AggregatedReadingResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AggregatedReadingResponseCopyWith<_AggregatedReadingResponse> get copyWith => __$AggregatedReadingResponseCopyWithImpl<_AggregatedReadingResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AggregatedReadingResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AggregatedReadingResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.aggregationType, aggregationType) || other.aggregationType == aggregationType)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.avgVoltage, avgVoltage) || other.avgVoltage == avgVoltage)&&(identical(other.maxVoltage, maxVoltage) || other.maxVoltage == maxVoltage)&&(identical(other.minVoltage, minVoltage) || other.minVoltage == minVoltage)&&(identical(other.avgCurrent, avgCurrent) || other.avgCurrent == avgCurrent)&&(identical(other.maxCurrent, maxCurrent) || other.maxCurrent == maxCurrent)&&(identical(other.minCurrent, minCurrent) || other.minCurrent == minCurrent)&&(identical(other.avgPower, avgPower) || other.avgPower == avgPower)&&(identical(other.maxPower, maxPower) || other.maxPower == maxPower)&&(identical(other.minPower, minPower) || other.minPower == minPower)&&(identical(other.totalEnergyConsumed, totalEnergyConsumed) || other.totalEnergyConsumed == totalEnergyConsumed)&&(identical(other.readingCount, readingCount) || other.readingCount == readingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deviceId,deviceName,aggregationType,periodStart,periodEnd,avgVoltage,maxVoltage,minVoltage,avgCurrent,maxCurrent,minCurrent,avgPower,maxPower,minPower,totalEnergyConsumed,readingCount);

@override
String toString() {
  return 'AggregatedReadingResponse(id: $id, deviceId: $deviceId, deviceName: $deviceName, aggregationType: $aggregationType, periodStart: $periodStart, periodEnd: $periodEnd, avgVoltage: $avgVoltage, maxVoltage: $maxVoltage, minVoltage: $minVoltage, avgCurrent: $avgCurrent, maxCurrent: $maxCurrent, minCurrent: $minCurrent, avgPower: $avgPower, maxPower: $maxPower, minPower: $minPower, totalEnergyConsumed: $totalEnergyConsumed, readingCount: $readingCount)';
}


}

/// @nodoc
abstract mixin class _$AggregatedReadingResponseCopyWith<$Res> implements $AggregatedReadingResponseCopyWith<$Res> {
  factory _$AggregatedReadingResponseCopyWith(_AggregatedReadingResponse value, $Res Function(_AggregatedReadingResponse) _then) = __$AggregatedReadingResponseCopyWithImpl;
@override @useResult
$Res call({
 int id, int deviceId, String deviceName, AggregationType aggregationType, DateTime periodStart, DateTime periodEnd, double avgVoltage, double maxVoltage, double minVoltage, double avgCurrent, double maxCurrent, double minCurrent, double avgPower, double maxPower, double minPower, double totalEnergyConsumed, int readingCount
});




}
/// @nodoc
class __$AggregatedReadingResponseCopyWithImpl<$Res>
    implements _$AggregatedReadingResponseCopyWith<$Res> {
  __$AggregatedReadingResponseCopyWithImpl(this._self, this._then);

  final _AggregatedReadingResponse _self;
  final $Res Function(_AggregatedReadingResponse) _then;

/// Create a copy of AggregatedReadingResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? deviceId = null,Object? deviceName = null,Object? aggregationType = null,Object? periodStart = null,Object? periodEnd = null,Object? avgVoltage = null,Object? maxVoltage = null,Object? minVoltage = null,Object? avgCurrent = null,Object? maxCurrent = null,Object? minCurrent = null,Object? avgPower = null,Object? maxPower = null,Object? minPower = null,Object? totalEnergyConsumed = null,Object? readingCount = null,}) {
  return _then(_AggregatedReadingResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as int,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,aggregationType: null == aggregationType ? _self.aggregationType : aggregationType // ignore: cast_nullable_to_non_nullable
as AggregationType,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,avgVoltage: null == avgVoltage ? _self.avgVoltage : avgVoltage // ignore: cast_nullable_to_non_nullable
as double,maxVoltage: null == maxVoltage ? _self.maxVoltage : maxVoltage // ignore: cast_nullable_to_non_nullable
as double,minVoltage: null == minVoltage ? _self.minVoltage : minVoltage // ignore: cast_nullable_to_non_nullable
as double,avgCurrent: null == avgCurrent ? _self.avgCurrent : avgCurrent // ignore: cast_nullable_to_non_nullable
as double,maxCurrent: null == maxCurrent ? _self.maxCurrent : maxCurrent // ignore: cast_nullable_to_non_nullable
as double,minCurrent: null == minCurrent ? _self.minCurrent : minCurrent // ignore: cast_nullable_to_non_nullable
as double,avgPower: null == avgPower ? _self.avgPower : avgPower // ignore: cast_nullable_to_non_nullable
as double,maxPower: null == maxPower ? _self.maxPower : maxPower // ignore: cast_nullable_to_non_nullable
as double,minPower: null == minPower ? _self.minPower : minPower // ignore: cast_nullable_to_non_nullable
as double,totalEnergyConsumed: null == totalEnergyConsumed ? _self.totalEnergyConsumed : totalEnergyConsumed // ignore: cast_nullable_to_non_nullable
as double,readingCount: null == readingCount ? _self.readingCount : readingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AnalyticsResponse {

 List<AggregatedReadingResponse> get data; double get totalEnergyConsumed; double get avgPower; int get totalReadings;
/// Create a copy of AnalyticsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalyticsResponseCopyWith<AnalyticsResponse> get copyWith => _$AnalyticsResponseCopyWithImpl<AnalyticsResponse>(this as AnalyticsResponse, _$identity);

  /// Serializes this AnalyticsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalyticsResponse&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.totalEnergyConsumed, totalEnergyConsumed) || other.totalEnergyConsumed == totalEnergyConsumed)&&(identical(other.avgPower, avgPower) || other.avgPower == avgPower)&&(identical(other.totalReadings, totalReadings) || other.totalReadings == totalReadings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),totalEnergyConsumed,avgPower,totalReadings);

@override
String toString() {
  return 'AnalyticsResponse(data: $data, totalEnergyConsumed: $totalEnergyConsumed, avgPower: $avgPower, totalReadings: $totalReadings)';
}


}

/// @nodoc
abstract mixin class $AnalyticsResponseCopyWith<$Res>  {
  factory $AnalyticsResponseCopyWith(AnalyticsResponse value, $Res Function(AnalyticsResponse) _then) = _$AnalyticsResponseCopyWithImpl;
@useResult
$Res call({
 List<AggregatedReadingResponse> data, double totalEnergyConsumed, double avgPower, int totalReadings
});




}
/// @nodoc
class _$AnalyticsResponseCopyWithImpl<$Res>
    implements $AnalyticsResponseCopyWith<$Res> {
  _$AnalyticsResponseCopyWithImpl(this._self, this._then);

  final AnalyticsResponse _self;
  final $Res Function(AnalyticsResponse) _then;

/// Create a copy of AnalyticsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? totalEnergyConsumed = null,Object? avgPower = null,Object? totalReadings = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<AggregatedReadingResponse>,totalEnergyConsumed: null == totalEnergyConsumed ? _self.totalEnergyConsumed : totalEnergyConsumed // ignore: cast_nullable_to_non_nullable
as double,avgPower: null == avgPower ? _self.avgPower : avgPower // ignore: cast_nullable_to_non_nullable
as double,totalReadings: null == totalReadings ? _self.totalReadings : totalReadings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AnalyticsResponse].
extension AnalyticsResponsePatterns on AnalyticsResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnalyticsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnalyticsResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnalyticsResponse value)  $default,){
final _that = this;
switch (_that) {
case _AnalyticsResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnalyticsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AnalyticsResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AggregatedReadingResponse> data,  double totalEnergyConsumed,  double avgPower,  int totalReadings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnalyticsResponse() when $default != null:
return $default(_that.data,_that.totalEnergyConsumed,_that.avgPower,_that.totalReadings);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AggregatedReadingResponse> data,  double totalEnergyConsumed,  double avgPower,  int totalReadings)  $default,) {final _that = this;
switch (_that) {
case _AnalyticsResponse():
return $default(_that.data,_that.totalEnergyConsumed,_that.avgPower,_that.totalReadings);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AggregatedReadingResponse> data,  double totalEnergyConsumed,  double avgPower,  int totalReadings)?  $default,) {final _that = this;
switch (_that) {
case _AnalyticsResponse() when $default != null:
return $default(_that.data,_that.totalEnergyConsumed,_that.avgPower,_that.totalReadings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnalyticsResponse implements AnalyticsResponse {
  const _AnalyticsResponse({required final  List<AggregatedReadingResponse> data, required this.totalEnergyConsumed, required this.avgPower, required this.totalReadings}): _data = data;
  factory _AnalyticsResponse.fromJson(Map<String, dynamic> json) => _$AnalyticsResponseFromJson(json);

 final  List<AggregatedReadingResponse> _data;
@override List<AggregatedReadingResponse> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override final  double totalEnergyConsumed;
@override final  double avgPower;
@override final  int totalReadings;

/// Create a copy of AnalyticsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnalyticsResponseCopyWith<_AnalyticsResponse> get copyWith => __$AnalyticsResponseCopyWithImpl<_AnalyticsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnalyticsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnalyticsResponse&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.totalEnergyConsumed, totalEnergyConsumed) || other.totalEnergyConsumed == totalEnergyConsumed)&&(identical(other.avgPower, avgPower) || other.avgPower == avgPower)&&(identical(other.totalReadings, totalReadings) || other.totalReadings == totalReadings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),totalEnergyConsumed,avgPower,totalReadings);

@override
String toString() {
  return 'AnalyticsResponse(data: $data, totalEnergyConsumed: $totalEnergyConsumed, avgPower: $avgPower, totalReadings: $totalReadings)';
}


}

/// @nodoc
abstract mixin class _$AnalyticsResponseCopyWith<$Res> implements $AnalyticsResponseCopyWith<$Res> {
  factory _$AnalyticsResponseCopyWith(_AnalyticsResponse value, $Res Function(_AnalyticsResponse) _then) = __$AnalyticsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<AggregatedReadingResponse> data, double totalEnergyConsumed, double avgPower, int totalReadings
});




}
/// @nodoc
class __$AnalyticsResponseCopyWithImpl<$Res>
    implements _$AnalyticsResponseCopyWith<$Res> {
  __$AnalyticsResponseCopyWithImpl(this._self, this._then);

  final _AnalyticsResponse _self;
  final $Res Function(_AnalyticsResponse) _then;

/// Create a copy of AnalyticsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? totalEnergyConsumed = null,Object? avgPower = null,Object? totalReadings = null,}) {
  return _then(_AnalyticsResponse(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<AggregatedReadingResponse>,totalEnergyConsumed: null == totalEnergyConsumed ? _self.totalEnergyConsumed : totalEnergyConsumed // ignore: cast_nullable_to_non_nullable
as double,avgPower: null == avgPower ? _self.avgPower : avgPower // ignore: cast_nullable_to_non_nullable
as double,totalReadings: null == totalReadings ? _self.totalReadings : totalReadings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ApiResponse<T> {

 bool get success; String get message; T? get data;
/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiResponseCopyWith<T, ApiResponse<T>> get copyWith => _$ApiResponseCopyWithImpl<T, ApiResponse<T>>(this as ApiResponse<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiResponse<T>&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,success,message,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ApiResponse<$T>(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $ApiResponseCopyWith<T,$Res>  {
  factory $ApiResponseCopyWith(ApiResponse<T> value, $Res Function(ApiResponse<T>) _then) = _$ApiResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, T? data
});




}
/// @nodoc
class _$ApiResponseCopyWithImpl<T,$Res>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._self, this._then);

  final ApiResponse<T> _self;
  final $Res Function(ApiResponse<T>) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiResponse].
extension ApiResponsePatterns<T> on ApiResponse<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiResponse<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiResponse<T> value)  $default,){
final _that = this;
switch (_that) {
case _ApiResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiResponse<T> value)?  $default,){
final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  T? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  T? data)  $default,) {final _that = this;
switch (_that) {
case _ApiResponse():
return $default(_that.success,_that.message,_that.data);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  T? data)?  $default,) {final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _ApiResponse<T> implements ApiResponse<T> {
  const _ApiResponse({required this.success, required this.message, this.data});
  

@override final  bool success;
@override final  String message;
@override final  T? data;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiResponseCopyWith<T, _ApiResponse<T>> get copyWith => __$ApiResponseCopyWithImpl<T, _ApiResponse<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiResponse<T>&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,success,message,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ApiResponse<$T>(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ApiResponseCopyWith<T,$Res> implements $ApiResponseCopyWith<T, $Res> {
  factory _$ApiResponseCopyWith(_ApiResponse<T> value, $Res Function(_ApiResponse<T>) _then) = __$ApiResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, T? data
});




}
/// @nodoc
class __$ApiResponseCopyWithImpl<T,$Res>
    implements _$ApiResponseCopyWith<T, $Res> {
  __$ApiResponseCopyWithImpl(this._self, this._then);

  final _ApiResponse<T> _self;
  final $Res Function(_ApiResponse<T>) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = freezed,}) {
  return _then(_ApiResponse<T>(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}


}


/// @nodoc
mixin _$DeviceResponse {

 int get id; String get deviceName; String get esp32Id; String get deviceToken; DeviceType get deviceType; String? get description; int get userId; String get userEmail; bool get ssrEnabled; bool get active; bool get online; DateTime? get lastSeenAt; double get voltageCalibration; double get currentCalibration; String? get location; String? get installationNotes; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of DeviceResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceResponseCopyWith<DeviceResponse> get copyWith => _$DeviceResponseCopyWithImpl<DeviceResponse>(this as DeviceResponse, _$identity);

  /// Serializes this DeviceResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.esp32Id, esp32Id) || other.esp32Id == esp32Id)&&(identical(other.deviceToken, deviceToken) || other.deviceToken == deviceToken)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&(identical(other.description, description) || other.description == description)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.ssrEnabled, ssrEnabled) || other.ssrEnabled == ssrEnabled)&&(identical(other.active, active) || other.active == active)&&(identical(other.online, online) || other.online == online)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.voltageCalibration, voltageCalibration) || other.voltageCalibration == voltageCalibration)&&(identical(other.currentCalibration, currentCalibration) || other.currentCalibration == currentCalibration)&&(identical(other.location, location) || other.location == location)&&(identical(other.installationNotes, installationNotes) || other.installationNotes == installationNotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deviceName,esp32Id,deviceToken,deviceType,description,userId,userEmail,ssrEnabled,active,online,lastSeenAt,voltageCalibration,currentCalibration,location,installationNotes,createdAt,updatedAt);

@override
String toString() {
  return 'DeviceResponse(id: $id, deviceName: $deviceName, esp32Id: $esp32Id, deviceToken: $deviceToken, deviceType: $deviceType, description: $description, userId: $userId, userEmail: $userEmail, ssrEnabled: $ssrEnabled, active: $active, online: $online, lastSeenAt: $lastSeenAt, voltageCalibration: $voltageCalibration, currentCalibration: $currentCalibration, location: $location, installationNotes: $installationNotes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DeviceResponseCopyWith<$Res>  {
  factory $DeviceResponseCopyWith(DeviceResponse value, $Res Function(DeviceResponse) _then) = _$DeviceResponseCopyWithImpl;
@useResult
$Res call({
 int id, String deviceName, String esp32Id, String deviceToken, DeviceType deviceType, String? description, int userId, String userEmail, bool ssrEnabled, bool active, bool online, DateTime? lastSeenAt, double voltageCalibration, double currentCalibration, String? location, String? installationNotes, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$DeviceResponseCopyWithImpl<$Res>
    implements $DeviceResponseCopyWith<$Res> {
  _$DeviceResponseCopyWithImpl(this._self, this._then);

  final DeviceResponse _self;
  final $Res Function(DeviceResponse) _then;

/// Create a copy of DeviceResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? deviceName = null,Object? esp32Id = null,Object? deviceToken = null,Object? deviceType = null,Object? description = freezed,Object? userId = null,Object? userEmail = null,Object? ssrEnabled = null,Object? active = null,Object? online = null,Object? lastSeenAt = freezed,Object? voltageCalibration = null,Object? currentCalibration = null,Object? location = freezed,Object? installationNotes = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,esp32Id: null == esp32Id ? _self.esp32Id : esp32Id // ignore: cast_nullable_to_non_nullable
as String,deviceToken: null == deviceToken ? _self.deviceToken : deviceToken // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as DeviceType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userEmail: null == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String,ssrEnabled: null == ssrEnabled ? _self.ssrEnabled : ssrEnabled // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,voltageCalibration: null == voltageCalibration ? _self.voltageCalibration : voltageCalibration // ignore: cast_nullable_to_non_nullable
as double,currentCalibration: null == currentCalibration ? _self.currentCalibration : currentCalibration // ignore: cast_nullable_to_non_nullable
as double,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,installationNotes: freezed == installationNotes ? _self.installationNotes : installationNotes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceResponse].
extension DeviceResponsePatterns on DeviceResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceResponse value)  $default,){
final _that = this;
switch (_that) {
case _DeviceResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String deviceName,  String esp32Id,  String deviceToken,  DeviceType deviceType,  String? description,  int userId,  String userEmail,  bool ssrEnabled,  bool active,  bool online,  DateTime? lastSeenAt,  double voltageCalibration,  double currentCalibration,  String? location,  String? installationNotes,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceResponse() when $default != null:
return $default(_that.id,_that.deviceName,_that.esp32Id,_that.deviceToken,_that.deviceType,_that.description,_that.userId,_that.userEmail,_that.ssrEnabled,_that.active,_that.online,_that.lastSeenAt,_that.voltageCalibration,_that.currentCalibration,_that.location,_that.installationNotes,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String deviceName,  String esp32Id,  String deviceToken,  DeviceType deviceType,  String? description,  int userId,  String userEmail,  bool ssrEnabled,  bool active,  bool online,  DateTime? lastSeenAt,  double voltageCalibration,  double currentCalibration,  String? location,  String? installationNotes,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DeviceResponse():
return $default(_that.id,_that.deviceName,_that.esp32Id,_that.deviceToken,_that.deviceType,_that.description,_that.userId,_that.userEmail,_that.ssrEnabled,_that.active,_that.online,_that.lastSeenAt,_that.voltageCalibration,_that.currentCalibration,_that.location,_that.installationNotes,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String deviceName,  String esp32Id,  String deviceToken,  DeviceType deviceType,  String? description,  int userId,  String userEmail,  bool ssrEnabled,  bool active,  bool online,  DateTime? lastSeenAt,  double voltageCalibration,  double currentCalibration,  String? location,  String? installationNotes,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DeviceResponse() when $default != null:
return $default(_that.id,_that.deviceName,_that.esp32Id,_that.deviceToken,_that.deviceType,_that.description,_that.userId,_that.userEmail,_that.ssrEnabled,_that.active,_that.online,_that.lastSeenAt,_that.voltageCalibration,_that.currentCalibration,_that.location,_that.installationNotes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceResponse implements DeviceResponse {
  const _DeviceResponse({required this.id, required this.deviceName, required this.esp32Id, required this.deviceToken, required this.deviceType, this.description, required this.userId, required this.userEmail, required this.ssrEnabled, required this.active, required this.online, this.lastSeenAt, required this.voltageCalibration, required this.currentCalibration, this.location, this.installationNotes, required this.createdAt, required this.updatedAt});
  factory _DeviceResponse.fromJson(Map<String, dynamic> json) => _$DeviceResponseFromJson(json);

@override final  int id;
@override final  String deviceName;
@override final  String esp32Id;
@override final  String deviceToken;
@override final  DeviceType deviceType;
@override final  String? description;
@override final  int userId;
@override final  String userEmail;
@override final  bool ssrEnabled;
@override final  bool active;
@override final  bool online;
@override final  DateTime? lastSeenAt;
@override final  double voltageCalibration;
@override final  double currentCalibration;
@override final  String? location;
@override final  String? installationNotes;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of DeviceResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceResponseCopyWith<_DeviceResponse> get copyWith => __$DeviceResponseCopyWithImpl<_DeviceResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.esp32Id, esp32Id) || other.esp32Id == esp32Id)&&(identical(other.deviceToken, deviceToken) || other.deviceToken == deviceToken)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&(identical(other.description, description) || other.description == description)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.ssrEnabled, ssrEnabled) || other.ssrEnabled == ssrEnabled)&&(identical(other.active, active) || other.active == active)&&(identical(other.online, online) || other.online == online)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.voltageCalibration, voltageCalibration) || other.voltageCalibration == voltageCalibration)&&(identical(other.currentCalibration, currentCalibration) || other.currentCalibration == currentCalibration)&&(identical(other.location, location) || other.location == location)&&(identical(other.installationNotes, installationNotes) || other.installationNotes == installationNotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deviceName,esp32Id,deviceToken,deviceType,description,userId,userEmail,ssrEnabled,active,online,lastSeenAt,voltageCalibration,currentCalibration,location,installationNotes,createdAt,updatedAt);

@override
String toString() {
  return 'DeviceResponse(id: $id, deviceName: $deviceName, esp32Id: $esp32Id, deviceToken: $deviceToken, deviceType: $deviceType, description: $description, userId: $userId, userEmail: $userEmail, ssrEnabled: $ssrEnabled, active: $active, online: $online, lastSeenAt: $lastSeenAt, voltageCalibration: $voltageCalibration, currentCalibration: $currentCalibration, location: $location, installationNotes: $installationNotes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DeviceResponseCopyWith<$Res> implements $DeviceResponseCopyWith<$Res> {
  factory _$DeviceResponseCopyWith(_DeviceResponse value, $Res Function(_DeviceResponse) _then) = __$DeviceResponseCopyWithImpl;
@override @useResult
$Res call({
 int id, String deviceName, String esp32Id, String deviceToken, DeviceType deviceType, String? description, int userId, String userEmail, bool ssrEnabled, bool active, bool online, DateTime? lastSeenAt, double voltageCalibration, double currentCalibration, String? location, String? installationNotes, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$DeviceResponseCopyWithImpl<$Res>
    implements _$DeviceResponseCopyWith<$Res> {
  __$DeviceResponseCopyWithImpl(this._self, this._then);

  final _DeviceResponse _self;
  final $Res Function(_DeviceResponse) _then;

/// Create a copy of DeviceResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? deviceName = null,Object? esp32Id = null,Object? deviceToken = null,Object? deviceType = null,Object? description = freezed,Object? userId = null,Object? userEmail = null,Object? ssrEnabled = null,Object? active = null,Object? online = null,Object? lastSeenAt = freezed,Object? voltageCalibration = null,Object? currentCalibration = null,Object? location = freezed,Object? installationNotes = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_DeviceResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,esp32Id: null == esp32Id ? _self.esp32Id : esp32Id // ignore: cast_nullable_to_non_nullable
as String,deviceToken: null == deviceToken ? _self.deviceToken : deviceToken // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as DeviceType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userEmail: null == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String,ssrEnabled: null == ssrEnabled ? _self.ssrEnabled : ssrEnabled // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,voltageCalibration: null == voltageCalibration ? _self.voltageCalibration : voltageCalibration // ignore: cast_nullable_to_non_nullable
as double,currentCalibration: null == currentCalibration ? _self.currentCalibration : currentCalibration // ignore: cast_nullable_to_non_nullable
as double,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,installationNotes: freezed == installationNotes ? _self.installationNotes : installationNotes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CachedAnalyticsData {

 AggregationType get type; DateTime get cachedAt; AnalyticsResponse get data;
/// Create a copy of CachedAnalyticsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CachedAnalyticsDataCopyWith<CachedAnalyticsData> get copyWith => _$CachedAnalyticsDataCopyWithImpl<CachedAnalyticsData>(this as CachedAnalyticsData, _$identity);

  /// Serializes this CachedAnalyticsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CachedAnalyticsData&&(identical(other.type, type) || other.type == type)&&(identical(other.cachedAt, cachedAt) || other.cachedAt == cachedAt)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,cachedAt,data);

@override
String toString() {
  return 'CachedAnalyticsData(type: $type, cachedAt: $cachedAt, data: $data)';
}


}

/// @nodoc
abstract mixin class $CachedAnalyticsDataCopyWith<$Res>  {
  factory $CachedAnalyticsDataCopyWith(CachedAnalyticsData value, $Res Function(CachedAnalyticsData) _then) = _$CachedAnalyticsDataCopyWithImpl;
@useResult
$Res call({
 AggregationType type, DateTime cachedAt, AnalyticsResponse data
});


$AnalyticsResponseCopyWith<$Res> get data;

}
/// @nodoc
class _$CachedAnalyticsDataCopyWithImpl<$Res>
    implements $CachedAnalyticsDataCopyWith<$Res> {
  _$CachedAnalyticsDataCopyWithImpl(this._self, this._then);

  final CachedAnalyticsData _self;
  final $Res Function(CachedAnalyticsData) _then;

/// Create a copy of CachedAnalyticsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? cachedAt = null,Object? data = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AggregationType,cachedAt: null == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as DateTime,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AnalyticsResponse,
  ));
}
/// Create a copy of CachedAnalyticsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnalyticsResponseCopyWith<$Res> get data {
  
  return $AnalyticsResponseCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CachedAnalyticsData].
extension CachedAnalyticsDataPatterns on CachedAnalyticsData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CachedAnalyticsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CachedAnalyticsData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CachedAnalyticsData value)  $default,){
final _that = this;
switch (_that) {
case _CachedAnalyticsData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CachedAnalyticsData value)?  $default,){
final _that = this;
switch (_that) {
case _CachedAnalyticsData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AggregationType type,  DateTime cachedAt,  AnalyticsResponse data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CachedAnalyticsData() when $default != null:
return $default(_that.type,_that.cachedAt,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AggregationType type,  DateTime cachedAt,  AnalyticsResponse data)  $default,) {final _that = this;
switch (_that) {
case _CachedAnalyticsData():
return $default(_that.type,_that.cachedAt,_that.data);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AggregationType type,  DateTime cachedAt,  AnalyticsResponse data)?  $default,) {final _that = this;
switch (_that) {
case _CachedAnalyticsData() when $default != null:
return $default(_that.type,_that.cachedAt,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CachedAnalyticsData implements CachedAnalyticsData {
  const _CachedAnalyticsData({required this.type, required this.cachedAt, required this.data});
  factory _CachedAnalyticsData.fromJson(Map<String, dynamic> json) => _$CachedAnalyticsDataFromJson(json);

@override final  AggregationType type;
@override final  DateTime cachedAt;
@override final  AnalyticsResponse data;

/// Create a copy of CachedAnalyticsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CachedAnalyticsDataCopyWith<_CachedAnalyticsData> get copyWith => __$CachedAnalyticsDataCopyWithImpl<_CachedAnalyticsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CachedAnalyticsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CachedAnalyticsData&&(identical(other.type, type) || other.type == type)&&(identical(other.cachedAt, cachedAt) || other.cachedAt == cachedAt)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,cachedAt,data);

@override
String toString() {
  return 'CachedAnalyticsData(type: $type, cachedAt: $cachedAt, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CachedAnalyticsDataCopyWith<$Res> implements $CachedAnalyticsDataCopyWith<$Res> {
  factory _$CachedAnalyticsDataCopyWith(_CachedAnalyticsData value, $Res Function(_CachedAnalyticsData) _then) = __$CachedAnalyticsDataCopyWithImpl;
@override @useResult
$Res call({
 AggregationType type, DateTime cachedAt, AnalyticsResponse data
});


@override $AnalyticsResponseCopyWith<$Res> get data;

}
/// @nodoc
class __$CachedAnalyticsDataCopyWithImpl<$Res>
    implements _$CachedAnalyticsDataCopyWith<$Res> {
  __$CachedAnalyticsDataCopyWithImpl(this._self, this._then);

  final _CachedAnalyticsData _self;
  final $Res Function(_CachedAnalyticsData) _then;

/// Create a copy of CachedAnalyticsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? cachedAt = null,Object? data = null,}) {
  return _then(_CachedAnalyticsData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AggregationType,cachedAt: null == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as DateTime,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AnalyticsResponse,
  ));
}

/// Create a copy of CachedAnalyticsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnalyticsResponseCopyWith<$Res> get data {
  
  return $AnalyticsResponseCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
