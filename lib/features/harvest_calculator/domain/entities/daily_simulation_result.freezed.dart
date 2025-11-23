// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_simulation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DailySimulationResult _$DailySimulationResultFromJson(
  Map<String, dynamic> json,
) {
  return _DailySimulationResult.fromJson(json);
}

/// @nodoc
mixin _$DailySimulationResult {
  /// Day of Culture (1-based)
  int get doc => throw _privateConstructorUsedError;

  /// Weight at the end of this day (grams)
  double get weight => throw _privateConstructorUsedError;

  /// Population at the end of this day
  double get population => throw _privateConstructorUsedError;

  /// Biomass at the end of this day (kg)
  double get biomass => throw _privateConstructorUsedError;

  /// Daily feed consumption (kg)
  double get dailyFeedConsumption => throw _privateConstructorUsedError;

  /// Cumulative feed consumption up to this day (kg)
  double get cumulativeFeedConsumption => throw _privateConstructorUsedError;

  /// Potential revenue if harvested at this point (Rp)
  double get potentialRevenue => throw _privateConstructorUsedError;

  /// Cumulative feed cost up to this day (Rp)
  double get cumulativeFeedCost => throw _privateConstructorUsedError;

  /// Potential profit if harvested at this point (Rp)
  double get potentialProfit => throw _privateConstructorUsedError;

  /// Survival Rate at this point (%)
  double get survivalRate => throw _privateConstructorUsedError;

  /// Feed Conversion Ratio at this point
  double get fcr => throw _privateConstructorUsedError;

  /// Average Daily Gain (g/day) - calculated from weight change
  double get adg => throw _privateConstructorUsedError;

  /// Whether this day includes a harvest event
  bool get hasHarvest => throw _privateConstructorUsedError;

  /// Harvest amount if applicable (kg)
  double? get harvestAmount => throw _privateConstructorUsedError;

  /// Population reduction due to harvest
  double? get harvestPopulationReduction => throw _privateConstructorUsedError;

  /// Serializes this DailySimulationResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailySimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailySimulationResultCopyWith<DailySimulationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailySimulationResultCopyWith<$Res> {
  factory $DailySimulationResultCopyWith(
    DailySimulationResult value,
    $Res Function(DailySimulationResult) then,
  ) = _$DailySimulationResultCopyWithImpl<$Res, DailySimulationResult>;
  @useResult
  $Res call({
    int doc,
    double weight,
    double population,
    double biomass,
    double dailyFeedConsumption,
    double cumulativeFeedConsumption,
    double potentialRevenue,
    double cumulativeFeedCost,
    double potentialProfit,
    double survivalRate,
    double fcr,
    double adg,
    bool hasHarvest,
    double? harvestAmount,
    double? harvestPopulationReduction,
  });
}

/// @nodoc
class _$DailySimulationResultCopyWithImpl<
  $Res,
  $Val extends DailySimulationResult
>
    implements $DailySimulationResultCopyWith<$Res> {
  _$DailySimulationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailySimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doc = null,
    Object? weight = null,
    Object? population = null,
    Object? biomass = null,
    Object? dailyFeedConsumption = null,
    Object? cumulativeFeedConsumption = null,
    Object? potentialRevenue = null,
    Object? cumulativeFeedCost = null,
    Object? potentialProfit = null,
    Object? survivalRate = null,
    Object? fcr = null,
    Object? adg = null,
    Object? hasHarvest = null,
    Object? harvestAmount = freezed,
    Object? harvestPopulationReduction = freezed,
  }) {
    return _then(
      _value.copyWith(
            doc: null == doc
                ? _value.doc
                : doc // ignore: cast_nullable_to_non_nullable
                      as int,
            weight: null == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as double,
            population: null == population
                ? _value.population
                : population // ignore: cast_nullable_to_non_nullable
                      as double,
            biomass: null == biomass
                ? _value.biomass
                : biomass // ignore: cast_nullable_to_non_nullable
                      as double,
            dailyFeedConsumption: null == dailyFeedConsumption
                ? _value.dailyFeedConsumption
                : dailyFeedConsumption // ignore: cast_nullable_to_non_nullable
                      as double,
            cumulativeFeedConsumption: null == cumulativeFeedConsumption
                ? _value.cumulativeFeedConsumption
                : cumulativeFeedConsumption // ignore: cast_nullable_to_non_nullable
                      as double,
            potentialRevenue: null == potentialRevenue
                ? _value.potentialRevenue
                : potentialRevenue // ignore: cast_nullable_to_non_nullable
                      as double,
            cumulativeFeedCost: null == cumulativeFeedCost
                ? _value.cumulativeFeedCost
                : cumulativeFeedCost // ignore: cast_nullable_to_non_nullable
                      as double,
            potentialProfit: null == potentialProfit
                ? _value.potentialProfit
                : potentialProfit // ignore: cast_nullable_to_non_nullable
                      as double,
            survivalRate: null == survivalRate
                ? _value.survivalRate
                : survivalRate // ignore: cast_nullable_to_non_nullable
                      as double,
            fcr: null == fcr
                ? _value.fcr
                : fcr // ignore: cast_nullable_to_non_nullable
                      as double,
            adg: null == adg
                ? _value.adg
                : adg // ignore: cast_nullable_to_non_nullable
                      as double,
            hasHarvest: null == hasHarvest
                ? _value.hasHarvest
                : hasHarvest // ignore: cast_nullable_to_non_nullable
                      as bool,
            harvestAmount: freezed == harvestAmount
                ? _value.harvestAmount
                : harvestAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            harvestPopulationReduction: freezed == harvestPopulationReduction
                ? _value.harvestPopulationReduction
                : harvestPopulationReduction // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailySimulationResultImplCopyWith<$Res>
    implements $DailySimulationResultCopyWith<$Res> {
  factory _$$DailySimulationResultImplCopyWith(
    _$DailySimulationResultImpl value,
    $Res Function(_$DailySimulationResultImpl) then,
  ) = __$$DailySimulationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int doc,
    double weight,
    double population,
    double biomass,
    double dailyFeedConsumption,
    double cumulativeFeedConsumption,
    double potentialRevenue,
    double cumulativeFeedCost,
    double potentialProfit,
    double survivalRate,
    double fcr,
    double adg,
    bool hasHarvest,
    double? harvestAmount,
    double? harvestPopulationReduction,
  });
}

/// @nodoc
class __$$DailySimulationResultImplCopyWithImpl<$Res>
    extends
        _$DailySimulationResultCopyWithImpl<$Res, _$DailySimulationResultImpl>
    implements _$$DailySimulationResultImplCopyWith<$Res> {
  __$$DailySimulationResultImplCopyWithImpl(
    _$DailySimulationResultImpl _value,
    $Res Function(_$DailySimulationResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailySimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doc = null,
    Object? weight = null,
    Object? population = null,
    Object? biomass = null,
    Object? dailyFeedConsumption = null,
    Object? cumulativeFeedConsumption = null,
    Object? potentialRevenue = null,
    Object? cumulativeFeedCost = null,
    Object? potentialProfit = null,
    Object? survivalRate = null,
    Object? fcr = null,
    Object? adg = null,
    Object? hasHarvest = null,
    Object? harvestAmount = freezed,
    Object? harvestPopulationReduction = freezed,
  }) {
    return _then(
      _$DailySimulationResultImpl(
        doc: null == doc
            ? _value.doc
            : doc // ignore: cast_nullable_to_non_nullable
                  as int,
        weight: null == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double,
        population: null == population
            ? _value.population
            : population // ignore: cast_nullable_to_non_nullable
                  as double,
        biomass: null == biomass
            ? _value.biomass
            : biomass // ignore: cast_nullable_to_non_nullable
                  as double,
        dailyFeedConsumption: null == dailyFeedConsumption
            ? _value.dailyFeedConsumption
            : dailyFeedConsumption // ignore: cast_nullable_to_non_nullable
                  as double,
        cumulativeFeedConsumption: null == cumulativeFeedConsumption
            ? _value.cumulativeFeedConsumption
            : cumulativeFeedConsumption // ignore: cast_nullable_to_non_nullable
                  as double,
        potentialRevenue: null == potentialRevenue
            ? _value.potentialRevenue
            : potentialRevenue // ignore: cast_nullable_to_non_nullable
                  as double,
        cumulativeFeedCost: null == cumulativeFeedCost
            ? _value.cumulativeFeedCost
            : cumulativeFeedCost // ignore: cast_nullable_to_non_nullable
                  as double,
        potentialProfit: null == potentialProfit
            ? _value.potentialProfit
            : potentialProfit // ignore: cast_nullable_to_non_nullable
                  as double,
        survivalRate: null == survivalRate
            ? _value.survivalRate
            : survivalRate // ignore: cast_nullable_to_non_nullable
                  as double,
        fcr: null == fcr
            ? _value.fcr
            : fcr // ignore: cast_nullable_to_non_nullable
                  as double,
        adg: null == adg
            ? _value.adg
            : adg // ignore: cast_nullable_to_non_nullable
                  as double,
        hasHarvest: null == hasHarvest
            ? _value.hasHarvest
            : hasHarvest // ignore: cast_nullable_to_non_nullable
                  as bool,
        harvestAmount: freezed == harvestAmount
            ? _value.harvestAmount
            : harvestAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        harvestPopulationReduction: freezed == harvestPopulationReduction
            ? _value.harvestPopulationReduction
            : harvestPopulationReduction // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailySimulationResultImpl implements _DailySimulationResult {
  const _$DailySimulationResultImpl({
    required this.doc,
    required this.weight,
    required this.population,
    required this.biomass,
    required this.dailyFeedConsumption,
    required this.cumulativeFeedConsumption,
    required this.potentialRevenue,
    required this.cumulativeFeedCost,
    required this.potentialProfit,
    required this.survivalRate,
    required this.fcr,
    required this.adg,
    this.hasHarvest = false,
    this.harvestAmount,
    this.harvestPopulationReduction,
  });

  factory _$DailySimulationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailySimulationResultImplFromJson(json);

  /// Day of Culture (1-based)
  @override
  final int doc;

  /// Weight at the end of this day (grams)
  @override
  final double weight;

  /// Population at the end of this day
  @override
  final double population;

  /// Biomass at the end of this day (kg)
  @override
  final double biomass;

  /// Daily feed consumption (kg)
  @override
  final double dailyFeedConsumption;

  /// Cumulative feed consumption up to this day (kg)
  @override
  final double cumulativeFeedConsumption;

  /// Potential revenue if harvested at this point (Rp)
  @override
  final double potentialRevenue;

  /// Cumulative feed cost up to this day (Rp)
  @override
  final double cumulativeFeedCost;

  /// Potential profit if harvested at this point (Rp)
  @override
  final double potentialProfit;

  /// Survival Rate at this point (%)
  @override
  final double survivalRate;

  /// Feed Conversion Ratio at this point
  @override
  final double fcr;

  /// Average Daily Gain (g/day) - calculated from weight change
  @override
  final double adg;

  /// Whether this day includes a harvest event
  @override
  @JsonKey()
  final bool hasHarvest;

  /// Harvest amount if applicable (kg)
  @override
  final double? harvestAmount;

  /// Population reduction due to harvest
  @override
  final double? harvestPopulationReduction;

  @override
  String toString() {
    return 'DailySimulationResult(doc: $doc, weight: $weight, population: $population, biomass: $biomass, dailyFeedConsumption: $dailyFeedConsumption, cumulativeFeedConsumption: $cumulativeFeedConsumption, potentialRevenue: $potentialRevenue, cumulativeFeedCost: $cumulativeFeedCost, potentialProfit: $potentialProfit, survivalRate: $survivalRate, fcr: $fcr, adg: $adg, hasHarvest: $hasHarvest, harvestAmount: $harvestAmount, harvestPopulationReduction: $harvestPopulationReduction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailySimulationResultImpl &&
            (identical(other.doc, doc) || other.doc == doc) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.population, population) ||
                other.population == population) &&
            (identical(other.biomass, biomass) || other.biomass == biomass) &&
            (identical(other.dailyFeedConsumption, dailyFeedConsumption) ||
                other.dailyFeedConsumption == dailyFeedConsumption) &&
            (identical(
                  other.cumulativeFeedConsumption,
                  cumulativeFeedConsumption,
                ) ||
                other.cumulativeFeedConsumption == cumulativeFeedConsumption) &&
            (identical(other.potentialRevenue, potentialRevenue) ||
                other.potentialRevenue == potentialRevenue) &&
            (identical(other.cumulativeFeedCost, cumulativeFeedCost) ||
                other.cumulativeFeedCost == cumulativeFeedCost) &&
            (identical(other.potentialProfit, potentialProfit) ||
                other.potentialProfit == potentialProfit) &&
            (identical(other.survivalRate, survivalRate) ||
                other.survivalRate == survivalRate) &&
            (identical(other.fcr, fcr) || other.fcr == fcr) &&
            (identical(other.adg, adg) || other.adg == adg) &&
            (identical(other.hasHarvest, hasHarvest) ||
                other.hasHarvest == hasHarvest) &&
            (identical(other.harvestAmount, harvestAmount) ||
                other.harvestAmount == harvestAmount) &&
            (identical(
                  other.harvestPopulationReduction,
                  harvestPopulationReduction,
                ) ||
                other.harvestPopulationReduction ==
                    harvestPopulationReduction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    doc,
    weight,
    population,
    biomass,
    dailyFeedConsumption,
    cumulativeFeedConsumption,
    potentialRevenue,
    cumulativeFeedCost,
    potentialProfit,
    survivalRate,
    fcr,
    adg,
    hasHarvest,
    harvestAmount,
    harvestPopulationReduction,
  );

  /// Create a copy of DailySimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailySimulationResultImplCopyWith<_$DailySimulationResultImpl>
  get copyWith =>
      __$$DailySimulationResultImplCopyWithImpl<_$DailySimulationResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DailySimulationResultImplToJson(this);
  }
}

abstract class _DailySimulationResult implements DailySimulationResult {
  const factory _DailySimulationResult({
    required final int doc,
    required final double weight,
    required final double population,
    required final double biomass,
    required final double dailyFeedConsumption,
    required final double cumulativeFeedConsumption,
    required final double potentialRevenue,
    required final double cumulativeFeedCost,
    required final double potentialProfit,
    required final double survivalRate,
    required final double fcr,
    required final double adg,
    final bool hasHarvest,
    final double? harvestAmount,
    final double? harvestPopulationReduction,
  }) = _$DailySimulationResultImpl;

  factory _DailySimulationResult.fromJson(Map<String, dynamic> json) =
      _$DailySimulationResultImpl.fromJson;

  /// Day of Culture (1-based)
  @override
  int get doc;

  /// Weight at the end of this day (grams)
  @override
  double get weight;

  /// Population at the end of this day
  @override
  double get population;

  /// Biomass at the end of this day (kg)
  @override
  double get biomass;

  /// Daily feed consumption (kg)
  @override
  double get dailyFeedConsumption;

  /// Cumulative feed consumption up to this day (kg)
  @override
  double get cumulativeFeedConsumption;

  /// Potential revenue if harvested at this point (Rp)
  @override
  double get potentialRevenue;

  /// Cumulative feed cost up to this day (Rp)
  @override
  double get cumulativeFeedCost;

  /// Potential profit if harvested at this point (Rp)
  @override
  double get potentialProfit;

  /// Survival Rate at this point (%)
  @override
  double get survivalRate;

  /// Feed Conversion Ratio at this point
  @override
  double get fcr;

  /// Average Daily Gain (g/day) - calculated from weight change
  @override
  double get adg;

  /// Whether this day includes a harvest event
  @override
  bool get hasHarvest;

  /// Harvest amount if applicable (kg)
  @override
  double? get harvestAmount;

  /// Population reduction due to harvest
  @override
  double? get harvestPopulationReduction;

  /// Create a copy of DailySimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailySimulationResultImplCopyWith<_$DailySimulationResultImpl>
  get copyWith => throw _privateConstructorUsedError;
}
