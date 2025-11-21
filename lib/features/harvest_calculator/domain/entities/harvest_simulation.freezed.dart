// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'harvest_simulation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HarvestSimulation _$HarvestSimulationFromJson(Map<String, dynamic> json) {
  return _HarvestSimulation.fromJson(json);
}

/// @nodoc
mixin _$HarvestSimulation {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get commodity => throw _privateConstructorUsedError;
  String get cultivationSystem => throw _privateConstructorUsedError;
  double get pondArea => throw _privateConstructorUsedError;
  double get targetHarvest => throw _privateConstructorUsedError;
  double get estimatedADG => throw _privateConstructorUsedError;
  int get targetDOC => throw _privateConstructorUsedError;
  double get targetSR => throw _privateConstructorUsedError;
  double get estimatedFCR => throw _privateConstructorUsedError;
  double get targetBiomass => throw _privateConstructorUsedError;
  double get sellingPrice => throw _privateConstructorUsedError;
  double get feedPrice => throw _privateConstructorUsedError;
  String get cycleType => throw _privateConstructorUsedError;
  double? get currentDOC => throw _privateConstructorUsedError;
  SimulationResults get results => throw _privateConstructorUsedError;

  /// Serializes this HarvestSimulation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HarvestSimulation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HarvestSimulationCopyWith<HarvestSimulation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HarvestSimulationCopyWith<$Res> {
  factory $HarvestSimulationCopyWith(
    HarvestSimulation value,
    $Res Function(HarvestSimulation) then,
  ) = _$HarvestSimulationCopyWithImpl<$Res, HarvestSimulation>;
  @useResult
  $Res call({
    String id,
    String name,
    DateTime createdAt,
    String commodity,
    String cultivationSystem,
    double pondArea,
    double targetHarvest,
    double estimatedADG,
    int targetDOC,
    double targetSR,
    double estimatedFCR,
    double targetBiomass,
    double sellingPrice,
    double feedPrice,
    String cycleType,
    double? currentDOC,
    SimulationResults results,
  });

  $SimulationResultsCopyWith<$Res> get results;
}

/// @nodoc
class _$HarvestSimulationCopyWithImpl<$Res, $Val extends HarvestSimulation>
    implements $HarvestSimulationCopyWith<$Res> {
  _$HarvestSimulationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HarvestSimulation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? commodity = null,
    Object? cultivationSystem = null,
    Object? pondArea = null,
    Object? targetHarvest = null,
    Object? estimatedADG = null,
    Object? targetDOC = null,
    Object? targetSR = null,
    Object? estimatedFCR = null,
    Object? targetBiomass = null,
    Object? sellingPrice = null,
    Object? feedPrice = null,
    Object? cycleType = null,
    Object? currentDOC = freezed,
    Object? results = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            commodity: null == commodity
                ? _value.commodity
                : commodity // ignore: cast_nullable_to_non_nullable
                      as String,
            cultivationSystem: null == cultivationSystem
                ? _value.cultivationSystem
                : cultivationSystem // ignore: cast_nullable_to_non_nullable
                      as String,
            pondArea: null == pondArea
                ? _value.pondArea
                : pondArea // ignore: cast_nullable_to_non_nullable
                      as double,
            targetHarvest: null == targetHarvest
                ? _value.targetHarvest
                : targetHarvest // ignore: cast_nullable_to_non_nullable
                      as double,
            estimatedADG: null == estimatedADG
                ? _value.estimatedADG
                : estimatedADG // ignore: cast_nullable_to_non_nullable
                      as double,
            targetDOC: null == targetDOC
                ? _value.targetDOC
                : targetDOC // ignore: cast_nullable_to_non_nullable
                      as int,
            targetSR: null == targetSR
                ? _value.targetSR
                : targetSR // ignore: cast_nullable_to_non_nullable
                      as double,
            estimatedFCR: null == estimatedFCR
                ? _value.estimatedFCR
                : estimatedFCR // ignore: cast_nullable_to_non_nullable
                      as double,
            targetBiomass: null == targetBiomass
                ? _value.targetBiomass
                : targetBiomass // ignore: cast_nullable_to_non_nullable
                      as double,
            sellingPrice: null == sellingPrice
                ? _value.sellingPrice
                : sellingPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            feedPrice: null == feedPrice
                ? _value.feedPrice
                : feedPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            cycleType: null == cycleType
                ? _value.cycleType
                : cycleType // ignore: cast_nullable_to_non_nullable
                      as String,
            currentDOC: freezed == currentDOC
                ? _value.currentDOC
                : currentDOC // ignore: cast_nullable_to_non_nullable
                      as double?,
            results: null == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as SimulationResults,
          )
          as $Val,
    );
  }

  /// Create a copy of HarvestSimulation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SimulationResultsCopyWith<$Res> get results {
    return $SimulationResultsCopyWith<$Res>(_value.results, (value) {
      return _then(_value.copyWith(results: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HarvestSimulationImplCopyWith<$Res>
    implements $HarvestSimulationCopyWith<$Res> {
  factory _$$HarvestSimulationImplCopyWith(
    _$HarvestSimulationImpl value,
    $Res Function(_$HarvestSimulationImpl) then,
  ) = __$$HarvestSimulationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    DateTime createdAt,
    String commodity,
    String cultivationSystem,
    double pondArea,
    double targetHarvest,
    double estimatedADG,
    int targetDOC,
    double targetSR,
    double estimatedFCR,
    double targetBiomass,
    double sellingPrice,
    double feedPrice,
    String cycleType,
    double? currentDOC,
    SimulationResults results,
  });

  @override
  $SimulationResultsCopyWith<$Res> get results;
}

/// @nodoc
class __$$HarvestSimulationImplCopyWithImpl<$Res>
    extends _$HarvestSimulationCopyWithImpl<$Res, _$HarvestSimulationImpl>
    implements _$$HarvestSimulationImplCopyWith<$Res> {
  __$$HarvestSimulationImplCopyWithImpl(
    _$HarvestSimulationImpl _value,
    $Res Function(_$HarvestSimulationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HarvestSimulation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? commodity = null,
    Object? cultivationSystem = null,
    Object? pondArea = null,
    Object? targetHarvest = null,
    Object? estimatedADG = null,
    Object? targetDOC = null,
    Object? targetSR = null,
    Object? estimatedFCR = null,
    Object? targetBiomass = null,
    Object? sellingPrice = null,
    Object? feedPrice = null,
    Object? cycleType = null,
    Object? currentDOC = freezed,
    Object? results = null,
  }) {
    return _then(
      _$HarvestSimulationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        commodity: null == commodity
            ? _value.commodity
            : commodity // ignore: cast_nullable_to_non_nullable
                  as String,
        cultivationSystem: null == cultivationSystem
            ? _value.cultivationSystem
            : cultivationSystem // ignore: cast_nullable_to_non_nullable
                  as String,
        pondArea: null == pondArea
            ? _value.pondArea
            : pondArea // ignore: cast_nullable_to_non_nullable
                  as double,
        targetHarvest: null == targetHarvest
            ? _value.targetHarvest
            : targetHarvest // ignore: cast_nullable_to_non_nullable
                  as double,
        estimatedADG: null == estimatedADG
            ? _value.estimatedADG
            : estimatedADG // ignore: cast_nullable_to_non_nullable
                  as double,
        targetDOC: null == targetDOC
            ? _value.targetDOC
            : targetDOC // ignore: cast_nullable_to_non_nullable
                  as int,
        targetSR: null == targetSR
            ? _value.targetSR
            : targetSR // ignore: cast_nullable_to_non_nullable
                  as double,
        estimatedFCR: null == estimatedFCR
            ? _value.estimatedFCR
            : estimatedFCR // ignore: cast_nullable_to_non_nullable
                  as double,
        targetBiomass: null == targetBiomass
            ? _value.targetBiomass
            : targetBiomass // ignore: cast_nullable_to_non_nullable
                  as double,
        sellingPrice: null == sellingPrice
            ? _value.sellingPrice
            : sellingPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        feedPrice: null == feedPrice
            ? _value.feedPrice
            : feedPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        cycleType: null == cycleType
            ? _value.cycleType
            : cycleType // ignore: cast_nullable_to_non_nullable
                  as String,
        currentDOC: freezed == currentDOC
            ? _value.currentDOC
            : currentDOC // ignore: cast_nullable_to_non_nullable
                  as double?,
        results: null == results
            ? _value.results
            : results // ignore: cast_nullable_to_non_nullable
                  as SimulationResults,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HarvestSimulationImpl implements _HarvestSimulation {
  const _$HarvestSimulationImpl({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.commodity,
    required this.cultivationSystem,
    required this.pondArea,
    required this.targetHarvest,
    required this.estimatedADG,
    required this.targetDOC,
    required this.targetSR,
    required this.estimatedFCR,
    required this.targetBiomass,
    required this.sellingPrice,
    required this.feedPrice,
    required this.cycleType,
    required this.currentDOC,
    required this.results,
  });

  factory _$HarvestSimulationImpl.fromJson(Map<String, dynamic> json) =>
      _$$HarvestSimulationImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final DateTime createdAt;
  @override
  final String commodity;
  @override
  final String cultivationSystem;
  @override
  final double pondArea;
  @override
  final double targetHarvest;
  @override
  final double estimatedADG;
  @override
  final int targetDOC;
  @override
  final double targetSR;
  @override
  final double estimatedFCR;
  @override
  final double targetBiomass;
  @override
  final double sellingPrice;
  @override
  final double feedPrice;
  @override
  final String cycleType;
  @override
  final double? currentDOC;
  @override
  final SimulationResults results;

  @override
  String toString() {
    return 'HarvestSimulation(id: $id, name: $name, createdAt: $createdAt, commodity: $commodity, cultivationSystem: $cultivationSystem, pondArea: $pondArea, targetHarvest: $targetHarvest, estimatedADG: $estimatedADG, targetDOC: $targetDOC, targetSR: $targetSR, estimatedFCR: $estimatedFCR, targetBiomass: $targetBiomass, sellingPrice: $sellingPrice, feedPrice: $feedPrice, cycleType: $cycleType, currentDOC: $currentDOC, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HarvestSimulationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.commodity, commodity) ||
                other.commodity == commodity) &&
            (identical(other.cultivationSystem, cultivationSystem) ||
                other.cultivationSystem == cultivationSystem) &&
            (identical(other.pondArea, pondArea) ||
                other.pondArea == pondArea) &&
            (identical(other.targetHarvest, targetHarvest) ||
                other.targetHarvest == targetHarvest) &&
            (identical(other.estimatedADG, estimatedADG) ||
                other.estimatedADG == estimatedADG) &&
            (identical(other.targetDOC, targetDOC) ||
                other.targetDOC == targetDOC) &&
            (identical(other.targetSR, targetSR) ||
                other.targetSR == targetSR) &&
            (identical(other.estimatedFCR, estimatedFCR) ||
                other.estimatedFCR == estimatedFCR) &&
            (identical(other.targetBiomass, targetBiomass) ||
                other.targetBiomass == targetBiomass) &&
            (identical(other.sellingPrice, sellingPrice) ||
                other.sellingPrice == sellingPrice) &&
            (identical(other.feedPrice, feedPrice) ||
                other.feedPrice == feedPrice) &&
            (identical(other.cycleType, cycleType) ||
                other.cycleType == cycleType) &&
            (identical(other.currentDOC, currentDOC) ||
                other.currentDOC == currentDOC) &&
            (identical(other.results, results) || other.results == results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    createdAt,
    commodity,
    cultivationSystem,
    pondArea,
    targetHarvest,
    estimatedADG,
    targetDOC,
    targetSR,
    estimatedFCR,
    targetBiomass,
    sellingPrice,
    feedPrice,
    cycleType,
    currentDOC,
    results,
  );

  /// Create a copy of HarvestSimulation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HarvestSimulationImplCopyWith<_$HarvestSimulationImpl> get copyWith =>
      __$$HarvestSimulationImplCopyWithImpl<_$HarvestSimulationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HarvestSimulationImplToJson(this);
  }
}

abstract class _HarvestSimulation implements HarvestSimulation {
  const factory _HarvestSimulation({
    required final String id,
    required final String name,
    required final DateTime createdAt,
    required final String commodity,
    required final String cultivationSystem,
    required final double pondArea,
    required final double targetHarvest,
    required final double estimatedADG,
    required final int targetDOC,
    required final double targetSR,
    required final double estimatedFCR,
    required final double targetBiomass,
    required final double sellingPrice,
    required final double feedPrice,
    required final String cycleType,
    required final double? currentDOC,
    required final SimulationResults results,
  }) = _$HarvestSimulationImpl;

  factory _HarvestSimulation.fromJson(Map<String, dynamic> json) =
      _$HarvestSimulationImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  DateTime get createdAt;
  @override
  String get commodity;
  @override
  String get cultivationSystem;
  @override
  double get pondArea;
  @override
  double get targetHarvest;
  @override
  double get estimatedADG;
  @override
  int get targetDOC;
  @override
  double get targetSR;
  @override
  double get estimatedFCR;
  @override
  double get targetBiomass;
  @override
  double get sellingPrice;
  @override
  double get feedPrice;
  @override
  String get cycleType;
  @override
  double? get currentDOC;
  @override
  SimulationResults get results;

  /// Create a copy of HarvestSimulation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HarvestSimulationImplCopyWith<_$HarvestSimulationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SimulationResults _$SimulationResultsFromJson(Map<String, dynamic> json) {
  return _SimulationResults.fromJson(json);
}

/// @nodoc
mixin _$SimulationResults {
  double get potentialRevenue => throw _privateConstructorUsedError;
  double get potentialFeedCost => throw _privateConstructorUsedError;
  double get potentialProfit => throw _privateConstructorUsedError;
  double get biomass => throw _privateConstructorUsedError;
  List<BiomassPoint> get biomassPoints => throw _privateConstructorUsedError;
  List<FeedPoint> get feedVsRevenuePoints => throw _privateConstructorUsedError;
  List<SimulationTableRow> get tableRows => throw _privateConstructorUsedError;

  /// Serializes this SimulationResults to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimulationResults
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimulationResultsCopyWith<SimulationResults> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulationResultsCopyWith<$Res> {
  factory $SimulationResultsCopyWith(
    SimulationResults value,
    $Res Function(SimulationResults) then,
  ) = _$SimulationResultsCopyWithImpl<$Res, SimulationResults>;
  @useResult
  $Res call({
    double potentialRevenue,
    double potentialFeedCost,
    double potentialProfit,
    double biomass,
    List<BiomassPoint> biomassPoints,
    List<FeedPoint> feedVsRevenuePoints,
    List<SimulationTableRow> tableRows,
  });
}

/// @nodoc
class _$SimulationResultsCopyWithImpl<$Res, $Val extends SimulationResults>
    implements $SimulationResultsCopyWith<$Res> {
  _$SimulationResultsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimulationResults
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? potentialRevenue = null,
    Object? potentialFeedCost = null,
    Object? potentialProfit = null,
    Object? biomass = null,
    Object? biomassPoints = null,
    Object? feedVsRevenuePoints = null,
    Object? tableRows = null,
  }) {
    return _then(
      _value.copyWith(
            potentialRevenue: null == potentialRevenue
                ? _value.potentialRevenue
                : potentialRevenue // ignore: cast_nullable_to_non_nullable
                      as double,
            potentialFeedCost: null == potentialFeedCost
                ? _value.potentialFeedCost
                : potentialFeedCost // ignore: cast_nullable_to_non_nullable
                      as double,
            potentialProfit: null == potentialProfit
                ? _value.potentialProfit
                : potentialProfit // ignore: cast_nullable_to_non_nullable
                      as double,
            biomass: null == biomass
                ? _value.biomass
                : biomass // ignore: cast_nullable_to_non_nullable
                      as double,
            biomassPoints: null == biomassPoints
                ? _value.biomassPoints
                : biomassPoints // ignore: cast_nullable_to_non_nullable
                      as List<BiomassPoint>,
            feedVsRevenuePoints: null == feedVsRevenuePoints
                ? _value.feedVsRevenuePoints
                : feedVsRevenuePoints // ignore: cast_nullable_to_non_nullable
                      as List<FeedPoint>,
            tableRows: null == tableRows
                ? _value.tableRows
                : tableRows // ignore: cast_nullable_to_non_nullable
                      as List<SimulationTableRow>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SimulationResultsImplCopyWith<$Res>
    implements $SimulationResultsCopyWith<$Res> {
  factory _$$SimulationResultsImplCopyWith(
    _$SimulationResultsImpl value,
    $Res Function(_$SimulationResultsImpl) then,
  ) = __$$SimulationResultsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double potentialRevenue,
    double potentialFeedCost,
    double potentialProfit,
    double biomass,
    List<BiomassPoint> biomassPoints,
    List<FeedPoint> feedVsRevenuePoints,
    List<SimulationTableRow> tableRows,
  });
}

/// @nodoc
class __$$SimulationResultsImplCopyWithImpl<$Res>
    extends _$SimulationResultsCopyWithImpl<$Res, _$SimulationResultsImpl>
    implements _$$SimulationResultsImplCopyWith<$Res> {
  __$$SimulationResultsImplCopyWithImpl(
    _$SimulationResultsImpl _value,
    $Res Function(_$SimulationResultsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationResults
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? potentialRevenue = null,
    Object? potentialFeedCost = null,
    Object? potentialProfit = null,
    Object? biomass = null,
    Object? biomassPoints = null,
    Object? feedVsRevenuePoints = null,
    Object? tableRows = null,
  }) {
    return _then(
      _$SimulationResultsImpl(
        potentialRevenue: null == potentialRevenue
            ? _value.potentialRevenue
            : potentialRevenue // ignore: cast_nullable_to_non_nullable
                  as double,
        potentialFeedCost: null == potentialFeedCost
            ? _value.potentialFeedCost
            : potentialFeedCost // ignore: cast_nullable_to_non_nullable
                  as double,
        potentialProfit: null == potentialProfit
            ? _value.potentialProfit
            : potentialProfit // ignore: cast_nullable_to_non_nullable
                  as double,
        biomass: null == biomass
            ? _value.biomass
            : biomass // ignore: cast_nullable_to_non_nullable
                  as double,
        biomassPoints: null == biomassPoints
            ? _value._biomassPoints
            : biomassPoints // ignore: cast_nullable_to_non_nullable
                  as List<BiomassPoint>,
        feedVsRevenuePoints: null == feedVsRevenuePoints
            ? _value._feedVsRevenuePoints
            : feedVsRevenuePoints // ignore: cast_nullable_to_non_nullable
                  as List<FeedPoint>,
        tableRows: null == tableRows
            ? _value._tableRows
            : tableRows // ignore: cast_nullable_to_non_nullable
                  as List<SimulationTableRow>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SimulationResultsImpl implements _SimulationResults {
  const _$SimulationResultsImpl({
    required this.potentialRevenue,
    required this.potentialFeedCost,
    required this.potentialProfit,
    required this.biomass,
    required final List<BiomassPoint> biomassPoints,
    required final List<FeedPoint> feedVsRevenuePoints,
    required final List<SimulationTableRow> tableRows,
  }) : _biomassPoints = biomassPoints,
       _feedVsRevenuePoints = feedVsRevenuePoints,
       _tableRows = tableRows;

  factory _$SimulationResultsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimulationResultsImplFromJson(json);

  @override
  final double potentialRevenue;
  @override
  final double potentialFeedCost;
  @override
  final double potentialProfit;
  @override
  final double biomass;
  final List<BiomassPoint> _biomassPoints;
  @override
  List<BiomassPoint> get biomassPoints {
    if (_biomassPoints is EqualUnmodifiableListView) return _biomassPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_biomassPoints);
  }

  final List<FeedPoint> _feedVsRevenuePoints;
  @override
  List<FeedPoint> get feedVsRevenuePoints {
    if (_feedVsRevenuePoints is EqualUnmodifiableListView)
      return _feedVsRevenuePoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_feedVsRevenuePoints);
  }

  final List<SimulationTableRow> _tableRows;
  @override
  List<SimulationTableRow> get tableRows {
    if (_tableRows is EqualUnmodifiableListView) return _tableRows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tableRows);
  }

  @override
  String toString() {
    return 'SimulationResults(potentialRevenue: $potentialRevenue, potentialFeedCost: $potentialFeedCost, potentialProfit: $potentialProfit, biomass: $biomass, biomassPoints: $biomassPoints, feedVsRevenuePoints: $feedVsRevenuePoints, tableRows: $tableRows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationResultsImpl &&
            (identical(other.potentialRevenue, potentialRevenue) ||
                other.potentialRevenue == potentialRevenue) &&
            (identical(other.potentialFeedCost, potentialFeedCost) ||
                other.potentialFeedCost == potentialFeedCost) &&
            (identical(other.potentialProfit, potentialProfit) ||
                other.potentialProfit == potentialProfit) &&
            (identical(other.biomass, biomass) || other.biomass == biomass) &&
            const DeepCollectionEquality().equals(
              other._biomassPoints,
              _biomassPoints,
            ) &&
            const DeepCollectionEquality().equals(
              other._feedVsRevenuePoints,
              _feedVsRevenuePoints,
            ) &&
            const DeepCollectionEquality().equals(
              other._tableRows,
              _tableRows,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    potentialRevenue,
    potentialFeedCost,
    potentialProfit,
    biomass,
    const DeepCollectionEquality().hash(_biomassPoints),
    const DeepCollectionEquality().hash(_feedVsRevenuePoints),
    const DeepCollectionEquality().hash(_tableRows),
  );

  /// Create a copy of SimulationResults
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationResultsImplCopyWith<_$SimulationResultsImpl> get copyWith =>
      __$$SimulationResultsImplCopyWithImpl<_$SimulationResultsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SimulationResultsImplToJson(this);
  }
}

abstract class _SimulationResults implements SimulationResults {
  const factory _SimulationResults({
    required final double potentialRevenue,
    required final double potentialFeedCost,
    required final double potentialProfit,
    required final double biomass,
    required final List<BiomassPoint> biomassPoints,
    required final List<FeedPoint> feedVsRevenuePoints,
    required final List<SimulationTableRow> tableRows,
  }) = _$SimulationResultsImpl;

  factory _SimulationResults.fromJson(Map<String, dynamic> json) =
      _$SimulationResultsImpl.fromJson;

  @override
  double get potentialRevenue;
  @override
  double get potentialFeedCost;
  @override
  double get potentialProfit;
  @override
  double get biomass;
  @override
  List<BiomassPoint> get biomassPoints;
  @override
  List<FeedPoint> get feedVsRevenuePoints;
  @override
  List<SimulationTableRow> get tableRows;

  /// Create a copy of SimulationResults
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationResultsImplCopyWith<_$SimulationResultsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
