// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simulation_chart_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BiomassPoint _$BiomassPointFromJson(Map<String, dynamic> json) {
  return _BiomassPoint.fromJson(json);
}

/// @nodoc
mixin _$BiomassPoint {
  int get doc => throw _privateConstructorUsedError;
  double get biomass => throw _privateConstructorUsedError;
  double? get partialHarvest => throw _privateConstructorUsedError;

  /// Serializes this BiomassPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BiomassPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BiomassPointCopyWith<BiomassPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BiomassPointCopyWith<$Res> {
  factory $BiomassPointCopyWith(
    BiomassPoint value,
    $Res Function(BiomassPoint) then,
  ) = _$BiomassPointCopyWithImpl<$Res, BiomassPoint>;
  @useResult
  $Res call({int doc, double biomass, double? partialHarvest});
}

/// @nodoc
class _$BiomassPointCopyWithImpl<$Res, $Val extends BiomassPoint>
    implements $BiomassPointCopyWith<$Res> {
  _$BiomassPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BiomassPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doc = null,
    Object? biomass = null,
    Object? partialHarvest = freezed,
  }) {
    return _then(
      _value.copyWith(
            doc: null == doc
                ? _value.doc
                : doc // ignore: cast_nullable_to_non_nullable
                      as int,
            biomass: null == biomass
                ? _value.biomass
                : biomass // ignore: cast_nullable_to_non_nullable
                      as double,
            partialHarvest: freezed == partialHarvest
                ? _value.partialHarvest
                : partialHarvest // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BiomassPointImplCopyWith<$Res>
    implements $BiomassPointCopyWith<$Res> {
  factory _$$BiomassPointImplCopyWith(
    _$BiomassPointImpl value,
    $Res Function(_$BiomassPointImpl) then,
  ) = __$$BiomassPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int doc, double biomass, double? partialHarvest});
}

/// @nodoc
class __$$BiomassPointImplCopyWithImpl<$Res>
    extends _$BiomassPointCopyWithImpl<$Res, _$BiomassPointImpl>
    implements _$$BiomassPointImplCopyWith<$Res> {
  __$$BiomassPointImplCopyWithImpl(
    _$BiomassPointImpl _value,
    $Res Function(_$BiomassPointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BiomassPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doc = null,
    Object? biomass = null,
    Object? partialHarvest = freezed,
  }) {
    return _then(
      _$BiomassPointImpl(
        doc: null == doc
            ? _value.doc
            : doc // ignore: cast_nullable_to_non_nullable
                  as int,
        biomass: null == biomass
            ? _value.biomass
            : biomass // ignore: cast_nullable_to_non_nullable
                  as double,
        partialHarvest: freezed == partialHarvest
            ? _value.partialHarvest
            : partialHarvest // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BiomassPointImpl implements _BiomassPoint {
  const _$BiomassPointImpl({
    required this.doc,
    required this.biomass,
    required this.partialHarvest,
  });

  factory _$BiomassPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$BiomassPointImplFromJson(json);

  @override
  final int doc;
  @override
  final double biomass;
  @override
  final double? partialHarvest;

  @override
  String toString() {
    return 'BiomassPoint(doc: $doc, biomass: $biomass, partialHarvest: $partialHarvest)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BiomassPointImpl &&
            (identical(other.doc, doc) || other.doc == doc) &&
            (identical(other.biomass, biomass) || other.biomass == biomass) &&
            (identical(other.partialHarvest, partialHarvest) ||
                other.partialHarvest == partialHarvest));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, doc, biomass, partialHarvest);

  /// Create a copy of BiomassPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BiomassPointImplCopyWith<_$BiomassPointImpl> get copyWith =>
      __$$BiomassPointImplCopyWithImpl<_$BiomassPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BiomassPointImplToJson(this);
  }
}

abstract class _BiomassPoint implements BiomassPoint {
  const factory _BiomassPoint({
    required final int doc,
    required final double biomass,
    required final double? partialHarvest,
  }) = _$BiomassPointImpl;

  factory _BiomassPoint.fromJson(Map<String, dynamic> json) =
      _$BiomassPointImpl.fromJson;

  @override
  int get doc;
  @override
  double get biomass;
  @override
  double? get partialHarvest;

  /// Create a copy of BiomassPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BiomassPointImplCopyWith<_$BiomassPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeedPoint _$FeedPointFromJson(Map<String, dynamic> json) {
  return _FeedPoint.fromJson(json);
}

/// @nodoc
mixin _$FeedPoint {
  int get doc => throw _privateConstructorUsedError;
  double get feedCost => throw _privateConstructorUsedError;
  double get revenue => throw _privateConstructorUsedError;

  /// Serializes this FeedPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeedPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedPointCopyWith<FeedPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedPointCopyWith<$Res> {
  factory $FeedPointCopyWith(FeedPoint value, $Res Function(FeedPoint) then) =
      _$FeedPointCopyWithImpl<$Res, FeedPoint>;
  @useResult
  $Res call({int doc, double feedCost, double revenue});
}

/// @nodoc
class _$FeedPointCopyWithImpl<$Res, $Val extends FeedPoint>
    implements $FeedPointCopyWith<$Res> {
  _$FeedPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doc = null,
    Object? feedCost = null,
    Object? revenue = null,
  }) {
    return _then(
      _value.copyWith(
            doc: null == doc
                ? _value.doc
                : doc // ignore: cast_nullable_to_non_nullable
                      as int,
            feedCost: null == feedCost
                ? _value.feedCost
                : feedCost // ignore: cast_nullable_to_non_nullable
                      as double,
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FeedPointImplCopyWith<$Res>
    implements $FeedPointCopyWith<$Res> {
  factory _$$FeedPointImplCopyWith(
    _$FeedPointImpl value,
    $Res Function(_$FeedPointImpl) then,
  ) = __$$FeedPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int doc, double feedCost, double revenue});
}

/// @nodoc
class __$$FeedPointImplCopyWithImpl<$Res>
    extends _$FeedPointCopyWithImpl<$Res, _$FeedPointImpl>
    implements _$$FeedPointImplCopyWith<$Res> {
  __$$FeedPointImplCopyWithImpl(
    _$FeedPointImpl _value,
    $Res Function(_$FeedPointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doc = null,
    Object? feedCost = null,
    Object? revenue = null,
  }) {
    return _then(
      _$FeedPointImpl(
        doc: null == doc
            ? _value.doc
            : doc // ignore: cast_nullable_to_non_nullable
                  as int,
        feedCost: null == feedCost
            ? _value.feedCost
            : feedCost // ignore: cast_nullable_to_non_nullable
                  as double,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedPointImpl implements _FeedPoint {
  const _$FeedPointImpl({
    required this.doc,
    required this.feedCost,
    required this.revenue,
  });

  factory _$FeedPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedPointImplFromJson(json);

  @override
  final int doc;
  @override
  final double feedCost;
  @override
  final double revenue;

  @override
  String toString() {
    return 'FeedPoint(doc: $doc, feedCost: $feedCost, revenue: $revenue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedPointImpl &&
            (identical(other.doc, doc) || other.doc == doc) &&
            (identical(other.feedCost, feedCost) ||
                other.feedCost == feedCost) &&
            (identical(other.revenue, revenue) || other.revenue == revenue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, doc, feedCost, revenue);

  /// Create a copy of FeedPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedPointImplCopyWith<_$FeedPointImpl> get copyWith =>
      __$$FeedPointImplCopyWithImpl<_$FeedPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedPointImplToJson(this);
  }
}

abstract class _FeedPoint implements FeedPoint {
  const factory _FeedPoint({
    required final int doc,
    required final double feedCost,
    required final double revenue,
  }) = _$FeedPointImpl;

  factory _FeedPoint.fromJson(Map<String, dynamic> json) =
      _$FeedPointImpl.fromJson;

  @override
  int get doc;
  @override
  double get feedCost;
  @override
  double get revenue;

  /// Create a copy of FeedPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedPointImplCopyWith<_$FeedPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
