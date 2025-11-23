// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simulation_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SimulationSummary _$SimulationSummaryFromJson(Map<String, dynamic> json) {
  return _SimulationSummary.fromJson(json);
}

/// @nodoc
mixin _$SimulationSummary {
  /// Final biomass at target DOC (kg)
  double get finalBiomass => throw _privateConstructorUsedError;

  /// Total feed consumption (kg)
  double get totalFeedConsumption => throw _privateConstructorUsedError;

  /// Total revenue from all harvests (Rp)
  double get totalRevenue => throw _privateConstructorUsedError;

  /// Total feed cost (Rp)
  double get totalFeedCost => throw _privateConstructorUsedError;

  /// Net profit (Rp)
  double get netProfit => throw _privateConstructorUsedError;

  /// Final survival rate (%)
  double get finalSurvivalRate => throw _privateConstructorUsedError;

  /// Average FCR throughout simulation
  double get averageFCR => throw _privateConstructorUsedError;

  /// Total harvest weight (kg)
  double get totalHarvestWeight => throw _privateConstructorUsedError;

  /// Simulation duration (days)
  int get simulationDays => throw _privateConstructorUsedError;

  /// Serializes this SimulationSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimulationSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimulationSummaryCopyWith<SimulationSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulationSummaryCopyWith<$Res> {
  factory $SimulationSummaryCopyWith(
    SimulationSummary value,
    $Res Function(SimulationSummary) then,
  ) = _$SimulationSummaryCopyWithImpl<$Res, SimulationSummary>;
  @useResult
  $Res call({
    double finalBiomass,
    double totalFeedConsumption,
    double totalRevenue,
    double totalFeedCost,
    double netProfit,
    double finalSurvivalRate,
    double averageFCR,
    double totalHarvestWeight,
    int simulationDays,
  });
}

/// @nodoc
class _$SimulationSummaryCopyWithImpl<$Res, $Val extends SimulationSummary>
    implements $SimulationSummaryCopyWith<$Res> {
  _$SimulationSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimulationSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? finalBiomass = null,
    Object? totalFeedConsumption = null,
    Object? totalRevenue = null,
    Object? totalFeedCost = null,
    Object? netProfit = null,
    Object? finalSurvivalRate = null,
    Object? averageFCR = null,
    Object? totalHarvestWeight = null,
    Object? simulationDays = null,
  }) {
    return _then(
      _value.copyWith(
            finalBiomass: null == finalBiomass
                ? _value.finalBiomass
                : finalBiomass // ignore: cast_nullable_to_non_nullable
                      as double,
            totalFeedConsumption: null == totalFeedConsumption
                ? _value.totalFeedConsumption
                : totalFeedConsumption // ignore: cast_nullable_to_non_nullable
                      as double,
            totalRevenue: null == totalRevenue
                ? _value.totalRevenue
                : totalRevenue // ignore: cast_nullable_to_non_nullable
                      as double,
            totalFeedCost: null == totalFeedCost
                ? _value.totalFeedCost
                : totalFeedCost // ignore: cast_nullable_to_non_nullable
                      as double,
            netProfit: null == netProfit
                ? _value.netProfit
                : netProfit // ignore: cast_nullable_to_non_nullable
                      as double,
            finalSurvivalRate: null == finalSurvivalRate
                ? _value.finalSurvivalRate
                : finalSurvivalRate // ignore: cast_nullable_to_non_nullable
                      as double,
            averageFCR: null == averageFCR
                ? _value.averageFCR
                : averageFCR // ignore: cast_nullable_to_non_nullable
                      as double,
            totalHarvestWeight: null == totalHarvestWeight
                ? _value.totalHarvestWeight
                : totalHarvestWeight // ignore: cast_nullable_to_non_nullable
                      as double,
            simulationDays: null == simulationDays
                ? _value.simulationDays
                : simulationDays // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SimulationSummaryImplCopyWith<$Res>
    implements $SimulationSummaryCopyWith<$Res> {
  factory _$$SimulationSummaryImplCopyWith(
    _$SimulationSummaryImpl value,
    $Res Function(_$SimulationSummaryImpl) then,
  ) = __$$SimulationSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double finalBiomass,
    double totalFeedConsumption,
    double totalRevenue,
    double totalFeedCost,
    double netProfit,
    double finalSurvivalRate,
    double averageFCR,
    double totalHarvestWeight,
    int simulationDays,
  });
}

/// @nodoc
class __$$SimulationSummaryImplCopyWithImpl<$Res>
    extends _$SimulationSummaryCopyWithImpl<$Res, _$SimulationSummaryImpl>
    implements _$$SimulationSummaryImplCopyWith<$Res> {
  __$$SimulationSummaryImplCopyWithImpl(
    _$SimulationSummaryImpl _value,
    $Res Function(_$SimulationSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? finalBiomass = null,
    Object? totalFeedConsumption = null,
    Object? totalRevenue = null,
    Object? totalFeedCost = null,
    Object? netProfit = null,
    Object? finalSurvivalRate = null,
    Object? averageFCR = null,
    Object? totalHarvestWeight = null,
    Object? simulationDays = null,
  }) {
    return _then(
      _$SimulationSummaryImpl(
        finalBiomass: null == finalBiomass
            ? _value.finalBiomass
            : finalBiomass // ignore: cast_nullable_to_non_nullable
                  as double,
        totalFeedConsumption: null == totalFeedConsumption
            ? _value.totalFeedConsumption
            : totalFeedConsumption // ignore: cast_nullable_to_non_nullable
                  as double,
        totalRevenue: null == totalRevenue
            ? _value.totalRevenue
            : totalRevenue // ignore: cast_nullable_to_non_nullable
                  as double,
        totalFeedCost: null == totalFeedCost
            ? _value.totalFeedCost
            : totalFeedCost // ignore: cast_nullable_to_non_nullable
                  as double,
        netProfit: null == netProfit
            ? _value.netProfit
            : netProfit // ignore: cast_nullable_to_non_nullable
                  as double,
        finalSurvivalRate: null == finalSurvivalRate
            ? _value.finalSurvivalRate
            : finalSurvivalRate // ignore: cast_nullable_to_non_nullable
                  as double,
        averageFCR: null == averageFCR
            ? _value.averageFCR
            : averageFCR // ignore: cast_nullable_to_non_nullable
                  as double,
        totalHarvestWeight: null == totalHarvestWeight
            ? _value.totalHarvestWeight
            : totalHarvestWeight // ignore: cast_nullable_to_non_nullable
                  as double,
        simulationDays: null == simulationDays
            ? _value.simulationDays
            : simulationDays // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SimulationSummaryImpl implements _SimulationSummary {
  const _$SimulationSummaryImpl({
    required this.finalBiomass,
    required this.totalFeedConsumption,
    required this.totalRevenue,
    required this.totalFeedCost,
    required this.netProfit,
    required this.finalSurvivalRate,
    required this.averageFCR,
    required this.totalHarvestWeight,
    required this.simulationDays,
  });

  factory _$SimulationSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimulationSummaryImplFromJson(json);

  /// Final biomass at target DOC (kg)
  @override
  final double finalBiomass;

  /// Total feed consumption (kg)
  @override
  final double totalFeedConsumption;

  /// Total revenue from all harvests (Rp)
  @override
  final double totalRevenue;

  /// Total feed cost (Rp)
  @override
  final double totalFeedCost;

  /// Net profit (Rp)
  @override
  final double netProfit;

  /// Final survival rate (%)
  @override
  final double finalSurvivalRate;

  /// Average FCR throughout simulation
  @override
  final double averageFCR;

  /// Total harvest weight (kg)
  @override
  final double totalHarvestWeight;

  /// Simulation duration (days)
  @override
  final int simulationDays;

  @override
  String toString() {
    return 'SimulationSummary(finalBiomass: $finalBiomass, totalFeedConsumption: $totalFeedConsumption, totalRevenue: $totalRevenue, totalFeedCost: $totalFeedCost, netProfit: $netProfit, finalSurvivalRate: $finalSurvivalRate, averageFCR: $averageFCR, totalHarvestWeight: $totalHarvestWeight, simulationDays: $simulationDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationSummaryImpl &&
            (identical(other.finalBiomass, finalBiomass) ||
                other.finalBiomass == finalBiomass) &&
            (identical(other.totalFeedConsumption, totalFeedConsumption) ||
                other.totalFeedConsumption == totalFeedConsumption) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.totalFeedCost, totalFeedCost) ||
                other.totalFeedCost == totalFeedCost) &&
            (identical(other.netProfit, netProfit) ||
                other.netProfit == netProfit) &&
            (identical(other.finalSurvivalRate, finalSurvivalRate) ||
                other.finalSurvivalRate == finalSurvivalRate) &&
            (identical(other.averageFCR, averageFCR) ||
                other.averageFCR == averageFCR) &&
            (identical(other.totalHarvestWeight, totalHarvestWeight) ||
                other.totalHarvestWeight == totalHarvestWeight) &&
            (identical(other.simulationDays, simulationDays) ||
                other.simulationDays == simulationDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    finalBiomass,
    totalFeedConsumption,
    totalRevenue,
    totalFeedCost,
    netProfit,
    finalSurvivalRate,
    averageFCR,
    totalHarvestWeight,
    simulationDays,
  );

  /// Create a copy of SimulationSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationSummaryImplCopyWith<_$SimulationSummaryImpl> get copyWith =>
      __$$SimulationSummaryImplCopyWithImpl<_$SimulationSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SimulationSummaryImplToJson(this);
  }
}

abstract class _SimulationSummary implements SimulationSummary {
  const factory _SimulationSummary({
    required final double finalBiomass,
    required final double totalFeedConsumption,
    required final double totalRevenue,
    required final double totalFeedCost,
    required final double netProfit,
    required final double finalSurvivalRate,
    required final double averageFCR,
    required final double totalHarvestWeight,
    required final int simulationDays,
  }) = _$SimulationSummaryImpl;

  factory _SimulationSummary.fromJson(Map<String, dynamic> json) =
      _$SimulationSummaryImpl.fromJson;

  /// Final biomass at target DOC (kg)
  @override
  double get finalBiomass;

  /// Total feed consumption (kg)
  @override
  double get totalFeedConsumption;

  /// Total revenue from all harvests (Rp)
  @override
  double get totalRevenue;

  /// Total feed cost (Rp)
  @override
  double get totalFeedCost;

  /// Net profit (Rp)
  @override
  double get netProfit;

  /// Final survival rate (%)
  @override
  double get finalSurvivalRate;

  /// Average FCR throughout simulation
  @override
  double get averageFCR;

  /// Total harvest weight (kg)
  @override
  double get totalHarvestWeight;

  /// Simulation duration (days)
  @override
  int get simulationDays;

  /// Create a copy of SimulationSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationSummaryImplCopyWith<_$SimulationSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
