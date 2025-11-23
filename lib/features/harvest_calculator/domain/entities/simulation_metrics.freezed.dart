// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simulation_metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SimulationMetrics _$SimulationMetricsFromJson(Map<String, dynamic> json) {
  return _SimulationMetrics.fromJson(json);
}

/// @nodoc
mixin _$SimulationMetrics {
  /// Peak biomass reached (kg)
  double get peakBiomass => throw _privateConstructorUsedError;

  /// Day when peak biomass was reached
  int get peakBiomassDay => throw _privateConstructorUsedError;

  /// Average daily feed consumption (kg/day)
  double get averageDailyFeedConsumption => throw _privateConstructorUsedError;

  /// Feed efficiency (revenue per kg feed)
  double get feedEfficiency => throw _privateConstructorUsedError;

  /// Biomass growth rate (kg/day)
  double get biomassGrowthRate => throw _privateConstructorUsedError;

  /// Days to reach 50% of target biomass
  int get daysToHalfBiomass => throw _privateConstructorUsedError;

  /// Days to reach 80% of target biomass
  int get daysToFourFifthBiomass => throw _privateConstructorUsedError;

  /// Serializes this SimulationMetrics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimulationMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimulationMetricsCopyWith<SimulationMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulationMetricsCopyWith<$Res> {
  factory $SimulationMetricsCopyWith(
    SimulationMetrics value,
    $Res Function(SimulationMetrics) then,
  ) = _$SimulationMetricsCopyWithImpl<$Res, SimulationMetrics>;
  @useResult
  $Res call({
    double peakBiomass,
    int peakBiomassDay,
    double averageDailyFeedConsumption,
    double feedEfficiency,
    double biomassGrowthRate,
    int daysToHalfBiomass,
    int daysToFourFifthBiomass,
  });
}

/// @nodoc
class _$SimulationMetricsCopyWithImpl<$Res, $Val extends SimulationMetrics>
    implements $SimulationMetricsCopyWith<$Res> {
  _$SimulationMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimulationMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? peakBiomass = null,
    Object? peakBiomassDay = null,
    Object? averageDailyFeedConsumption = null,
    Object? feedEfficiency = null,
    Object? biomassGrowthRate = null,
    Object? daysToHalfBiomass = null,
    Object? daysToFourFifthBiomass = null,
  }) {
    return _then(
      _value.copyWith(
            peakBiomass: null == peakBiomass
                ? _value.peakBiomass
                : peakBiomass // ignore: cast_nullable_to_non_nullable
                      as double,
            peakBiomassDay: null == peakBiomassDay
                ? _value.peakBiomassDay
                : peakBiomassDay // ignore: cast_nullable_to_non_nullable
                      as int,
            averageDailyFeedConsumption: null == averageDailyFeedConsumption
                ? _value.averageDailyFeedConsumption
                : averageDailyFeedConsumption // ignore: cast_nullable_to_non_nullable
                      as double,
            feedEfficiency: null == feedEfficiency
                ? _value.feedEfficiency
                : feedEfficiency // ignore: cast_nullable_to_non_nullable
                      as double,
            biomassGrowthRate: null == biomassGrowthRate
                ? _value.biomassGrowthRate
                : biomassGrowthRate // ignore: cast_nullable_to_non_nullable
                      as double,
            daysToHalfBiomass: null == daysToHalfBiomass
                ? _value.daysToHalfBiomass
                : daysToHalfBiomass // ignore: cast_nullable_to_non_nullable
                      as int,
            daysToFourFifthBiomass: null == daysToFourFifthBiomass
                ? _value.daysToFourFifthBiomass
                : daysToFourFifthBiomass // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SimulationMetricsImplCopyWith<$Res>
    implements $SimulationMetricsCopyWith<$Res> {
  factory _$$SimulationMetricsImplCopyWith(
    _$SimulationMetricsImpl value,
    $Res Function(_$SimulationMetricsImpl) then,
  ) = __$$SimulationMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double peakBiomass,
    int peakBiomassDay,
    double averageDailyFeedConsumption,
    double feedEfficiency,
    double biomassGrowthRate,
    int daysToHalfBiomass,
    int daysToFourFifthBiomass,
  });
}

/// @nodoc
class __$$SimulationMetricsImplCopyWithImpl<$Res>
    extends _$SimulationMetricsCopyWithImpl<$Res, _$SimulationMetricsImpl>
    implements _$$SimulationMetricsImplCopyWith<$Res> {
  __$$SimulationMetricsImplCopyWithImpl(
    _$SimulationMetricsImpl _value,
    $Res Function(_$SimulationMetricsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? peakBiomass = null,
    Object? peakBiomassDay = null,
    Object? averageDailyFeedConsumption = null,
    Object? feedEfficiency = null,
    Object? biomassGrowthRate = null,
    Object? daysToHalfBiomass = null,
    Object? daysToFourFifthBiomass = null,
  }) {
    return _then(
      _$SimulationMetricsImpl(
        peakBiomass: null == peakBiomass
            ? _value.peakBiomass
            : peakBiomass // ignore: cast_nullable_to_non_nullable
                  as double,
        peakBiomassDay: null == peakBiomassDay
            ? _value.peakBiomassDay
            : peakBiomassDay // ignore: cast_nullable_to_non_nullable
                  as int,
        averageDailyFeedConsumption: null == averageDailyFeedConsumption
            ? _value.averageDailyFeedConsumption
            : averageDailyFeedConsumption // ignore: cast_nullable_to_non_nullable
                  as double,
        feedEfficiency: null == feedEfficiency
            ? _value.feedEfficiency
            : feedEfficiency // ignore: cast_nullable_to_non_nullable
                  as double,
        biomassGrowthRate: null == biomassGrowthRate
            ? _value.biomassGrowthRate
            : biomassGrowthRate // ignore: cast_nullable_to_non_nullable
                  as double,
        daysToHalfBiomass: null == daysToHalfBiomass
            ? _value.daysToHalfBiomass
            : daysToHalfBiomass // ignore: cast_nullable_to_non_nullable
                  as int,
        daysToFourFifthBiomass: null == daysToFourFifthBiomass
            ? _value.daysToFourFifthBiomass
            : daysToFourFifthBiomass // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SimulationMetricsImpl implements _SimulationMetrics {
  const _$SimulationMetricsImpl({
    required this.peakBiomass,
    required this.peakBiomassDay,
    required this.averageDailyFeedConsumption,
    required this.feedEfficiency,
    required this.biomassGrowthRate,
    required this.daysToHalfBiomass,
    required this.daysToFourFifthBiomass,
  });

  factory _$SimulationMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimulationMetricsImplFromJson(json);

  /// Peak biomass reached (kg)
  @override
  final double peakBiomass;

  /// Day when peak biomass was reached
  @override
  final int peakBiomassDay;

  /// Average daily feed consumption (kg/day)
  @override
  final double averageDailyFeedConsumption;

  /// Feed efficiency (revenue per kg feed)
  @override
  final double feedEfficiency;

  /// Biomass growth rate (kg/day)
  @override
  final double biomassGrowthRate;

  /// Days to reach 50% of target biomass
  @override
  final int daysToHalfBiomass;

  /// Days to reach 80% of target biomass
  @override
  final int daysToFourFifthBiomass;

  @override
  String toString() {
    return 'SimulationMetrics(peakBiomass: $peakBiomass, peakBiomassDay: $peakBiomassDay, averageDailyFeedConsumption: $averageDailyFeedConsumption, feedEfficiency: $feedEfficiency, biomassGrowthRate: $biomassGrowthRate, daysToHalfBiomass: $daysToHalfBiomass, daysToFourFifthBiomass: $daysToFourFifthBiomass)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationMetricsImpl &&
            (identical(other.peakBiomass, peakBiomass) ||
                other.peakBiomass == peakBiomass) &&
            (identical(other.peakBiomassDay, peakBiomassDay) ||
                other.peakBiomassDay == peakBiomassDay) &&
            (identical(
                  other.averageDailyFeedConsumption,
                  averageDailyFeedConsumption,
                ) ||
                other.averageDailyFeedConsumption ==
                    averageDailyFeedConsumption) &&
            (identical(other.feedEfficiency, feedEfficiency) ||
                other.feedEfficiency == feedEfficiency) &&
            (identical(other.biomassGrowthRate, biomassGrowthRate) ||
                other.biomassGrowthRate == biomassGrowthRate) &&
            (identical(other.daysToHalfBiomass, daysToHalfBiomass) ||
                other.daysToHalfBiomass == daysToHalfBiomass) &&
            (identical(other.daysToFourFifthBiomass, daysToFourFifthBiomass) ||
                other.daysToFourFifthBiomass == daysToFourFifthBiomass));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    peakBiomass,
    peakBiomassDay,
    averageDailyFeedConsumption,
    feedEfficiency,
    biomassGrowthRate,
    daysToHalfBiomass,
    daysToFourFifthBiomass,
  );

  /// Create a copy of SimulationMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationMetricsImplCopyWith<_$SimulationMetricsImpl> get copyWith =>
      __$$SimulationMetricsImplCopyWithImpl<_$SimulationMetricsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SimulationMetricsImplToJson(this);
  }
}

abstract class _SimulationMetrics implements SimulationMetrics {
  const factory _SimulationMetrics({
    required final double peakBiomass,
    required final int peakBiomassDay,
    required final double averageDailyFeedConsumption,
    required final double feedEfficiency,
    required final double biomassGrowthRate,
    required final int daysToHalfBiomass,
    required final int daysToFourFifthBiomass,
  }) = _$SimulationMetricsImpl;

  factory _SimulationMetrics.fromJson(Map<String, dynamic> json) =
      _$SimulationMetricsImpl.fromJson;

  /// Peak biomass reached (kg)
  @override
  double get peakBiomass;

  /// Day when peak biomass was reached
  @override
  int get peakBiomassDay;

  /// Average daily feed consumption (kg/day)
  @override
  double get averageDailyFeedConsumption;

  /// Feed efficiency (revenue per kg feed)
  @override
  double get feedEfficiency;

  /// Biomass growth rate (kg/day)
  @override
  double get biomassGrowthRate;

  /// Days to reach 50% of target biomass
  @override
  int get daysToHalfBiomass;

  /// Days to reach 80% of target biomass
  @override
  int get daysToFourFifthBiomass;

  /// Create a copy of SimulationMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationMetricsImplCopyWith<_$SimulationMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
