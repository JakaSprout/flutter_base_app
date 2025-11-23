// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simulation_parameters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SimulationParameters _$SimulationParametersFromJson(Map<String, dynamic> json) {
  return _SimulationParameters.fromJson(json);
}

/// @nodoc
mixin _$SimulationParameters {
  /// Pond area in square meters (m²)
  double get pondArea => throw _privateConstructorUsedError;

  /// Initial stocking density (individuals per m²)
  double get stockingDensity => throw _privateConstructorUsedError;

  /// Initial weight in grams (g)
  double get initialWeight => throw _privateConstructorUsedError;

  /// Target Survival Rate percentage (0-100)
  double get targetSR => throw _privateConstructorUsedError;

  /// Target harvest weight in grams (g)
  double get targetHarvestWeight => throw _privateConstructorUsedError;

  /// Estimated Feed Conversion Ratio
  double get estimatedFCR => throw _privateConstructorUsedError;

  /// Target Day of Culture (days)
  int get targetDOC => throw _privateConstructorUsedError;

  /// Estimated Average Daily Gain in grams per day (g/day)
  double get estimatedADG => throw _privateConstructorUsedError;

  /// Daily loss percentage (0-100)
  double get dailyLossPercentage => throw _privateConstructorUsedError;

  /// Maximum capacity per square meter (kg/m²)
  double get capacityKgPerM2 => throw _privateConstructorUsedError;

  /// Maximum capacity per pond (kg/pond)
  double get capacityKgPerPond => throw _privateConstructorUsedError;

  /// Commodity selling price per kg
  double get sellingPricePerKg => throw _privateConstructorUsedError;

  /// Feed price per kg
  double get feedPricePerKg => throw _privateConstructorUsedError;

  /// Feeding rate percentage (biomass/day)
  double get feedingRatePercentage => throw _privateConstructorUsedError;

  /// List of harvest events (partial harvests)
  List<HarvestEvent> get harvestEvents => throw _privateConstructorUsedError;

  /// Current Day of Culture (for mid cycle, starts simulation from this day)
  int? get currentDOC => throw _privateConstructorUsedError;

  /// Simulation type ('cycle' or 'agent')
  String? get simulationType =>
      throw _privateConstructorUsedError; // Agent-specific parameters
  /// Current biomass in kg (agent mode only)
  double? get currentBiomass => throw _privateConstructorUsedError;

  /// Stocking count in individuals (agent mode only)
  double? get stocking => throw _privateConstructorUsedError;

  /// Estimated harvest yield in kg (agent mode only)
  double? get estimatedHarvestYield => throw _privateConstructorUsedError;

  /// Total feed payment obligation in currency (agent mode only)
  double? get totalFeedPaymentObligation => throw _privateConstructorUsedError;

  /// Harvest purchase price per kg (agent mode only)
  double? get harvestPurchasePrice => throw _privateConstructorUsedError;

  /// Serializes this SimulationParameters to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimulationParameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimulationParametersCopyWith<SimulationParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulationParametersCopyWith<$Res> {
  factory $SimulationParametersCopyWith(
    SimulationParameters value,
    $Res Function(SimulationParameters) then,
  ) = _$SimulationParametersCopyWithImpl<$Res, SimulationParameters>;
  @useResult
  $Res call({
    double pondArea,
    double stockingDensity,
    double initialWeight,
    double targetSR,
    double targetHarvestWeight,
    double estimatedFCR,
    int targetDOC,
    double estimatedADG,
    double dailyLossPercentage,
    double capacityKgPerM2,
    double capacityKgPerPond,
    double sellingPricePerKg,
    double feedPricePerKg,
    double feedingRatePercentage,
    List<HarvestEvent> harvestEvents,
    int? currentDOC,
    String? simulationType,
    double? currentBiomass,
    double? stocking,
    double? estimatedHarvestYield,
    double? totalFeedPaymentObligation,
    double? harvestPurchasePrice,
  });
}

/// @nodoc
class _$SimulationParametersCopyWithImpl<
  $Res,
  $Val extends SimulationParameters
>
    implements $SimulationParametersCopyWith<$Res> {
  _$SimulationParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimulationParameters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pondArea = null,
    Object? stockingDensity = null,
    Object? initialWeight = null,
    Object? targetSR = null,
    Object? targetHarvestWeight = null,
    Object? estimatedFCR = null,
    Object? targetDOC = null,
    Object? estimatedADG = null,
    Object? dailyLossPercentage = null,
    Object? capacityKgPerM2 = null,
    Object? capacityKgPerPond = null,
    Object? sellingPricePerKg = null,
    Object? feedPricePerKg = null,
    Object? feedingRatePercentage = null,
    Object? harvestEvents = null,
    Object? currentDOC = freezed,
    Object? simulationType = freezed,
    Object? currentBiomass = freezed,
    Object? stocking = freezed,
    Object? estimatedHarvestYield = freezed,
    Object? totalFeedPaymentObligation = freezed,
    Object? harvestPurchasePrice = freezed,
  }) {
    return _then(
      _value.copyWith(
            pondArea: null == pondArea
                ? _value.pondArea
                : pondArea // ignore: cast_nullable_to_non_nullable
                      as double,
            stockingDensity: null == stockingDensity
                ? _value.stockingDensity
                : stockingDensity // ignore: cast_nullable_to_non_nullable
                      as double,
            initialWeight: null == initialWeight
                ? _value.initialWeight
                : initialWeight // ignore: cast_nullable_to_non_nullable
                      as double,
            targetSR: null == targetSR
                ? _value.targetSR
                : targetSR // ignore: cast_nullable_to_non_nullable
                      as double,
            targetHarvestWeight: null == targetHarvestWeight
                ? _value.targetHarvestWeight
                : targetHarvestWeight // ignore: cast_nullable_to_non_nullable
                      as double,
            estimatedFCR: null == estimatedFCR
                ? _value.estimatedFCR
                : estimatedFCR // ignore: cast_nullable_to_non_nullable
                      as double,
            targetDOC: null == targetDOC
                ? _value.targetDOC
                : targetDOC // ignore: cast_nullable_to_non_nullable
                      as int,
            estimatedADG: null == estimatedADG
                ? _value.estimatedADG
                : estimatedADG // ignore: cast_nullable_to_non_nullable
                      as double,
            dailyLossPercentage: null == dailyLossPercentage
                ? _value.dailyLossPercentage
                : dailyLossPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            capacityKgPerM2: null == capacityKgPerM2
                ? _value.capacityKgPerM2
                : capacityKgPerM2 // ignore: cast_nullable_to_non_nullable
                      as double,
            capacityKgPerPond: null == capacityKgPerPond
                ? _value.capacityKgPerPond
                : capacityKgPerPond // ignore: cast_nullable_to_non_nullable
                      as double,
            sellingPricePerKg: null == sellingPricePerKg
                ? _value.sellingPricePerKg
                : sellingPricePerKg // ignore: cast_nullable_to_non_nullable
                      as double,
            feedPricePerKg: null == feedPricePerKg
                ? _value.feedPricePerKg
                : feedPricePerKg // ignore: cast_nullable_to_non_nullable
                      as double,
            feedingRatePercentage: null == feedingRatePercentage
                ? _value.feedingRatePercentage
                : feedingRatePercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            harvestEvents: null == harvestEvents
                ? _value.harvestEvents
                : harvestEvents // ignore: cast_nullable_to_non_nullable
                      as List<HarvestEvent>,
            currentDOC: freezed == currentDOC
                ? _value.currentDOC
                : currentDOC // ignore: cast_nullable_to_non_nullable
                      as int?,
            simulationType: freezed == simulationType
                ? _value.simulationType
                : simulationType // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentBiomass: freezed == currentBiomass
                ? _value.currentBiomass
                : currentBiomass // ignore: cast_nullable_to_non_nullable
                      as double?,
            stocking: freezed == stocking
                ? _value.stocking
                : stocking // ignore: cast_nullable_to_non_nullable
                      as double?,
            estimatedHarvestYield: freezed == estimatedHarvestYield
                ? _value.estimatedHarvestYield
                : estimatedHarvestYield // ignore: cast_nullable_to_non_nullable
                      as double?,
            totalFeedPaymentObligation: freezed == totalFeedPaymentObligation
                ? _value.totalFeedPaymentObligation
                : totalFeedPaymentObligation // ignore: cast_nullable_to_non_nullable
                      as double?,
            harvestPurchasePrice: freezed == harvestPurchasePrice
                ? _value.harvestPurchasePrice
                : harvestPurchasePrice // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SimulationParametersImplCopyWith<$Res>
    implements $SimulationParametersCopyWith<$Res> {
  factory _$$SimulationParametersImplCopyWith(
    _$SimulationParametersImpl value,
    $Res Function(_$SimulationParametersImpl) then,
  ) = __$$SimulationParametersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double pondArea,
    double stockingDensity,
    double initialWeight,
    double targetSR,
    double targetHarvestWeight,
    double estimatedFCR,
    int targetDOC,
    double estimatedADG,
    double dailyLossPercentage,
    double capacityKgPerM2,
    double capacityKgPerPond,
    double sellingPricePerKg,
    double feedPricePerKg,
    double feedingRatePercentage,
    List<HarvestEvent> harvestEvents,
    int? currentDOC,
    String? simulationType,
    double? currentBiomass,
    double? stocking,
    double? estimatedHarvestYield,
    double? totalFeedPaymentObligation,
    double? harvestPurchasePrice,
  });
}

/// @nodoc
class __$$SimulationParametersImplCopyWithImpl<$Res>
    extends _$SimulationParametersCopyWithImpl<$Res, _$SimulationParametersImpl>
    implements _$$SimulationParametersImplCopyWith<$Res> {
  __$$SimulationParametersImplCopyWithImpl(
    _$SimulationParametersImpl _value,
    $Res Function(_$SimulationParametersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationParameters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pondArea = null,
    Object? stockingDensity = null,
    Object? initialWeight = null,
    Object? targetSR = null,
    Object? targetHarvestWeight = null,
    Object? estimatedFCR = null,
    Object? targetDOC = null,
    Object? estimatedADG = null,
    Object? dailyLossPercentage = null,
    Object? capacityKgPerM2 = null,
    Object? capacityKgPerPond = null,
    Object? sellingPricePerKg = null,
    Object? feedPricePerKg = null,
    Object? feedingRatePercentage = null,
    Object? harvestEvents = null,
    Object? currentDOC = freezed,
    Object? simulationType = freezed,
    Object? currentBiomass = freezed,
    Object? stocking = freezed,
    Object? estimatedHarvestYield = freezed,
    Object? totalFeedPaymentObligation = freezed,
    Object? harvestPurchasePrice = freezed,
  }) {
    return _then(
      _$SimulationParametersImpl(
        pondArea: null == pondArea
            ? _value.pondArea
            : pondArea // ignore: cast_nullable_to_non_nullable
                  as double,
        stockingDensity: null == stockingDensity
            ? _value.stockingDensity
            : stockingDensity // ignore: cast_nullable_to_non_nullable
                  as double,
        initialWeight: null == initialWeight
            ? _value.initialWeight
            : initialWeight // ignore: cast_nullable_to_non_nullable
                  as double,
        targetSR: null == targetSR
            ? _value.targetSR
            : targetSR // ignore: cast_nullable_to_non_nullable
                  as double,
        targetHarvestWeight: null == targetHarvestWeight
            ? _value.targetHarvestWeight
            : targetHarvestWeight // ignore: cast_nullable_to_non_nullable
                  as double,
        estimatedFCR: null == estimatedFCR
            ? _value.estimatedFCR
            : estimatedFCR // ignore: cast_nullable_to_non_nullable
                  as double,
        targetDOC: null == targetDOC
            ? _value.targetDOC
            : targetDOC // ignore: cast_nullable_to_non_nullable
                  as int,
        estimatedADG: null == estimatedADG
            ? _value.estimatedADG
            : estimatedADG // ignore: cast_nullable_to_non_nullable
                  as double,
        dailyLossPercentage: null == dailyLossPercentage
            ? _value.dailyLossPercentage
            : dailyLossPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        capacityKgPerM2: null == capacityKgPerM2
            ? _value.capacityKgPerM2
            : capacityKgPerM2 // ignore: cast_nullable_to_non_nullable
                  as double,
        capacityKgPerPond: null == capacityKgPerPond
            ? _value.capacityKgPerPond
            : capacityKgPerPond // ignore: cast_nullable_to_non_nullable
                  as double,
        sellingPricePerKg: null == sellingPricePerKg
            ? _value.sellingPricePerKg
            : sellingPricePerKg // ignore: cast_nullable_to_non_nullable
                  as double,
        feedPricePerKg: null == feedPricePerKg
            ? _value.feedPricePerKg
            : feedPricePerKg // ignore: cast_nullable_to_non_nullable
                  as double,
        feedingRatePercentage: null == feedingRatePercentage
            ? _value.feedingRatePercentage
            : feedingRatePercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        harvestEvents: null == harvestEvents
            ? _value._harvestEvents
            : harvestEvents // ignore: cast_nullable_to_non_nullable
                  as List<HarvestEvent>,
        currentDOC: freezed == currentDOC
            ? _value.currentDOC
            : currentDOC // ignore: cast_nullable_to_non_nullable
                  as int?,
        simulationType: freezed == simulationType
            ? _value.simulationType
            : simulationType // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentBiomass: freezed == currentBiomass
            ? _value.currentBiomass
            : currentBiomass // ignore: cast_nullable_to_non_nullable
                  as double?,
        stocking: freezed == stocking
            ? _value.stocking
            : stocking // ignore: cast_nullable_to_non_nullable
                  as double?,
        estimatedHarvestYield: freezed == estimatedHarvestYield
            ? _value.estimatedHarvestYield
            : estimatedHarvestYield // ignore: cast_nullable_to_non_nullable
                  as double?,
        totalFeedPaymentObligation: freezed == totalFeedPaymentObligation
            ? _value.totalFeedPaymentObligation
            : totalFeedPaymentObligation // ignore: cast_nullable_to_non_nullable
                  as double?,
        harvestPurchasePrice: freezed == harvestPurchasePrice
            ? _value.harvestPurchasePrice
            : harvestPurchasePrice // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SimulationParametersImpl implements _SimulationParameters {
  const _$SimulationParametersImpl({
    required this.pondArea,
    required this.stockingDensity,
    required this.initialWeight,
    required this.targetSR,
    required this.targetHarvestWeight,
    required this.estimatedFCR,
    required this.targetDOC,
    required this.estimatedADG,
    required this.dailyLossPercentage,
    required this.capacityKgPerM2,
    required this.capacityKgPerPond,
    required this.sellingPricePerKg,
    required this.feedPricePerKg,
    required this.feedingRatePercentage,
    required final List<HarvestEvent> harvestEvents,
    this.currentDOC,
    this.simulationType,
    this.currentBiomass,
    this.stocking,
    this.estimatedHarvestYield,
    this.totalFeedPaymentObligation,
    this.harvestPurchasePrice,
  }) : _harvestEvents = harvestEvents;

  factory _$SimulationParametersImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimulationParametersImplFromJson(json);

  /// Pond area in square meters (m²)
  @override
  final double pondArea;

  /// Initial stocking density (individuals per m²)
  @override
  final double stockingDensity;

  /// Initial weight in grams (g)
  @override
  final double initialWeight;

  /// Target Survival Rate percentage (0-100)
  @override
  final double targetSR;

  /// Target harvest weight in grams (g)
  @override
  final double targetHarvestWeight;

  /// Estimated Feed Conversion Ratio
  @override
  final double estimatedFCR;

  /// Target Day of Culture (days)
  @override
  final int targetDOC;

  /// Estimated Average Daily Gain in grams per day (g/day)
  @override
  final double estimatedADG;

  /// Daily loss percentage (0-100)
  @override
  final double dailyLossPercentage;

  /// Maximum capacity per square meter (kg/m²)
  @override
  final double capacityKgPerM2;

  /// Maximum capacity per pond (kg/pond)
  @override
  final double capacityKgPerPond;

  /// Commodity selling price per kg
  @override
  final double sellingPricePerKg;

  /// Feed price per kg
  @override
  final double feedPricePerKg;

  /// Feeding rate percentage (biomass/day)
  @override
  final double feedingRatePercentage;

  /// List of harvest events (partial harvests)
  final List<HarvestEvent> _harvestEvents;

  /// List of harvest events (partial harvests)
  @override
  List<HarvestEvent> get harvestEvents {
    if (_harvestEvents is EqualUnmodifiableListView) return _harvestEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_harvestEvents);
  }

  /// Current Day of Culture (for mid cycle, starts simulation from this day)
  @override
  final int? currentDOC;

  /// Simulation type ('cycle' or 'agent')
  @override
  final String? simulationType;
  // Agent-specific parameters
  /// Current biomass in kg (agent mode only)
  @override
  final double? currentBiomass;

  /// Stocking count in individuals (agent mode only)
  @override
  final double? stocking;

  /// Estimated harvest yield in kg (agent mode only)
  @override
  final double? estimatedHarvestYield;

  /// Total feed payment obligation in currency (agent mode only)
  @override
  final double? totalFeedPaymentObligation;

  /// Harvest purchase price per kg (agent mode only)
  @override
  final double? harvestPurchasePrice;

  @override
  String toString() {
    return 'SimulationParameters(pondArea: $pondArea, stockingDensity: $stockingDensity, initialWeight: $initialWeight, targetSR: $targetSR, targetHarvestWeight: $targetHarvestWeight, estimatedFCR: $estimatedFCR, targetDOC: $targetDOC, estimatedADG: $estimatedADG, dailyLossPercentage: $dailyLossPercentage, capacityKgPerM2: $capacityKgPerM2, capacityKgPerPond: $capacityKgPerPond, sellingPricePerKg: $sellingPricePerKg, feedPricePerKg: $feedPricePerKg, feedingRatePercentage: $feedingRatePercentage, harvestEvents: $harvestEvents, currentDOC: $currentDOC, simulationType: $simulationType, currentBiomass: $currentBiomass, stocking: $stocking, estimatedHarvestYield: $estimatedHarvestYield, totalFeedPaymentObligation: $totalFeedPaymentObligation, harvestPurchasePrice: $harvestPurchasePrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationParametersImpl &&
            (identical(other.pondArea, pondArea) ||
                other.pondArea == pondArea) &&
            (identical(other.stockingDensity, stockingDensity) ||
                other.stockingDensity == stockingDensity) &&
            (identical(other.initialWeight, initialWeight) ||
                other.initialWeight == initialWeight) &&
            (identical(other.targetSR, targetSR) ||
                other.targetSR == targetSR) &&
            (identical(other.targetHarvestWeight, targetHarvestWeight) ||
                other.targetHarvestWeight == targetHarvestWeight) &&
            (identical(other.estimatedFCR, estimatedFCR) ||
                other.estimatedFCR == estimatedFCR) &&
            (identical(other.targetDOC, targetDOC) ||
                other.targetDOC == targetDOC) &&
            (identical(other.estimatedADG, estimatedADG) ||
                other.estimatedADG == estimatedADG) &&
            (identical(other.dailyLossPercentage, dailyLossPercentage) ||
                other.dailyLossPercentage == dailyLossPercentage) &&
            (identical(other.capacityKgPerM2, capacityKgPerM2) ||
                other.capacityKgPerM2 == capacityKgPerM2) &&
            (identical(other.capacityKgPerPond, capacityKgPerPond) ||
                other.capacityKgPerPond == capacityKgPerPond) &&
            (identical(other.sellingPricePerKg, sellingPricePerKg) ||
                other.sellingPricePerKg == sellingPricePerKg) &&
            (identical(other.feedPricePerKg, feedPricePerKg) ||
                other.feedPricePerKg == feedPricePerKg) &&
            (identical(other.feedingRatePercentage, feedingRatePercentage) ||
                other.feedingRatePercentage == feedingRatePercentage) &&
            const DeepCollectionEquality().equals(
              other._harvestEvents,
              _harvestEvents,
            ) &&
            (identical(other.currentDOC, currentDOC) ||
                other.currentDOC == currentDOC) &&
            (identical(other.simulationType, simulationType) ||
                other.simulationType == simulationType) &&
            (identical(other.currentBiomass, currentBiomass) ||
                other.currentBiomass == currentBiomass) &&
            (identical(other.stocking, stocking) ||
                other.stocking == stocking) &&
            (identical(other.estimatedHarvestYield, estimatedHarvestYield) ||
                other.estimatedHarvestYield == estimatedHarvestYield) &&
            (identical(
                  other.totalFeedPaymentObligation,
                  totalFeedPaymentObligation,
                ) ||
                other.totalFeedPaymentObligation ==
                    totalFeedPaymentObligation) &&
            (identical(other.harvestPurchasePrice, harvestPurchasePrice) ||
                other.harvestPurchasePrice == harvestPurchasePrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    pondArea,
    stockingDensity,
    initialWeight,
    targetSR,
    targetHarvestWeight,
    estimatedFCR,
    targetDOC,
    estimatedADG,
    dailyLossPercentage,
    capacityKgPerM2,
    capacityKgPerPond,
    sellingPricePerKg,
    feedPricePerKg,
    feedingRatePercentage,
    const DeepCollectionEquality().hash(_harvestEvents),
    currentDOC,
    simulationType,
    currentBiomass,
    stocking,
    estimatedHarvestYield,
    totalFeedPaymentObligation,
    harvestPurchasePrice,
  ]);

  /// Create a copy of SimulationParameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationParametersImplCopyWith<_$SimulationParametersImpl>
  get copyWith =>
      __$$SimulationParametersImplCopyWithImpl<_$SimulationParametersImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SimulationParametersImplToJson(this);
  }
}

abstract class _SimulationParameters implements SimulationParameters {
  const factory _SimulationParameters({
    required final double pondArea,
    required final double stockingDensity,
    required final double initialWeight,
    required final double targetSR,
    required final double targetHarvestWeight,
    required final double estimatedFCR,
    required final int targetDOC,
    required final double estimatedADG,
    required final double dailyLossPercentage,
    required final double capacityKgPerM2,
    required final double capacityKgPerPond,
    required final double sellingPricePerKg,
    required final double feedPricePerKg,
    required final double feedingRatePercentage,
    required final List<HarvestEvent> harvestEvents,
    final int? currentDOC,
    final String? simulationType,
    final double? currentBiomass,
    final double? stocking,
    final double? estimatedHarvestYield,
    final double? totalFeedPaymentObligation,
    final double? harvestPurchasePrice,
  }) = _$SimulationParametersImpl;

  factory _SimulationParameters.fromJson(Map<String, dynamic> json) =
      _$SimulationParametersImpl.fromJson;

  /// Pond area in square meters (m²)
  @override
  double get pondArea;

  /// Initial stocking density (individuals per m²)
  @override
  double get stockingDensity;

  /// Initial weight in grams (g)
  @override
  double get initialWeight;

  /// Target Survival Rate percentage (0-100)
  @override
  double get targetSR;

  /// Target harvest weight in grams (g)
  @override
  double get targetHarvestWeight;

  /// Estimated Feed Conversion Ratio
  @override
  double get estimatedFCR;

  /// Target Day of Culture (days)
  @override
  int get targetDOC;

  /// Estimated Average Daily Gain in grams per day (g/day)
  @override
  double get estimatedADG;

  /// Daily loss percentage (0-100)
  @override
  double get dailyLossPercentage;

  /// Maximum capacity per square meter (kg/m²)
  @override
  double get capacityKgPerM2;

  /// Maximum capacity per pond (kg/pond)
  @override
  double get capacityKgPerPond;

  /// Commodity selling price per kg
  @override
  double get sellingPricePerKg;

  /// Feed price per kg
  @override
  double get feedPricePerKg;

  /// Feeding rate percentage (biomass/day)
  @override
  double get feedingRatePercentage;

  /// List of harvest events (partial harvests)
  @override
  List<HarvestEvent> get harvestEvents;

  /// Current Day of Culture (for mid cycle, starts simulation from this day)
  @override
  int? get currentDOC;

  /// Simulation type ('cycle' or 'agent')
  @override
  String? get simulationType; // Agent-specific parameters
  /// Current biomass in kg (agent mode only)
  @override
  double? get currentBiomass;

  /// Stocking count in individuals (agent mode only)
  @override
  double? get stocking;

  /// Estimated harvest yield in kg (agent mode only)
  @override
  double? get estimatedHarvestYield;

  /// Total feed payment obligation in currency (agent mode only)
  @override
  double? get totalFeedPaymentObligation;

  /// Harvest purchase price per kg (agent mode only)
  @override
  double? get harvestPurchasePrice;

  /// Create a copy of SimulationParameters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationParametersImplCopyWith<_$SimulationParametersImpl>
  get copyWith => throw _privateConstructorUsedError;
}

HarvestEvent _$HarvestEventFromJson(Map<String, dynamic> json) {
  return _HarvestEvent.fromJson(json);
}

/// @nodoc
mixin _$HarvestEvent {
  /// Day of Culture when harvest occurs
  int get doc => throw _privateConstructorUsedError;

  /// Harvest percentage (0-100)
  double get percentage => throw _privateConstructorUsedError;

  /// Optional description of the harvest event
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this HarvestEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HarvestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HarvestEventCopyWith<HarvestEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HarvestEventCopyWith<$Res> {
  factory $HarvestEventCopyWith(
    HarvestEvent value,
    $Res Function(HarvestEvent) then,
  ) = _$HarvestEventCopyWithImpl<$Res, HarvestEvent>;
  @useResult
  $Res call({int doc, double percentage, String? description});
}

/// @nodoc
class _$HarvestEventCopyWithImpl<$Res, $Val extends HarvestEvent>
    implements $HarvestEventCopyWith<$Res> {
  _$HarvestEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HarvestEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doc = null,
    Object? percentage = null,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            doc: null == doc
                ? _value.doc
                : doc // ignore: cast_nullable_to_non_nullable
                      as int,
            percentage: null == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HarvestEventImplCopyWith<$Res>
    implements $HarvestEventCopyWith<$Res> {
  factory _$$HarvestEventImplCopyWith(
    _$HarvestEventImpl value,
    $Res Function(_$HarvestEventImpl) then,
  ) = __$$HarvestEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int doc, double percentage, String? description});
}

/// @nodoc
class __$$HarvestEventImplCopyWithImpl<$Res>
    extends _$HarvestEventCopyWithImpl<$Res, _$HarvestEventImpl>
    implements _$$HarvestEventImplCopyWith<$Res> {
  __$$HarvestEventImplCopyWithImpl(
    _$HarvestEventImpl _value,
    $Res Function(_$HarvestEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HarvestEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doc = null,
    Object? percentage = null,
    Object? description = freezed,
  }) {
    return _then(
      _$HarvestEventImpl(
        doc: null == doc
            ? _value.doc
            : doc // ignore: cast_nullable_to_non_nullable
                  as int,
        percentage: null == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HarvestEventImpl implements _HarvestEvent {
  const _$HarvestEventImpl({
    required this.doc,
    required this.percentage,
    this.description,
  });

  factory _$HarvestEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$HarvestEventImplFromJson(json);

  /// Day of Culture when harvest occurs
  @override
  final int doc;

  /// Harvest percentage (0-100)
  @override
  final double percentage;

  /// Optional description of the harvest event
  @override
  final String? description;

  @override
  String toString() {
    return 'HarvestEvent(doc: $doc, percentage: $percentage, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HarvestEventImpl &&
            (identical(other.doc, doc) || other.doc == doc) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, doc, percentage, description);

  /// Create a copy of HarvestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HarvestEventImplCopyWith<_$HarvestEventImpl> get copyWith =>
      __$$HarvestEventImplCopyWithImpl<_$HarvestEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HarvestEventImplToJson(this);
  }
}

abstract class _HarvestEvent implements HarvestEvent {
  const factory _HarvestEvent({
    required final int doc,
    required final double percentage,
    final String? description,
  }) = _$HarvestEventImpl;

  factory _HarvestEvent.fromJson(Map<String, dynamic> json) =
      _$HarvestEventImpl.fromJson;

  /// Day of Culture when harvest occurs
  @override
  int get doc;

  /// Harvest percentage (0-100)
  @override
  double get percentage;

  /// Optional description of the harvest event
  @override
  String? get description;

  /// Create a copy of HarvestEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HarvestEventImplCopyWith<_$HarvestEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
