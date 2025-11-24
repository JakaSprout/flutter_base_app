// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'harvest_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HarvestSummary _$HarvestSummaryFromJson(Map<String, dynamic> json) {
  return _HarvestSummary.fromJson(json);
}

/// @nodoc
mixin _$HarvestSummary {
  /// Day of Culture when harvest occurred
  int get doc => throw _privateConstructorUsedError;

  /// Harvest weight (kg)
  double get weight => throw _privateConstructorUsedError;

  /// Revenue from this harvest (Rp)
  double get revenue => throw _privateConstructorUsedError;

  /// Harvest percentage (0-100)
  double get percentage => throw _privateConstructorUsedError;

  /// Description of harvest type (e.g., "Panen 1", "Panen Parsial", "Panen Raya")
  String get description => throw _privateConstructorUsedError;

  /// Cycle mode: Harvest biomass (kg) = biomass before harvest - biomass after harvest
  double? get harvestKg => throw _privateConstructorUsedError;

  /// Cycle mode: Harvest size (individuals/kg) = population at harvest / biomass at harvest
  double? get harvestSize => throw _privateConstructorUsedError;

  /// Cycle mode: Harvest value (Rp) = harvestKg * commodity price per kg
  double? get harvestValueRp => throw _privateConstructorUsedError;

  /// Cycle mode: Feed consumption (kg) from this harvest to next harvest
  double? get feedConsumptionKg => throw _privateConstructorUsedError;

  /// Cycle mode: Feed cost (Rp) = feedConsumptionKg * feed price per kg
  double? get feedConsumptionRp => throw _privateConstructorUsedError;

  /// Serializes this HarvestSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HarvestSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HarvestSummaryCopyWith<HarvestSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HarvestSummaryCopyWith<$Res> {
  factory $HarvestSummaryCopyWith(
    HarvestSummary value,
    $Res Function(HarvestSummary) then,
  ) = _$HarvestSummaryCopyWithImpl<$Res, HarvestSummary>;
  @useResult
  $Res call({
    int doc,
    double weight,
    double revenue,
    double percentage,
    String description,
    double? harvestKg,
    double? harvestSize,
    double? harvestValueRp,
    double? feedConsumptionKg,
    double? feedConsumptionRp,
  });
}

/// @nodoc
class _$HarvestSummaryCopyWithImpl<$Res, $Val extends HarvestSummary>
    implements $HarvestSummaryCopyWith<$Res> {
  _$HarvestSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HarvestSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doc = null,
    Object? weight = null,
    Object? revenue = null,
    Object? percentage = null,
    Object? description = null,
    Object? harvestKg = freezed,
    Object? harvestSize = freezed,
    Object? harvestValueRp = freezed,
    Object? feedConsumptionKg = freezed,
    Object? feedConsumptionRp = freezed,
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
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as double,
            percentage: null == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            harvestKg: freezed == harvestKg
                ? _value.harvestKg
                : harvestKg // ignore: cast_nullable_to_non_nullable
                      as double?,
            harvestSize: freezed == harvestSize
                ? _value.harvestSize
                : harvestSize // ignore: cast_nullable_to_non_nullable
                      as double?,
            harvestValueRp: freezed == harvestValueRp
                ? _value.harvestValueRp
                : harvestValueRp // ignore: cast_nullable_to_non_nullable
                      as double?,
            feedConsumptionKg: freezed == feedConsumptionKg
                ? _value.feedConsumptionKg
                : feedConsumptionKg // ignore: cast_nullable_to_non_nullable
                      as double?,
            feedConsumptionRp: freezed == feedConsumptionRp
                ? _value.feedConsumptionRp
                : feedConsumptionRp // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HarvestSummaryImplCopyWith<$Res>
    implements $HarvestSummaryCopyWith<$Res> {
  factory _$$HarvestSummaryImplCopyWith(
    _$HarvestSummaryImpl value,
    $Res Function(_$HarvestSummaryImpl) then,
  ) = __$$HarvestSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int doc,
    double weight,
    double revenue,
    double percentage,
    String description,
    double? harvestKg,
    double? harvestSize,
    double? harvestValueRp,
    double? feedConsumptionKg,
    double? feedConsumptionRp,
  });
}

/// @nodoc
class __$$HarvestSummaryImplCopyWithImpl<$Res>
    extends _$HarvestSummaryCopyWithImpl<$Res, _$HarvestSummaryImpl>
    implements _$$HarvestSummaryImplCopyWith<$Res> {
  __$$HarvestSummaryImplCopyWithImpl(
    _$HarvestSummaryImpl _value,
    $Res Function(_$HarvestSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HarvestSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doc = null,
    Object? weight = null,
    Object? revenue = null,
    Object? percentage = null,
    Object? description = null,
    Object? harvestKg = freezed,
    Object? harvestSize = freezed,
    Object? harvestValueRp = freezed,
    Object? feedConsumptionKg = freezed,
    Object? feedConsumptionRp = freezed,
  }) {
    return _then(
      _$HarvestSummaryImpl(
        doc: null == doc
            ? _value.doc
            : doc // ignore: cast_nullable_to_non_nullable
                  as int,
        weight: null == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as double,
        percentage: null == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        harvestKg: freezed == harvestKg
            ? _value.harvestKg
            : harvestKg // ignore: cast_nullable_to_non_nullable
                  as double?,
        harvestSize: freezed == harvestSize
            ? _value.harvestSize
            : harvestSize // ignore: cast_nullable_to_non_nullable
                  as double?,
        harvestValueRp: freezed == harvestValueRp
            ? _value.harvestValueRp
            : harvestValueRp // ignore: cast_nullable_to_non_nullable
                  as double?,
        feedConsumptionKg: freezed == feedConsumptionKg
            ? _value.feedConsumptionKg
            : feedConsumptionKg // ignore: cast_nullable_to_non_nullable
                  as double?,
        feedConsumptionRp: freezed == feedConsumptionRp
            ? _value.feedConsumptionRp
            : feedConsumptionRp // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HarvestSummaryImpl implements _HarvestSummary {
  const _$HarvestSummaryImpl({
    required this.doc,
    required this.weight,
    required this.revenue,
    required this.percentage,
    required this.description,
    this.harvestKg,
    this.harvestSize,
    this.harvestValueRp,
    this.feedConsumptionKg,
    this.feedConsumptionRp,
  });

  factory _$HarvestSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$HarvestSummaryImplFromJson(json);

  /// Day of Culture when harvest occurred
  @override
  final int doc;

  /// Harvest weight (kg)
  @override
  final double weight;

  /// Revenue from this harvest (Rp)
  @override
  final double revenue;

  /// Harvest percentage (0-100)
  @override
  final double percentage;

  /// Description of harvest type (e.g., "Panen 1", "Panen Parsial", "Panen Raya")
  @override
  final String description;

  /// Cycle mode: Harvest biomass (kg) = biomass before harvest - biomass after harvest
  @override
  final double? harvestKg;

  /// Cycle mode: Harvest size (individuals/kg) = population at harvest / biomass at harvest
  @override
  final double? harvestSize;

  /// Cycle mode: Harvest value (Rp) = harvestKg * commodity price per kg
  @override
  final double? harvestValueRp;

  /// Cycle mode: Feed consumption (kg) from this harvest to next harvest
  @override
  final double? feedConsumptionKg;

  /// Cycle mode: Feed cost (Rp) = feedConsumptionKg * feed price per kg
  @override
  final double? feedConsumptionRp;

  @override
  String toString() {
    return 'HarvestSummary(doc: $doc, weight: $weight, revenue: $revenue, percentage: $percentage, description: $description, harvestKg: $harvestKg, harvestSize: $harvestSize, harvestValueRp: $harvestValueRp, feedConsumptionKg: $feedConsumptionKg, feedConsumptionRp: $feedConsumptionRp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HarvestSummaryImpl &&
            (identical(other.doc, doc) || other.doc == doc) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.harvestKg, harvestKg) ||
                other.harvestKg == harvestKg) &&
            (identical(other.harvestSize, harvestSize) ||
                other.harvestSize == harvestSize) &&
            (identical(other.harvestValueRp, harvestValueRp) ||
                other.harvestValueRp == harvestValueRp) &&
            (identical(other.feedConsumptionKg, feedConsumptionKg) ||
                other.feedConsumptionKg == feedConsumptionKg) &&
            (identical(other.feedConsumptionRp, feedConsumptionRp) ||
                other.feedConsumptionRp == feedConsumptionRp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    doc,
    weight,
    revenue,
    percentage,
    description,
    harvestKg,
    harvestSize,
    harvestValueRp,
    feedConsumptionKg,
    feedConsumptionRp,
  );

  /// Create a copy of HarvestSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HarvestSummaryImplCopyWith<_$HarvestSummaryImpl> get copyWith =>
      __$$HarvestSummaryImplCopyWithImpl<_$HarvestSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HarvestSummaryImplToJson(this);
  }
}

abstract class _HarvestSummary implements HarvestSummary {
  const factory _HarvestSummary({
    required final int doc,
    required final double weight,
    required final double revenue,
    required final double percentage,
    required final String description,
    final double? harvestKg,
    final double? harvestSize,
    final double? harvestValueRp,
    final double? feedConsumptionKg,
    final double? feedConsumptionRp,
  }) = _$HarvestSummaryImpl;

  factory _HarvestSummary.fromJson(Map<String, dynamic> json) =
      _$HarvestSummaryImpl.fromJson;

  /// Day of Culture when harvest occurred
  @override
  int get doc;

  /// Harvest weight (kg)
  @override
  double get weight;

  /// Revenue from this harvest (Rp)
  @override
  double get revenue;

  /// Harvest percentage (0-100)
  @override
  double get percentage;

  /// Description of harvest type (e.g., "Panen 1", "Panen Parsial", "Panen Raya")
  @override
  String get description;

  /// Cycle mode: Harvest biomass (kg) = biomass before harvest - biomass after harvest
  @override
  double? get harvestKg;

  /// Cycle mode: Harvest size (individuals/kg) = population at harvest / biomass at harvest
  @override
  double? get harvestSize;

  /// Cycle mode: Harvest value (Rp) = harvestKg * commodity price per kg
  @override
  double? get harvestValueRp;

  /// Cycle mode: Feed consumption (kg) from this harvest to next harvest
  @override
  double? get feedConsumptionKg;

  /// Cycle mode: Feed cost (Rp) = feedConsumptionKg * feed price per kg
  @override
  double? get feedConsumptionRp;

  /// Create a copy of HarvestSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HarvestSummaryImplCopyWith<_$HarvestSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
