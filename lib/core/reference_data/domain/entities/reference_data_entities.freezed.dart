// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reference_data_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FarmSummary _$FarmSummaryFromJson(Map<String, dynamic> json) {
  return _FarmSummary.fromJson(json);
}

/// @nodoc
mixin _$FarmSummary {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'farm_name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'farm_code')
  String get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'farm_location')
  String? get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'latitude')
  double? get latitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'longitude')
  double? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'farm_area_sqm')
  double? get area => throw _privateConstructorUsedError;
  String? get areaUnit => throw _privateConstructorUsedError;
  @JsonKey(name: 'owner_name')
  String? get ownerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_info')
  String? get contactInfo => throw _privateConstructorUsedError;
  DateTime? get establishedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this FarmSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FarmSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FarmSummaryCopyWith<FarmSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmSummaryCopyWith<$Res> {
  factory $FarmSummaryCopyWith(
    FarmSummary value,
    $Res Function(FarmSummary) then,
  ) = _$FarmSummaryCopyWithImpl<$Res, FarmSummary>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'farm_name') String name,
    @JsonKey(name: 'farm_code') String code,
    @JsonKey(name: 'farm_location') String? location,
    @JsonKey(name: 'latitude') double? latitude,
    @JsonKey(name: 'longitude') double? longitude,
    @JsonKey(name: 'farm_area_sqm') double? area,
    String? areaUnit,
    @JsonKey(name: 'owner_name') String? ownerName,
    @JsonKey(name: 'contact_info') String? contactInfo,
    DateTime? establishedDate,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$FarmSummaryCopyWithImpl<$Res, $Val extends FarmSummary>
    implements $FarmSummaryCopyWith<$Res> {
  _$FarmSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FarmSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? location = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? area = freezed,
    Object? areaUnit = freezed,
    Object? ownerName = freezed,
    Object? contactInfo = freezed,
    Object? establishedDate = freezed,
    Object? isActive = null,
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
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            area: freezed == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                      as double?,
            areaUnit: freezed == areaUnit
                ? _value.areaUnit
                : areaUnit // ignore: cast_nullable_to_non_nullable
                      as String?,
            ownerName: freezed == ownerName
                ? _value.ownerName
                : ownerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            contactInfo: freezed == contactInfo
                ? _value.contactInfo
                : contactInfo // ignore: cast_nullable_to_non_nullable
                      as String?,
            establishedDate: freezed == establishedDate
                ? _value.establishedDate
                : establishedDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FarmSummaryImplCopyWith<$Res>
    implements $FarmSummaryCopyWith<$Res> {
  factory _$$FarmSummaryImplCopyWith(
    _$FarmSummaryImpl value,
    $Res Function(_$FarmSummaryImpl) then,
  ) = __$$FarmSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'farm_name') String name,
    @JsonKey(name: 'farm_code') String code,
    @JsonKey(name: 'farm_location') String? location,
    @JsonKey(name: 'latitude') double? latitude,
    @JsonKey(name: 'longitude') double? longitude,
    @JsonKey(name: 'farm_area_sqm') double? area,
    String? areaUnit,
    @JsonKey(name: 'owner_name') String? ownerName,
    @JsonKey(name: 'contact_info') String? contactInfo,
    DateTime? establishedDate,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$FarmSummaryImplCopyWithImpl<$Res>
    extends _$FarmSummaryCopyWithImpl<$Res, _$FarmSummaryImpl>
    implements _$$FarmSummaryImplCopyWith<$Res> {
  __$$FarmSummaryImplCopyWithImpl(
    _$FarmSummaryImpl _value,
    $Res Function(_$FarmSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FarmSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? location = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? area = freezed,
    Object? areaUnit = freezed,
    Object? ownerName = freezed,
    Object? contactInfo = freezed,
    Object? establishedDate = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$FarmSummaryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        area: freezed == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as double?,
        areaUnit: freezed == areaUnit
            ? _value.areaUnit
            : areaUnit // ignore: cast_nullable_to_non_nullable
                  as String?,
        ownerName: freezed == ownerName
            ? _value.ownerName
            : ownerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        contactInfo: freezed == contactInfo
            ? _value.contactInfo
            : contactInfo // ignore: cast_nullable_to_non_nullable
                  as String?,
        establishedDate: freezed == establishedDate
            ? _value.establishedDate
            : establishedDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FarmSummaryImpl implements _FarmSummary {
  const _$FarmSummaryImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'farm_name') required this.name,
    @JsonKey(name: 'farm_code') required this.code,
    @JsonKey(name: 'farm_location') this.location,
    @JsonKey(name: 'latitude') this.latitude,
    @JsonKey(name: 'longitude') this.longitude,
    @JsonKey(name: 'farm_area_sqm') this.area,
    this.areaUnit,
    @JsonKey(name: 'owner_name') this.ownerName,
    @JsonKey(name: 'contact_info') this.contactInfo,
    this.establishedDate,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$FarmSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$FarmSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'farm_name')
  final String name;
  @override
  @JsonKey(name: 'farm_code')
  final String code;
  @override
  @JsonKey(name: 'farm_location')
  final String? location;
  @override
  @JsonKey(name: 'latitude')
  final double? latitude;
  @override
  @JsonKey(name: 'longitude')
  final double? longitude;
  @override
  @JsonKey(name: 'farm_area_sqm')
  final double? area;
  @override
  final String? areaUnit;
  @override
  @JsonKey(name: 'owner_name')
  final String? ownerName;
  @override
  @JsonKey(name: 'contact_info')
  final String? contactInfo;
  @override
  final DateTime? establishedDate;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'FarmSummary(id: $id, name: $name, code: $code, location: $location, latitude: $latitude, longitude: $longitude, area: $area, areaUnit: $areaUnit, ownerName: $ownerName, contactInfo: $contactInfo, establishedDate: $establishedDate, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.areaUnit, areaUnit) ||
                other.areaUnit == areaUnit) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.contactInfo, contactInfo) ||
                other.contactInfo == contactInfo) &&
            (identical(other.establishedDate, establishedDate) ||
                other.establishedDate == establishedDate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    code,
    location,
    latitude,
    longitude,
    area,
    areaUnit,
    ownerName,
    contactInfo,
    establishedDate,
    isActive,
  );

  /// Create a copy of FarmSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmSummaryImplCopyWith<_$FarmSummaryImpl> get copyWith =>
      __$$FarmSummaryImplCopyWithImpl<_$FarmSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FarmSummaryImplToJson(this);
  }
}

abstract class _FarmSummary implements FarmSummary {
  const factory _FarmSummary({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'farm_name') required final String name,
    @JsonKey(name: 'farm_code') required final String code,
    @JsonKey(name: 'farm_location') final String? location,
    @JsonKey(name: 'latitude') final double? latitude,
    @JsonKey(name: 'longitude') final double? longitude,
    @JsonKey(name: 'farm_area_sqm') final double? area,
    final String? areaUnit,
    @JsonKey(name: 'owner_name') final String? ownerName,
    @JsonKey(name: 'contact_info') final String? contactInfo,
    final DateTime? establishedDate,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$FarmSummaryImpl;

  factory _FarmSummary.fromJson(Map<String, dynamic> json) =
      _$FarmSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'farm_name')
  String get name;
  @override
  @JsonKey(name: 'farm_code')
  String get code;
  @override
  @JsonKey(name: 'farm_location')
  String? get location;
  @override
  @JsonKey(name: 'latitude')
  double? get latitude;
  @override
  @JsonKey(name: 'longitude')
  double? get longitude;
  @override
  @JsonKey(name: 'farm_area_sqm')
  double? get area;
  @override
  String? get areaUnit;
  @override
  @JsonKey(name: 'owner_name')
  String? get ownerName;
  @override
  @JsonKey(name: 'contact_info')
  String? get contactInfo;
  @override
  DateTime? get establishedDate;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of FarmSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FarmSummaryImplCopyWith<_$FarmSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PondSummary {
  String get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get farmId => throw _privateConstructorUsedError;
  String? get farmName => throw _privateConstructorUsedError;
  double? get size => throw _privateConstructorUsedError;
  String? get sizeUnit => throw _privateConstructorUsedError;
  double? get pwa => throw _privateConstructorUsedError;
  String? get pwaUnit => throw _privateConstructorUsedError;
  double? get depth => throw _privateConstructorUsedError;
  String? get depthUnit => throw _privateConstructorUsedError;
  double? get maxDepth => throw _privateConstructorUsedError;
  String? get maxDepthUnit => throw _privateConstructorUsedError;
  double? get volume => throw _privateConstructorUsedError;
  String? get volumeUnit => throw _privateConstructorUsedError;
  String? get pondType => throw _privateConstructorUsedError;
  String? get pondShape => throw _privateConstructorUsedError;
  String? get bottomType => throw _privateConstructorUsedError;
  bool? get hasAerator => throw _privateConstructorUsedError;
  int? get aeratorCount => throw _privateConstructorUsedError;
  double? get aeratorTotalHp => throw _privateConstructorUsedError;
  bool? get hasCentralDrain => throw _privateConstructorUsedError;
  String? get waterSource => throw _privateConstructorUsedError;
  String? get pondStatus => throw _privateConstructorUsedError;
  int? get currentCycleId => throw _privateConstructorUsedError;
  double? get maxBiomass => throw _privateConstructorUsedError;
  String? get maxBiomassUnit => throw _privateConstructorUsedError;
  double? get recommendedStockingDensity => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  /// Create a copy of PondSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PondSummaryCopyWith<PondSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PondSummaryCopyWith<$Res> {
  factory $PondSummaryCopyWith(
    PondSummary value,
    $Res Function(PondSummary) then,
  ) = _$PondSummaryCopyWithImpl<$Res, PondSummary>;
  @useResult
  $Res call({
    String id,
    String code,
    String? name,
    String? farmId,
    String? farmName,
    double? size,
    String? sizeUnit,
    double? pwa,
    String? pwaUnit,
    double? depth,
    String? depthUnit,
    double? maxDepth,
    String? maxDepthUnit,
    double? volume,
    String? volumeUnit,
    String? pondType,
    String? pondShape,
    String? bottomType,
    bool? hasAerator,
    int? aeratorCount,
    double? aeratorTotalHp,
    bool? hasCentralDrain,
    String? waterSource,
    String? pondStatus,
    int? currentCycleId,
    double? maxBiomass,
    String? maxBiomassUnit,
    double? recommendedStockingDensity,
    bool isActive,
    DateTime? createdAt,
    DateTime? deletedAt,
  });
}

/// @nodoc
class _$PondSummaryCopyWithImpl<$Res, $Val extends PondSummary>
    implements $PondSummaryCopyWith<$Res> {
  _$PondSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PondSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? name = freezed,
    Object? farmId = freezed,
    Object? farmName = freezed,
    Object? size = freezed,
    Object? sizeUnit = freezed,
    Object? pwa = freezed,
    Object? pwaUnit = freezed,
    Object? depth = freezed,
    Object? depthUnit = freezed,
    Object? maxDepth = freezed,
    Object? maxDepthUnit = freezed,
    Object? volume = freezed,
    Object? volumeUnit = freezed,
    Object? pondType = freezed,
    Object? pondShape = freezed,
    Object? bottomType = freezed,
    Object? hasAerator = freezed,
    Object? aeratorCount = freezed,
    Object? aeratorTotalHp = freezed,
    Object? hasCentralDrain = freezed,
    Object? waterSource = freezed,
    Object? pondStatus = freezed,
    Object? currentCycleId = freezed,
    Object? maxBiomass = freezed,
    Object? maxBiomassUnit = freezed,
    Object? recommendedStockingDensity = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            farmId: freezed == farmId
                ? _value.farmId
                : farmId // ignore: cast_nullable_to_non_nullable
                      as String?,
            farmName: freezed == farmName
                ? _value.farmName
                : farmName // ignore: cast_nullable_to_non_nullable
                      as String?,
            size: freezed == size
                ? _value.size
                : size // ignore: cast_nullable_to_non_nullable
                      as double?,
            sizeUnit: freezed == sizeUnit
                ? _value.sizeUnit
                : sizeUnit // ignore: cast_nullable_to_non_nullable
                      as String?,
            pwa: freezed == pwa
                ? _value.pwa
                : pwa // ignore: cast_nullable_to_non_nullable
                      as double?,
            pwaUnit: freezed == pwaUnit
                ? _value.pwaUnit
                : pwaUnit // ignore: cast_nullable_to_non_nullable
                      as String?,
            depth: freezed == depth
                ? _value.depth
                : depth // ignore: cast_nullable_to_non_nullable
                      as double?,
            depthUnit: freezed == depthUnit
                ? _value.depthUnit
                : depthUnit // ignore: cast_nullable_to_non_nullable
                      as String?,
            maxDepth: freezed == maxDepth
                ? _value.maxDepth
                : maxDepth // ignore: cast_nullable_to_non_nullable
                      as double?,
            maxDepthUnit: freezed == maxDepthUnit
                ? _value.maxDepthUnit
                : maxDepthUnit // ignore: cast_nullable_to_non_nullable
                      as String?,
            volume: freezed == volume
                ? _value.volume
                : volume // ignore: cast_nullable_to_non_nullable
                      as double?,
            volumeUnit: freezed == volumeUnit
                ? _value.volumeUnit
                : volumeUnit // ignore: cast_nullable_to_non_nullable
                      as String?,
            pondType: freezed == pondType
                ? _value.pondType
                : pondType // ignore: cast_nullable_to_non_nullable
                      as String?,
            pondShape: freezed == pondShape
                ? _value.pondShape
                : pondShape // ignore: cast_nullable_to_non_nullable
                      as String?,
            bottomType: freezed == bottomType
                ? _value.bottomType
                : bottomType // ignore: cast_nullable_to_non_nullable
                      as String?,
            hasAerator: freezed == hasAerator
                ? _value.hasAerator
                : hasAerator // ignore: cast_nullable_to_non_nullable
                      as bool?,
            aeratorCount: freezed == aeratorCount
                ? _value.aeratorCount
                : aeratorCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            aeratorTotalHp: freezed == aeratorTotalHp
                ? _value.aeratorTotalHp
                : aeratorTotalHp // ignore: cast_nullable_to_non_nullable
                      as double?,
            hasCentralDrain: freezed == hasCentralDrain
                ? _value.hasCentralDrain
                : hasCentralDrain // ignore: cast_nullable_to_non_nullable
                      as bool?,
            waterSource: freezed == waterSource
                ? _value.waterSource
                : waterSource // ignore: cast_nullable_to_non_nullable
                      as String?,
            pondStatus: freezed == pondStatus
                ? _value.pondStatus
                : pondStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentCycleId: freezed == currentCycleId
                ? _value.currentCycleId
                : currentCycleId // ignore: cast_nullable_to_non_nullable
                      as int?,
            maxBiomass: freezed == maxBiomass
                ? _value.maxBiomass
                : maxBiomass // ignore: cast_nullable_to_non_nullable
                      as double?,
            maxBiomassUnit: freezed == maxBiomassUnit
                ? _value.maxBiomassUnit
                : maxBiomassUnit // ignore: cast_nullable_to_non_nullable
                      as String?,
            recommendedStockingDensity: freezed == recommendedStockingDensity
                ? _value.recommendedStockingDensity
                : recommendedStockingDensity // ignore: cast_nullable_to_non_nullable
                      as double?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            deletedAt: freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PondSummaryImplCopyWith<$Res>
    implements $PondSummaryCopyWith<$Res> {
  factory _$$PondSummaryImplCopyWith(
    _$PondSummaryImpl value,
    $Res Function(_$PondSummaryImpl) then,
  ) = __$$PondSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String code,
    String? name,
    String? farmId,
    String? farmName,
    double? size,
    String? sizeUnit,
    double? pwa,
    String? pwaUnit,
    double? depth,
    String? depthUnit,
    double? maxDepth,
    String? maxDepthUnit,
    double? volume,
    String? volumeUnit,
    String? pondType,
    String? pondShape,
    String? bottomType,
    bool? hasAerator,
    int? aeratorCount,
    double? aeratorTotalHp,
    bool? hasCentralDrain,
    String? waterSource,
    String? pondStatus,
    int? currentCycleId,
    double? maxBiomass,
    String? maxBiomassUnit,
    double? recommendedStockingDensity,
    bool isActive,
    DateTime? createdAt,
    DateTime? deletedAt,
  });
}

/// @nodoc
class __$$PondSummaryImplCopyWithImpl<$Res>
    extends _$PondSummaryCopyWithImpl<$Res, _$PondSummaryImpl>
    implements _$$PondSummaryImplCopyWith<$Res> {
  __$$PondSummaryImplCopyWithImpl(
    _$PondSummaryImpl _value,
    $Res Function(_$PondSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PondSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? name = freezed,
    Object? farmId = freezed,
    Object? farmName = freezed,
    Object? size = freezed,
    Object? sizeUnit = freezed,
    Object? pwa = freezed,
    Object? pwaUnit = freezed,
    Object? depth = freezed,
    Object? depthUnit = freezed,
    Object? maxDepth = freezed,
    Object? maxDepthUnit = freezed,
    Object? volume = freezed,
    Object? volumeUnit = freezed,
    Object? pondType = freezed,
    Object? pondShape = freezed,
    Object? bottomType = freezed,
    Object? hasAerator = freezed,
    Object? aeratorCount = freezed,
    Object? aeratorTotalHp = freezed,
    Object? hasCentralDrain = freezed,
    Object? waterSource = freezed,
    Object? pondStatus = freezed,
    Object? currentCycleId = freezed,
    Object? maxBiomass = freezed,
    Object? maxBiomassUnit = freezed,
    Object? recommendedStockingDensity = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _$PondSummaryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        farmId: freezed == farmId
            ? _value.farmId
            : farmId // ignore: cast_nullable_to_non_nullable
                  as String?,
        farmName: freezed == farmName
            ? _value.farmName
            : farmName // ignore: cast_nullable_to_non_nullable
                  as String?,
        size: freezed == size
            ? _value.size
            : size // ignore: cast_nullable_to_non_nullable
                  as double?,
        sizeUnit: freezed == sizeUnit
            ? _value.sizeUnit
            : sizeUnit // ignore: cast_nullable_to_non_nullable
                  as String?,
        pwa: freezed == pwa
            ? _value.pwa
            : pwa // ignore: cast_nullable_to_non_nullable
                  as double?,
        pwaUnit: freezed == pwaUnit
            ? _value.pwaUnit
            : pwaUnit // ignore: cast_nullable_to_non_nullable
                  as String?,
        depth: freezed == depth
            ? _value.depth
            : depth // ignore: cast_nullable_to_non_nullable
                  as double?,
        depthUnit: freezed == depthUnit
            ? _value.depthUnit
            : depthUnit // ignore: cast_nullable_to_non_nullable
                  as String?,
        maxDepth: freezed == maxDepth
            ? _value.maxDepth
            : maxDepth // ignore: cast_nullable_to_non_nullable
                  as double?,
        maxDepthUnit: freezed == maxDepthUnit
            ? _value.maxDepthUnit
            : maxDepthUnit // ignore: cast_nullable_to_non_nullable
                  as String?,
        volume: freezed == volume
            ? _value.volume
            : volume // ignore: cast_nullable_to_non_nullable
                  as double?,
        volumeUnit: freezed == volumeUnit
            ? _value.volumeUnit
            : volumeUnit // ignore: cast_nullable_to_non_nullable
                  as String?,
        pondType: freezed == pondType
            ? _value.pondType
            : pondType // ignore: cast_nullable_to_non_nullable
                  as String?,
        pondShape: freezed == pondShape
            ? _value.pondShape
            : pondShape // ignore: cast_nullable_to_non_nullable
                  as String?,
        bottomType: freezed == bottomType
            ? _value.bottomType
            : bottomType // ignore: cast_nullable_to_non_nullable
                  as String?,
        hasAerator: freezed == hasAerator
            ? _value.hasAerator
            : hasAerator // ignore: cast_nullable_to_non_nullable
                  as bool?,
        aeratorCount: freezed == aeratorCount
            ? _value.aeratorCount
            : aeratorCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        aeratorTotalHp: freezed == aeratorTotalHp
            ? _value.aeratorTotalHp
            : aeratorTotalHp // ignore: cast_nullable_to_non_nullable
                  as double?,
        hasCentralDrain: freezed == hasCentralDrain
            ? _value.hasCentralDrain
            : hasCentralDrain // ignore: cast_nullable_to_non_nullable
                  as bool?,
        waterSource: freezed == waterSource
            ? _value.waterSource
            : waterSource // ignore: cast_nullable_to_non_nullable
                  as String?,
        pondStatus: freezed == pondStatus
            ? _value.pondStatus
            : pondStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentCycleId: freezed == currentCycleId
            ? _value.currentCycleId
            : currentCycleId // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxBiomass: freezed == maxBiomass
            ? _value.maxBiomass
            : maxBiomass // ignore: cast_nullable_to_non_nullable
                  as double?,
        maxBiomassUnit: freezed == maxBiomassUnit
            ? _value.maxBiomassUnit
            : maxBiomassUnit // ignore: cast_nullable_to_non_nullable
                  as String?,
        recommendedStockingDensity: freezed == recommendedStockingDensity
            ? _value.recommendedStockingDensity
            : recommendedStockingDensity // ignore: cast_nullable_to_non_nullable
                  as double?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        deletedAt: freezed == deletedAt
            ? _value.deletedAt
            : deletedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$PondSummaryImpl implements _PondSummary {
  const _$PondSummaryImpl({
    required this.id,
    required this.code,
    this.name,
    this.farmId,
    this.farmName,
    this.size,
    this.sizeUnit,
    this.pwa,
    this.pwaUnit,
    this.depth,
    this.depthUnit,
    this.maxDepth,
    this.maxDepthUnit,
    this.volume,
    this.volumeUnit,
    this.pondType,
    this.pondShape,
    this.bottomType,
    this.hasAerator,
    this.aeratorCount,
    this.aeratorTotalHp,
    this.hasCentralDrain,
    this.waterSource,
    this.pondStatus,
    this.currentCycleId,
    this.maxBiomass,
    this.maxBiomassUnit,
    this.recommendedStockingDensity,
    this.isActive = true,
    this.createdAt,
    this.deletedAt,
  });

  @override
  final String id;
  @override
  final String code;
  @override
  final String? name;
  @override
  final String? farmId;
  @override
  final String? farmName;
  @override
  final double? size;
  @override
  final String? sizeUnit;
  @override
  final double? pwa;
  @override
  final String? pwaUnit;
  @override
  final double? depth;
  @override
  final String? depthUnit;
  @override
  final double? maxDepth;
  @override
  final String? maxDepthUnit;
  @override
  final double? volume;
  @override
  final String? volumeUnit;
  @override
  final String? pondType;
  @override
  final String? pondShape;
  @override
  final String? bottomType;
  @override
  final bool? hasAerator;
  @override
  final int? aeratorCount;
  @override
  final double? aeratorTotalHp;
  @override
  final bool? hasCentralDrain;
  @override
  final String? waterSource;
  @override
  final String? pondStatus;
  @override
  final int? currentCycleId;
  @override
  final double? maxBiomass;
  @override
  final String? maxBiomassUnit;
  @override
  final double? recommendedStockingDensity;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'PondSummary(id: $id, code: $code, name: $name, farmId: $farmId, farmName: $farmName, size: $size, sizeUnit: $sizeUnit, pwa: $pwa, pwaUnit: $pwaUnit, depth: $depth, depthUnit: $depthUnit, maxDepth: $maxDepth, maxDepthUnit: $maxDepthUnit, volume: $volume, volumeUnit: $volumeUnit, pondType: $pondType, pondShape: $pondShape, bottomType: $bottomType, hasAerator: $hasAerator, aeratorCount: $aeratorCount, aeratorTotalHp: $aeratorTotalHp, hasCentralDrain: $hasCentralDrain, waterSource: $waterSource, pondStatus: $pondStatus, currentCycleId: $currentCycleId, maxBiomass: $maxBiomass, maxBiomassUnit: $maxBiomassUnit, recommendedStockingDensity: $recommendedStockingDensity, isActive: $isActive, createdAt: $createdAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PondSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.farmId, farmId) || other.farmId == farmId) &&
            (identical(other.farmName, farmName) ||
                other.farmName == farmName) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.sizeUnit, sizeUnit) ||
                other.sizeUnit == sizeUnit) &&
            (identical(other.pwa, pwa) || other.pwa == pwa) &&
            (identical(other.pwaUnit, pwaUnit) || other.pwaUnit == pwaUnit) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.depthUnit, depthUnit) ||
                other.depthUnit == depthUnit) &&
            (identical(other.maxDepth, maxDepth) ||
                other.maxDepth == maxDepth) &&
            (identical(other.maxDepthUnit, maxDepthUnit) ||
                other.maxDepthUnit == maxDepthUnit) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.volumeUnit, volumeUnit) ||
                other.volumeUnit == volumeUnit) &&
            (identical(other.pondType, pondType) ||
                other.pondType == pondType) &&
            (identical(other.pondShape, pondShape) ||
                other.pondShape == pondShape) &&
            (identical(other.bottomType, bottomType) ||
                other.bottomType == bottomType) &&
            (identical(other.hasAerator, hasAerator) ||
                other.hasAerator == hasAerator) &&
            (identical(other.aeratorCount, aeratorCount) ||
                other.aeratorCount == aeratorCount) &&
            (identical(other.aeratorTotalHp, aeratorTotalHp) ||
                other.aeratorTotalHp == aeratorTotalHp) &&
            (identical(other.hasCentralDrain, hasCentralDrain) ||
                other.hasCentralDrain == hasCentralDrain) &&
            (identical(other.waterSource, waterSource) ||
                other.waterSource == waterSource) &&
            (identical(other.pondStatus, pondStatus) ||
                other.pondStatus == pondStatus) &&
            (identical(other.currentCycleId, currentCycleId) ||
                other.currentCycleId == currentCycleId) &&
            (identical(other.maxBiomass, maxBiomass) ||
                other.maxBiomass == maxBiomass) &&
            (identical(other.maxBiomassUnit, maxBiomassUnit) ||
                other.maxBiomassUnit == maxBiomassUnit) &&
            (identical(
                  other.recommendedStockingDensity,
                  recommendedStockingDensity,
                ) ||
                other.recommendedStockingDensity ==
                    recommendedStockingDensity) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    code,
    name,
    farmId,
    farmName,
    size,
    sizeUnit,
    pwa,
    pwaUnit,
    depth,
    depthUnit,
    maxDepth,
    maxDepthUnit,
    volume,
    volumeUnit,
    pondType,
    pondShape,
    bottomType,
    hasAerator,
    aeratorCount,
    aeratorTotalHp,
    hasCentralDrain,
    waterSource,
    pondStatus,
    currentCycleId,
    maxBiomass,
    maxBiomassUnit,
    recommendedStockingDensity,
    isActive,
    createdAt,
    deletedAt,
  ]);

  /// Create a copy of PondSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PondSummaryImplCopyWith<_$PondSummaryImpl> get copyWith =>
      __$$PondSummaryImplCopyWithImpl<_$PondSummaryImpl>(this, _$identity);
}

abstract class _PondSummary implements PondSummary {
  const factory _PondSummary({
    required final String id,
    required final String code,
    final String? name,
    final String? farmId,
    final String? farmName,
    final double? size,
    final String? sizeUnit,
    final double? pwa,
    final String? pwaUnit,
    final double? depth,
    final String? depthUnit,
    final double? maxDepth,
    final String? maxDepthUnit,
    final double? volume,
    final String? volumeUnit,
    final String? pondType,
    final String? pondShape,
    final String? bottomType,
    final bool? hasAerator,
    final int? aeratorCount,
    final double? aeratorTotalHp,
    final bool? hasCentralDrain,
    final String? waterSource,
    final String? pondStatus,
    final int? currentCycleId,
    final double? maxBiomass,
    final String? maxBiomassUnit,
    final double? recommendedStockingDensity,
    final bool isActive,
    final DateTime? createdAt,
    final DateTime? deletedAt,
  }) = _$PondSummaryImpl;

  @override
  String get id;
  @override
  String get code;
  @override
  String? get name;
  @override
  String? get farmId;
  @override
  String? get farmName;
  @override
  double? get size;
  @override
  String? get sizeUnit;
  @override
  double? get pwa;
  @override
  String? get pwaUnit;
  @override
  double? get depth;
  @override
  String? get depthUnit;
  @override
  double? get maxDepth;
  @override
  String? get maxDepthUnit;
  @override
  double? get volume;
  @override
  String? get volumeUnit;
  @override
  String? get pondType;
  @override
  String? get pondShape;
  @override
  String? get bottomType;
  @override
  bool? get hasAerator;
  @override
  int? get aeratorCount;
  @override
  double? get aeratorTotalHp;
  @override
  bool? get hasCentralDrain;
  @override
  String? get waterSource;
  @override
  String? get pondStatus;
  @override
  int? get currentCycleId;
  @override
  double? get maxBiomass;
  @override
  String? get maxBiomassUnit;
  @override
  double? get recommendedStockingDensity;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get deletedAt;

  /// Create a copy of PondSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PondSummaryImplCopyWith<_$PondSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EmployeeSummary {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  String? get department => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Create a copy of EmployeeSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmployeeSummaryCopyWith<EmployeeSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeSummaryCopyWith<$Res> {
  factory $EmployeeSummaryCopyWith(
    EmployeeSummary value,
    $Res Function(EmployeeSummary) then,
  ) = _$EmployeeSummaryCopyWithImpl<$Res, EmployeeSummary>;
  @useResult
  $Res call({
    String id,
    String name,
    String code,
    String? username,
    String? email,
    String? phoneNumber,
    String? role,
    String? department,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool isActive,
  });
}

/// @nodoc
class _$EmployeeSummaryCopyWithImpl<$Res, $Val extends EmployeeSummary>
    implements $EmployeeSummaryCopyWith<$Res> {
  _$EmployeeSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmployeeSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? username = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? role = freezed,
    Object? department = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isActive = null,
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
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
            department: freezed == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmployeeSummaryImplCopyWith<$Res>
    implements $EmployeeSummaryCopyWith<$Res> {
  factory _$$EmployeeSummaryImplCopyWith(
    _$EmployeeSummaryImpl value,
    $Res Function(_$EmployeeSummaryImpl) then,
  ) = __$$EmployeeSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String code,
    String? username,
    String? email,
    String? phoneNumber,
    String? role,
    String? department,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool isActive,
  });
}

/// @nodoc
class __$$EmployeeSummaryImplCopyWithImpl<$Res>
    extends _$EmployeeSummaryCopyWithImpl<$Res, _$EmployeeSummaryImpl>
    implements _$$EmployeeSummaryImplCopyWith<$Res> {
  __$$EmployeeSummaryImplCopyWithImpl(
    _$EmployeeSummaryImpl _value,
    $Res Function(_$EmployeeSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? username = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? role = freezed,
    Object? department = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$EmployeeSummaryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
        department: freezed == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$EmployeeSummaryImpl implements _EmployeeSummary {
  const _$EmployeeSummaryImpl({
    required this.id,
    required this.name,
    required this.code,
    this.username,
    this.email,
    this.phoneNumber,
    this.role,
    this.department,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final String code;
  @override
  final String? username;
  @override
  final String? email;
  @override
  final String? phoneNumber;
  @override
  final String? role;
  @override
  final String? department;
  @override
  final String? status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'EmployeeSummary(id: $id, name: $name, code: $code, username: $username, email: $email, phoneNumber: $phoneNumber, role: $role, department: $department, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    code,
    username,
    email,
    phoneNumber,
    role,
    department,
    status,
    createdAt,
    updatedAt,
    isActive,
  );

  /// Create a copy of EmployeeSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeSummaryImplCopyWith<_$EmployeeSummaryImpl> get copyWith =>
      __$$EmployeeSummaryImplCopyWithImpl<_$EmployeeSummaryImpl>(
        this,
        _$identity,
      );
}

abstract class _EmployeeSummary implements EmployeeSummary {
  const factory _EmployeeSummary({
    required final String id,
    required final String name,
    required final String code,
    final String? username,
    final String? email,
    final String? phoneNumber,
    final String? role,
    final String? department,
    final String? status,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final bool isActive,
  }) = _$EmployeeSummaryImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get code;
  @override
  String? get username;
  @override
  String? get email;
  @override
  String? get phoneNumber;
  @override
  String? get role;
  @override
  String? get department;
  @override
  String? get status;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  bool get isActive;

  /// Create a copy of EmployeeSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeSummaryImplCopyWith<_$EmployeeSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomerSummary _$CustomerSummaryFromJson(Map<String, dynamic> json) {
  return _CustomerSummary.fromJson(json);
}

/// @nodoc
mixin _$CustomerSummary {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String? get contactInfo => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this CustomerSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerSummaryCopyWith<CustomerSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerSummaryCopyWith<$Res> {
  factory $CustomerSummaryCopyWith(
    CustomerSummary value,
    $Res Function(CustomerSummary) then,
  ) = _$CustomerSummaryCopyWithImpl<$Res, CustomerSummary>;
  @useResult
  $Res call({
    String id,
    String name,
    String code,
    String? contactInfo,
    String? address,
    String? phoneNumber,
    String? email,
    bool isActive,
  });
}

/// @nodoc
class _$CustomerSummaryCopyWithImpl<$Res, $Val extends CustomerSummary>
    implements $CustomerSummaryCopyWith<$Res> {
  _$CustomerSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? contactInfo = freezed,
    Object? address = freezed,
    Object? phoneNumber = freezed,
    Object? email = freezed,
    Object? isActive = null,
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
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            contactInfo: freezed == contactInfo
                ? _value.contactInfo
                : contactInfo // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CustomerSummaryImplCopyWith<$Res>
    implements $CustomerSummaryCopyWith<$Res> {
  factory _$$CustomerSummaryImplCopyWith(
    _$CustomerSummaryImpl value,
    $Res Function(_$CustomerSummaryImpl) then,
  ) = __$$CustomerSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String code,
    String? contactInfo,
    String? address,
    String? phoneNumber,
    String? email,
    bool isActive,
  });
}

/// @nodoc
class __$$CustomerSummaryImplCopyWithImpl<$Res>
    extends _$CustomerSummaryCopyWithImpl<$Res, _$CustomerSummaryImpl>
    implements _$$CustomerSummaryImplCopyWith<$Res> {
  __$$CustomerSummaryImplCopyWithImpl(
    _$CustomerSummaryImpl _value,
    $Res Function(_$CustomerSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? contactInfo = freezed,
    Object? address = freezed,
    Object? phoneNumber = freezed,
    Object? email = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$CustomerSummaryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        contactInfo: freezed == contactInfo
            ? _value.contactInfo
            : contactInfo // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerSummaryImpl implements _CustomerSummary {
  const _$CustomerSummaryImpl({
    required this.id,
    required this.name,
    required this.code,
    this.contactInfo,
    this.address,
    this.phoneNumber,
    this.email,
    this.isActive = true,
  });

  factory _$CustomerSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String code;
  @override
  final String? contactInfo;
  @override
  final String? address;
  @override
  final String? phoneNumber;
  @override
  final String? email;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'CustomerSummary(id: $id, name: $name, code: $code, contactInfo: $contactInfo, address: $address, phoneNumber: $phoneNumber, email: $email, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.contactInfo, contactInfo) ||
                other.contactInfo == contactInfo) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    code,
    contactInfo,
    address,
    phoneNumber,
    email,
    isActive,
  );

  /// Create a copy of CustomerSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerSummaryImplCopyWith<_$CustomerSummaryImpl> get copyWith =>
      __$$CustomerSummaryImplCopyWithImpl<_$CustomerSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerSummaryImplToJson(this);
  }
}

abstract class _CustomerSummary implements CustomerSummary {
  const factory _CustomerSummary({
    required final String id,
    required final String name,
    required final String code,
    final String? contactInfo,
    final String? address,
    final String? phoneNumber,
    final String? email,
    final bool isActive,
  }) = _$CustomerSummaryImpl;

  factory _CustomerSummary.fromJson(Map<String, dynamic> json) =
      _$CustomerSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get code;
  @override
  String? get contactInfo;
  @override
  String? get address;
  @override
  String? get phoneNumber;
  @override
  String? get email;
  @override
  bool get isActive;

  /// Create a copy of CustomerSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerSummaryImplCopyWith<_$CustomerSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CapacityReference _$CapacityReferenceFromJson(Map<String, dynamic> json) {
  return _CapacityReference.fromJson(json);
}

/// @nodoc
mixin _$CapacityReference {
  String get id => throw _privateConstructorUsedError;
  String get commodityCode => throw _privateConstructorUsedError;
  String get commodityName => throw _privateConstructorUsedError;
  String? get possibleTechnology => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get intensityLevel => throw _privateConstructorUsedError;
  double? get maxCapacity => throw _privateConstructorUsedError;
  String? get maxCapacityUnit => throw _privateConstructorUsedError;
  double? get maxCapacityKgPerSqm => throw _privateConstructorUsedError;
  String? get maxCapacityNotes => throw _privateConstructorUsedError;
  String? get scientificReferences => throw _privateConstructorUsedError;
  List<String>? get referenceUrls => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this CapacityReference to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CapacityReference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CapacityReferenceCopyWith<CapacityReference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CapacityReferenceCopyWith<$Res> {
  factory $CapacityReferenceCopyWith(
    CapacityReference value,
    $Res Function(CapacityReference) then,
  ) = _$CapacityReferenceCopyWithImpl<$Res, CapacityReference>;
  @useResult
  $Res call({
    String id,
    String commodityCode,
    String commodityName,
    String? possibleTechnology,
    String? category,
    String? intensityLevel,
    double? maxCapacity,
    String? maxCapacityUnit,
    double? maxCapacityKgPerSqm,
    String? maxCapacityNotes,
    String? scientificReferences,
    List<String>? referenceUrls,
    bool isActive,
  });
}

/// @nodoc
class _$CapacityReferenceCopyWithImpl<$Res, $Val extends CapacityReference>
    implements $CapacityReferenceCopyWith<$Res> {
  _$CapacityReferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CapacityReference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? commodityCode = null,
    Object? commodityName = null,
    Object? possibleTechnology = freezed,
    Object? category = freezed,
    Object? intensityLevel = freezed,
    Object? maxCapacity = freezed,
    Object? maxCapacityUnit = freezed,
    Object? maxCapacityKgPerSqm = freezed,
    Object? maxCapacityNotes = freezed,
    Object? scientificReferences = freezed,
    Object? referenceUrls = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            commodityCode: null == commodityCode
                ? _value.commodityCode
                : commodityCode // ignore: cast_nullable_to_non_nullable
                      as String,
            commodityName: null == commodityName
                ? _value.commodityName
                : commodityName // ignore: cast_nullable_to_non_nullable
                      as String,
            possibleTechnology: freezed == possibleTechnology
                ? _value.possibleTechnology
                : possibleTechnology // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            intensityLevel: freezed == intensityLevel
                ? _value.intensityLevel
                : intensityLevel // ignore: cast_nullable_to_non_nullable
                      as String?,
            maxCapacity: freezed == maxCapacity
                ? _value.maxCapacity
                : maxCapacity // ignore: cast_nullable_to_non_nullable
                      as double?,
            maxCapacityUnit: freezed == maxCapacityUnit
                ? _value.maxCapacityUnit
                : maxCapacityUnit // ignore: cast_nullable_to_non_nullable
                      as String?,
            maxCapacityKgPerSqm: freezed == maxCapacityKgPerSqm
                ? _value.maxCapacityKgPerSqm
                : maxCapacityKgPerSqm // ignore: cast_nullable_to_non_nullable
                      as double?,
            maxCapacityNotes: freezed == maxCapacityNotes
                ? _value.maxCapacityNotes
                : maxCapacityNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            scientificReferences: freezed == scientificReferences
                ? _value.scientificReferences
                : scientificReferences // ignore: cast_nullable_to_non_nullable
                      as String?,
            referenceUrls: freezed == referenceUrls
                ? _value.referenceUrls
                : referenceUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CapacityReferenceImplCopyWith<$Res>
    implements $CapacityReferenceCopyWith<$Res> {
  factory _$$CapacityReferenceImplCopyWith(
    _$CapacityReferenceImpl value,
    $Res Function(_$CapacityReferenceImpl) then,
  ) = __$$CapacityReferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String commodityCode,
    String commodityName,
    String? possibleTechnology,
    String? category,
    String? intensityLevel,
    double? maxCapacity,
    String? maxCapacityUnit,
    double? maxCapacityKgPerSqm,
    String? maxCapacityNotes,
    String? scientificReferences,
    List<String>? referenceUrls,
    bool isActive,
  });
}

/// @nodoc
class __$$CapacityReferenceImplCopyWithImpl<$Res>
    extends _$CapacityReferenceCopyWithImpl<$Res, _$CapacityReferenceImpl>
    implements _$$CapacityReferenceImplCopyWith<$Res> {
  __$$CapacityReferenceImplCopyWithImpl(
    _$CapacityReferenceImpl _value,
    $Res Function(_$CapacityReferenceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CapacityReference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? commodityCode = null,
    Object? commodityName = null,
    Object? possibleTechnology = freezed,
    Object? category = freezed,
    Object? intensityLevel = freezed,
    Object? maxCapacity = freezed,
    Object? maxCapacityUnit = freezed,
    Object? maxCapacityKgPerSqm = freezed,
    Object? maxCapacityNotes = freezed,
    Object? scientificReferences = freezed,
    Object? referenceUrls = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$CapacityReferenceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        commodityCode: null == commodityCode
            ? _value.commodityCode
            : commodityCode // ignore: cast_nullable_to_non_nullable
                  as String,
        commodityName: null == commodityName
            ? _value.commodityName
            : commodityName // ignore: cast_nullable_to_non_nullable
                  as String,
        possibleTechnology: freezed == possibleTechnology
            ? _value.possibleTechnology
            : possibleTechnology // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        intensityLevel: freezed == intensityLevel
            ? _value.intensityLevel
            : intensityLevel // ignore: cast_nullable_to_non_nullable
                  as String?,
        maxCapacity: freezed == maxCapacity
            ? _value.maxCapacity
            : maxCapacity // ignore: cast_nullable_to_non_nullable
                  as double?,
        maxCapacityUnit: freezed == maxCapacityUnit
            ? _value.maxCapacityUnit
            : maxCapacityUnit // ignore: cast_nullable_to_non_nullable
                  as String?,
        maxCapacityKgPerSqm: freezed == maxCapacityKgPerSqm
            ? _value.maxCapacityKgPerSqm
            : maxCapacityKgPerSqm // ignore: cast_nullable_to_non_nullable
                  as double?,
        maxCapacityNotes: freezed == maxCapacityNotes
            ? _value.maxCapacityNotes
            : maxCapacityNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        scientificReferences: freezed == scientificReferences
            ? _value.scientificReferences
            : scientificReferences // ignore: cast_nullable_to_non_nullable
                  as String?,
        referenceUrls: freezed == referenceUrls
            ? _value._referenceUrls
            : referenceUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CapacityReferenceImpl implements _CapacityReference {
  const _$CapacityReferenceImpl({
    required this.id,
    required this.commodityCode,
    required this.commodityName,
    this.possibleTechnology,
    this.category,
    this.intensityLevel,
    this.maxCapacity,
    this.maxCapacityUnit,
    this.maxCapacityKgPerSqm,
    this.maxCapacityNotes,
    this.scientificReferences,
    final List<String>? referenceUrls,
    this.isActive = true,
  }) : _referenceUrls = referenceUrls;

  factory _$CapacityReferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$CapacityReferenceImplFromJson(json);

  @override
  final String id;
  @override
  final String commodityCode;
  @override
  final String commodityName;
  @override
  final String? possibleTechnology;
  @override
  final String? category;
  @override
  final String? intensityLevel;
  @override
  final double? maxCapacity;
  @override
  final String? maxCapacityUnit;
  @override
  final double? maxCapacityKgPerSqm;
  @override
  final String? maxCapacityNotes;
  @override
  final String? scientificReferences;
  final List<String>? _referenceUrls;
  @override
  List<String>? get referenceUrls {
    final value = _referenceUrls;
    if (value == null) return null;
    if (_referenceUrls is EqualUnmodifiableListView) return _referenceUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'CapacityReference(id: $id, commodityCode: $commodityCode, commodityName: $commodityName, possibleTechnology: $possibleTechnology, category: $category, intensityLevel: $intensityLevel, maxCapacity: $maxCapacity, maxCapacityUnit: $maxCapacityUnit, maxCapacityKgPerSqm: $maxCapacityKgPerSqm, maxCapacityNotes: $maxCapacityNotes, scientificReferences: $scientificReferences, referenceUrls: $referenceUrls, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CapacityReferenceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.commodityCode, commodityCode) ||
                other.commodityCode == commodityCode) &&
            (identical(other.commodityName, commodityName) ||
                other.commodityName == commodityName) &&
            (identical(other.possibleTechnology, possibleTechnology) ||
                other.possibleTechnology == possibleTechnology) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.intensityLevel, intensityLevel) ||
                other.intensityLevel == intensityLevel) &&
            (identical(other.maxCapacity, maxCapacity) ||
                other.maxCapacity == maxCapacity) &&
            (identical(other.maxCapacityUnit, maxCapacityUnit) ||
                other.maxCapacityUnit == maxCapacityUnit) &&
            (identical(other.maxCapacityKgPerSqm, maxCapacityKgPerSqm) ||
                other.maxCapacityKgPerSqm == maxCapacityKgPerSqm) &&
            (identical(other.maxCapacityNotes, maxCapacityNotes) ||
                other.maxCapacityNotes == maxCapacityNotes) &&
            (identical(other.scientificReferences, scientificReferences) ||
                other.scientificReferences == scientificReferences) &&
            const DeepCollectionEquality().equals(
              other._referenceUrls,
              _referenceUrls,
            ) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    commodityCode,
    commodityName,
    possibleTechnology,
    category,
    intensityLevel,
    maxCapacity,
    maxCapacityUnit,
    maxCapacityKgPerSqm,
    maxCapacityNotes,
    scientificReferences,
    const DeepCollectionEquality().hash(_referenceUrls),
    isActive,
  );

  /// Create a copy of CapacityReference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CapacityReferenceImplCopyWith<_$CapacityReferenceImpl> get copyWith =>
      __$$CapacityReferenceImplCopyWithImpl<_$CapacityReferenceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CapacityReferenceImplToJson(this);
  }
}

abstract class _CapacityReference implements CapacityReference {
  const factory _CapacityReference({
    required final String id,
    required final String commodityCode,
    required final String commodityName,
    final String? possibleTechnology,
    final String? category,
    final String? intensityLevel,
    final double? maxCapacity,
    final String? maxCapacityUnit,
    final double? maxCapacityKgPerSqm,
    final String? maxCapacityNotes,
    final String? scientificReferences,
    final List<String>? referenceUrls,
    final bool isActive,
  }) = _$CapacityReferenceImpl;

  factory _CapacityReference.fromJson(Map<String, dynamic> json) =
      _$CapacityReferenceImpl.fromJson;

  @override
  String get id;
  @override
  String get commodityCode;
  @override
  String get commodityName;
  @override
  String? get possibleTechnology;
  @override
  String? get category;
  @override
  String? get intensityLevel;
  @override
  double? get maxCapacity;
  @override
  String? get maxCapacityUnit;
  @override
  double? get maxCapacityKgPerSqm;
  @override
  String? get maxCapacityNotes;
  @override
  String? get scientificReferences;
  @override
  List<String>? get referenceUrls;
  @override
  bool get isActive;

  /// Create a copy of CapacityReference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CapacityReferenceImplCopyWith<_$CapacityReferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UnitEntity _$UnitEntityFromJson(Map<String, dynamic> json) {
  return _UnitEntity.fromJson(json);
}

/// @nodoc
mixin _$UnitEntity {
  String get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get symbol => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool? get isBaseUnit => throw _privateConstructorUsedError;
  String? get baseUnitCode => throw _privateConstructorUsedError;
  double? get conversionFactor => throw _privateConstructorUsedError;
  bool? get isDynamic => throw _privateConstructorUsedError;
  bool? get isMetric => throw _privateConstructorUsedError;
  int? get displayDecimals => throw _privateConstructorUsedError;
  int? get sortOrder => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this UnitEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UnitEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnitEntityCopyWith<UnitEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitEntityCopyWith<$Res> {
  factory $UnitEntityCopyWith(
    UnitEntity value,
    $Res Function(UnitEntity) then,
  ) = _$UnitEntityCopyWithImpl<$Res, UnitEntity>;
  @useResult
  $Res call({
    String id,
    String code,
    String category,
    String? name,
    String? symbol,
    String? description,
    bool? isBaseUnit,
    String? baseUnitCode,
    double? conversionFactor,
    bool? isDynamic,
    bool? isMetric,
    int? displayDecimals,
    int? sortOrder,
    bool isActive,
  });
}

/// @nodoc
class _$UnitEntityCopyWithImpl<$Res, $Val extends UnitEntity>
    implements $UnitEntityCopyWith<$Res> {
  _$UnitEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnitEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? category = null,
    Object? name = freezed,
    Object? symbol = freezed,
    Object? description = freezed,
    Object? isBaseUnit = freezed,
    Object? baseUnitCode = freezed,
    Object? conversionFactor = freezed,
    Object? isDynamic = freezed,
    Object? isMetric = freezed,
    Object? displayDecimals = freezed,
    Object? sortOrder = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            symbol: freezed == symbol
                ? _value.symbol
                : symbol // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            isBaseUnit: freezed == isBaseUnit
                ? _value.isBaseUnit
                : isBaseUnit // ignore: cast_nullable_to_non_nullable
                      as bool?,
            baseUnitCode: freezed == baseUnitCode
                ? _value.baseUnitCode
                : baseUnitCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            conversionFactor: freezed == conversionFactor
                ? _value.conversionFactor
                : conversionFactor // ignore: cast_nullable_to_non_nullable
                      as double?,
            isDynamic: freezed == isDynamic
                ? _value.isDynamic
                : isDynamic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isMetric: freezed == isMetric
                ? _value.isMetric
                : isMetric // ignore: cast_nullable_to_non_nullable
                      as bool?,
            displayDecimals: freezed == displayDecimals
                ? _value.displayDecimals
                : displayDecimals // ignore: cast_nullable_to_non_nullable
                      as int?,
            sortOrder: freezed == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UnitEntityImplCopyWith<$Res>
    implements $UnitEntityCopyWith<$Res> {
  factory _$$UnitEntityImplCopyWith(
    _$UnitEntityImpl value,
    $Res Function(_$UnitEntityImpl) then,
  ) = __$$UnitEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String code,
    String category,
    String? name,
    String? symbol,
    String? description,
    bool? isBaseUnit,
    String? baseUnitCode,
    double? conversionFactor,
    bool? isDynamic,
    bool? isMetric,
    int? displayDecimals,
    int? sortOrder,
    bool isActive,
  });
}

/// @nodoc
class __$$UnitEntityImplCopyWithImpl<$Res>
    extends _$UnitEntityCopyWithImpl<$Res, _$UnitEntityImpl>
    implements _$$UnitEntityImplCopyWith<$Res> {
  __$$UnitEntityImplCopyWithImpl(
    _$UnitEntityImpl _value,
    $Res Function(_$UnitEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UnitEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? category = null,
    Object? name = freezed,
    Object? symbol = freezed,
    Object? description = freezed,
    Object? isBaseUnit = freezed,
    Object? baseUnitCode = freezed,
    Object? conversionFactor = freezed,
    Object? isDynamic = freezed,
    Object? isMetric = freezed,
    Object? displayDecimals = freezed,
    Object? sortOrder = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$UnitEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        symbol: freezed == symbol
            ? _value.symbol
            : symbol // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        isBaseUnit: freezed == isBaseUnit
            ? _value.isBaseUnit
            : isBaseUnit // ignore: cast_nullable_to_non_nullable
                  as bool?,
        baseUnitCode: freezed == baseUnitCode
            ? _value.baseUnitCode
            : baseUnitCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        conversionFactor: freezed == conversionFactor
            ? _value.conversionFactor
            : conversionFactor // ignore: cast_nullable_to_non_nullable
                  as double?,
        isDynamic: freezed == isDynamic
            ? _value.isDynamic
            : isDynamic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isMetric: freezed == isMetric
            ? _value.isMetric
            : isMetric // ignore: cast_nullable_to_non_nullable
                  as bool?,
        displayDecimals: freezed == displayDecimals
            ? _value.displayDecimals
            : displayDecimals // ignore: cast_nullable_to_non_nullable
                  as int?,
        sortOrder: freezed == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UnitEntityImpl implements _UnitEntity {
  const _$UnitEntityImpl({
    required this.id,
    required this.code,
    required this.category,
    this.name,
    this.symbol,
    this.description,
    this.isBaseUnit,
    this.baseUnitCode,
    this.conversionFactor,
    this.isDynamic,
    this.isMetric,
    this.displayDecimals,
    this.sortOrder,
    this.isActive = true,
  });

  factory _$UnitEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnitEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String code;
  @override
  final String category;
  @override
  final String? name;
  @override
  final String? symbol;
  @override
  final String? description;
  @override
  final bool? isBaseUnit;
  @override
  final String? baseUnitCode;
  @override
  final double? conversionFactor;
  @override
  final bool? isDynamic;
  @override
  final bool? isMetric;
  @override
  final int? displayDecimals;
  @override
  final int? sortOrder;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'UnitEntity(id: $id, code: $code, category: $category, name: $name, symbol: $symbol, description: $description, isBaseUnit: $isBaseUnit, baseUnitCode: $baseUnitCode, conversionFactor: $conversionFactor, isDynamic: $isDynamic, isMetric: $isMetric, displayDecimals: $displayDecimals, sortOrder: $sortOrder, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnitEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isBaseUnit, isBaseUnit) ||
                other.isBaseUnit == isBaseUnit) &&
            (identical(other.baseUnitCode, baseUnitCode) ||
                other.baseUnitCode == baseUnitCode) &&
            (identical(other.conversionFactor, conversionFactor) ||
                other.conversionFactor == conversionFactor) &&
            (identical(other.isDynamic, isDynamic) ||
                other.isDynamic == isDynamic) &&
            (identical(other.isMetric, isMetric) ||
                other.isMetric == isMetric) &&
            (identical(other.displayDecimals, displayDecimals) ||
                other.displayDecimals == displayDecimals) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    code,
    category,
    name,
    symbol,
    description,
    isBaseUnit,
    baseUnitCode,
    conversionFactor,
    isDynamic,
    isMetric,
    displayDecimals,
    sortOrder,
    isActive,
  );

  /// Create a copy of UnitEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnitEntityImplCopyWith<_$UnitEntityImpl> get copyWith =>
      __$$UnitEntityImplCopyWithImpl<_$UnitEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnitEntityImplToJson(this);
  }
}

abstract class _UnitEntity implements UnitEntity {
  const factory _UnitEntity({
    required final String id,
    required final String code,
    required final String category,
    final String? name,
    final String? symbol,
    final String? description,
    final bool? isBaseUnit,
    final String? baseUnitCode,
    final double? conversionFactor,
    final bool? isDynamic,
    final bool? isMetric,
    final int? displayDecimals,
    final int? sortOrder,
    final bool isActive,
  }) = _$UnitEntityImpl;

  factory _UnitEntity.fromJson(Map<String, dynamic> json) =
      _$UnitEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get code;
  @override
  String get category;
  @override
  String? get name;
  @override
  String? get symbol;
  @override
  String? get description;
  @override
  bool? get isBaseUnit;
  @override
  String? get baseUnitCode;
  @override
  double? get conversionFactor;
  @override
  bool? get isDynamic;
  @override
  bool? get isMetric;
  @override
  int? get displayDecimals;
  @override
  int? get sortOrder;
  @override
  bool get isActive;

  /// Create a copy of UnitEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnitEntityImplCopyWith<_$UnitEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LabTestTypeEntity {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  int? get turnaroundDays => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Create a copy of LabTestTypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LabTestTypeEntityCopyWith<LabTestTypeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabTestTypeEntityCopyWith<$Res> {
  factory $LabTestTypeEntityCopyWith(
    LabTestTypeEntity value,
    $Res Function(LabTestTypeEntity) then,
  ) = _$LabTestTypeEntityCopyWithImpl<$Res, LabTestTypeEntity>;
  @useResult
  $Res call({
    String code,
    String name,
    String? description,
    String? category,
    int? turnaroundDays,
    bool isActive,
  });
}

/// @nodoc
class _$LabTestTypeEntityCopyWithImpl<$Res, $Val extends LabTestTypeEntity>
    implements $LabTestTypeEntityCopyWith<$Res> {
  _$LabTestTypeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LabTestTypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? description = freezed,
    Object? category = freezed,
    Object? turnaroundDays = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            turnaroundDays: freezed == turnaroundDays
                ? _value.turnaroundDays
                : turnaroundDays // ignore: cast_nullable_to_non_nullable
                      as int?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LabTestTypeEntityImplCopyWith<$Res>
    implements $LabTestTypeEntityCopyWith<$Res> {
  factory _$$LabTestTypeEntityImplCopyWith(
    _$LabTestTypeEntityImpl value,
    $Res Function(_$LabTestTypeEntityImpl) then,
  ) = __$$LabTestTypeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String code,
    String name,
    String? description,
    String? category,
    int? turnaroundDays,
    bool isActive,
  });
}

/// @nodoc
class __$$LabTestTypeEntityImplCopyWithImpl<$Res>
    extends _$LabTestTypeEntityCopyWithImpl<$Res, _$LabTestTypeEntityImpl>
    implements _$$LabTestTypeEntityImplCopyWith<$Res> {
  __$$LabTestTypeEntityImplCopyWithImpl(
    _$LabTestTypeEntityImpl _value,
    $Res Function(_$LabTestTypeEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LabTestTypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? description = freezed,
    Object? category = freezed,
    Object? turnaroundDays = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$LabTestTypeEntityImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        turnaroundDays: freezed == turnaroundDays
            ? _value.turnaroundDays
            : turnaroundDays // ignore: cast_nullable_to_non_nullable
                  as int?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$LabTestTypeEntityImpl implements _LabTestTypeEntity {
  const _$LabTestTypeEntityImpl({
    required this.code,
    required this.name,
    this.description,
    this.category,
    this.turnaroundDays,
    this.isActive = true,
  });

  @override
  final String code;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? category;
  @override
  final int? turnaroundDays;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'LabTestTypeEntity(code: $code, name: $name, description: $description, category: $category, turnaroundDays: $turnaroundDays, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LabTestTypeEntityImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.turnaroundDays, turnaroundDays) ||
                other.turnaroundDays == turnaroundDays) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    name,
    description,
    category,
    turnaroundDays,
    isActive,
  );

  /// Create a copy of LabTestTypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LabTestTypeEntityImplCopyWith<_$LabTestTypeEntityImpl> get copyWith =>
      __$$LabTestTypeEntityImplCopyWithImpl<_$LabTestTypeEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _LabTestTypeEntity implements LabTestTypeEntity {
  const factory _LabTestTypeEntity({
    required final String code,
    required final String name,
    final String? description,
    final String? category,
    final int? turnaroundDays,
    final bool isActive,
  }) = _$LabTestTypeEntityImpl;

  @override
  String get code;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get category;
  @override
  int? get turnaroundDays;
  @override
  bool get isActive;

  /// Create a copy of LabTestTypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LabTestTypeEntityImplCopyWith<_$LabTestTypeEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
