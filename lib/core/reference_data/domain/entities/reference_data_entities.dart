import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reference_data_entities.freezed.dart';
part 'reference_data_entities.g.dart';

// Helper function to convert id from int to String
String _idFromJson(dynamic id) {
  if (id is int) {
    return id.toString();
  } else if (id is String) {
    return id;
  } else {
    throw ArgumentError('id must be int or String, got ${id.runtimeType}: $id');
  }
}

int? _intFromJson(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  throw ArgumentError('Cannot convert ${value.runtimeType} to int: $value');
}

/// Farm summary entity for displaying farm information.
/// Based on schema.sql - fms_mt_farms
@freezed
@JsonSerializable()
class FarmSummary with _$FarmSummary {
  const factory FarmSummary({
    @JsonKey(name: 'id', fromJson: _idFromJson) required String id,
    @JsonKey(name: 'farm_name') required String name,
    @JsonKey(name: 'farm_code') required String code,
    @JsonKey(name: 'farm_uuid') String? farmUuid,
    @JsonKey(name: 'farm_location') String? location,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'farm_area_sqm') double? area,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default('sqm')
    String? areaUnit,
    @JsonKey(name: 'owner_name') String? ownerName,
    @JsonKey(name: 'contact_info') String? contactInfo,
    DateTime? establishedDate,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdDate,
    @JsonKey(name: 'created_by', fromJson: _intFromJson) int? createdBy,
    @JsonKey(name: 'last_updated_date') DateTime? lastUpdatedDate,
    @JsonKey(name: 'last_updated_by', fromJson: _intFromJson) int? lastUpdatedBy,
  }) = _FarmSummary;

  /// Custom fromJson with error logging
  factory FarmSummary.fromJson(Map<String, dynamic> json) {
    try {
      return _$FarmSummaryFromJson(json);
    } catch (e) {
      // Log detailed information about the JSON and error
      AppLogger.error('FarmSummary.fromJson failed', e);
      AppLogger.error('JSON data: $json');
      AppLogger.error(
        'JSON types: ${json.map((k, v) => MapEntry(k, v.runtimeType))}',
      );
      rethrow;
    }
  }

  factory FarmSummary.fromLocal(Map<String, dynamic> data) {
    return FarmSummary(
      id: data['farm_id'].toString(),
      farmUuid: data['farm_uuid'] as String?,
      name: data['farm_name'] as String,
      code: data['farm_code'] as String,
      location: data['farm_location'] as String?,
      latitude: data['latitude'] as double?,
      longitude: data['longitude'] as double?,
      area: data['farm_area'] as double?,
      areaUnit: data['farm_area_unit'] as String?,
      ownerName: data['owner_name'] as String?,
      contactInfo: data['contact_info'] as String?,
      establishedDate: data['established_date'] != null
          ? DateTime.parse(data['established_date'] as String)
          : null,
      isActive: data['is_active'] as bool? ?? true,
      createdDate: data['created_date'] != null
          ? DateTime.parse(data['created_date'] as String)
          : null,
      createdBy: data['created_by'] as int?,
      lastUpdatedDate: data['last_updated_date'] != null
          ? DateTime.parse(data['last_updated_date'] as String)
          : null,
      lastUpdatedBy: data['last_updated_by'] as int?,
    );
  }
}

/// Pond summary entity for displaying pond information.
/// Based on schema.sql - fms_mt_ponds
@freezed
class PondSummary with _$PondSummary {
  const factory PondSummary({
    required String id,
    required String code,
    String? pondUuid,
    String? name,
    String? pondType,
    String? pondShape,
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
    String? bottomType,
    @Default(false) bool hasAerator,
    int? aeratorCount,
    double? aeratorTotalHp,
    @Default(false) bool hasCentralDrain,
    String? waterSource,
    String? pondStatus,
    int? currentCycleId,
    double? maxBiomassKgPerSqm,
    double? recommendedStockingDensity,
    @Default(true) bool isActive,
    DateTime? createdDate,
    int? createdBy,
    DateTime? lastUpdatedDate,
    int? lastUpdatedBy,
    DateTime? deletedDate,
    double? maxBiomass,
    String? maxBiomassUnit,
    int? farmId,
    String? farmUuid,
  }) = _PondSummary;

  factory PondSummary.fromJson(Map<String, dynamic> json) {
    return PondSummary(
      id: json['id'].toString(),
      pondUuid: json['pond_uuid'] as String?,
      code: json['pond_code'] as String,
      name: json['pond_name'] as String?,
      pondType: json['pond_type'] as String?,
      pondShape: json['pond_shape'] as String?,
      size: (json['pond_size'] as num?)?.toDouble(),
      sizeUnit: json['pond_size_unit'] as String?,
      pwa: (json['pwa'] as num?)?.toDouble(),
      pwaUnit: json['pwa_unit'] as String?,
      depth: (json['depth'] as num?)?.toDouble(),
      depthUnit: json['depth_unit'] as String?,
      maxDepth: (json['max_depth'] as num?)?.toDouble(),
      maxDepthUnit: json['max_depth_unit'] as String?,
      volume: (json['volume'] as num?)?.toDouble(),
      volumeUnit: json['volume_unit'] as String?,
      bottomType: json['bottom_type'] as String?,
      hasAerator: json['has_aerator'] as bool? ?? false,
      aeratorCount: json['aerator_count'] as int?,
      aeratorTotalHp: (json['aerator_total_hp'] as num?)?.toDouble(),
      hasCentralDrain: json['has_central_drain'] as bool? ?? false,
      waterSource: json['water_source'] as String?,
      pondStatus: json['pond_status'] as String?,
      currentCycleId: json['current_cycle_id'] as int?,
      maxBiomassKgPerSqm: (json['max_biomass_kg_per_sqm'] as num?)?.toDouble(),
      recommendedStockingDensity: (json['recommended_stocking_density'] as num?)
          ?.toDouble(),
      isActive: json['is_active'] as bool? ?? true,
      createdDate: json['created_date'] != null
          ? DateTime.parse(json['created_date'] as String)
          : null,
      createdBy: json['created_by'] as int?,
      lastUpdatedDate: json['last_updated_date'] != null
          ? DateTime.parse(json['last_updated_date'] as String)
          : null,
      lastUpdatedBy: json['last_updated_by'] as int?,
      deletedDate: json['deleted_date'] != null
          ? DateTime.parse(json['deleted_date'] as String)
          : null,
      maxBiomass: (json['max_biomass'] as num?)?.toDouble(),
      maxBiomassUnit: json['max_biomass_unit'] as String?,
      farmId: json['farm_id'] as int?,
      farmUuid: json['farm_uuid'] as String?,
    );
  }

  factory PondSummary.fromLocal(Map<String, dynamic> data) {
    return PondSummary(
      id: data['pond_id'].toString(),
      pondUuid: data['pond_uuid'] as String?,
      code: data['pond_code'] as String,
      name: data['pond_name'] as String?,
      pondType: data['pond_type'] as String?,
      pondShape: data['pond_shape'] as String?,
      size: data['pond_size'] as double?,
      sizeUnit: data['pond_size_unit'] as String?,
      pwa: data['pwa'] as double?,
      pwaUnit: data['pwa_unit'] as String?,
      depth: data['depth'] as double?,
      depthUnit: data['depth_unit'] as String?,
      maxDepth: data['max_depth'] as double?,
      maxDepthUnit: data['max_depth_unit'] as String?,
      volume: data['volume'] as double?,
      volumeUnit: data['volume_unit'] as String?,
      bottomType: data['bottom_type'] as String?,
      hasAerator: data['has_aerator'] as bool? ?? false,
      aeratorCount: data['aerator_count'] as int?,
      aeratorTotalHp: data['aerator_total_hp'] as double?,
      hasCentralDrain: data['has_central_drain'] as bool? ?? false,
      waterSource: data['water_source'] as String?,
      pondStatus: data['pond_status'] as String?,
      currentCycleId: data['current_cycle_id'] as int?,
      maxBiomassKgPerSqm: data['max_biomass_kg_per_sqm'] as double?,
      recommendedStockingDensity:
          data['recommended_stocking_density'] as double?,
      isActive: data['is_active'] as bool? ?? true,
      createdDate: data['created_date'] != null
          ? DateTime.parse(data['created_date'] as String)
          : null,
      createdBy: data['created_by'] as int?,
      lastUpdatedDate: data['last_updated_date'] != null
          ? DateTime.parse(data['last_updated_date'] as String)
          : null,
      lastUpdatedBy: data['last_updated_by'] as int?,
      deletedDate: data['deleted_date'] != null
          ? DateTime.parse(data['deleted_date'] as String)
          : null,
      maxBiomass: data['max_biomass'] as double?,
      maxBiomassUnit: data['max_biomass_unit'] as String?,
      farmId: data['farm_id'] as int?,
      farmUuid: data['farm_uuid'] as String?,
    );
  }
}

/// Employee summary entity for displaying employee information.
@freezed
class EmployeeSummary with _$EmployeeSummary {
  const factory EmployeeSummary({
    required String id,
    required String name,
    required String code,
    String? username,
    String? email,
    String? phoneNumber,
    String? role,
    String? department,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(true) bool isActive,
  }) = _EmployeeSummary;

  factory EmployeeSummary.fromJson(Map<String, dynamic> json) {
    return EmployeeSummary(
      id: json['id'].toString(),
      name: json['employeeName'] as String,
      code: json['employeeCode'] as String,
      username: json['username'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['contactInfo'] as String?,
      role: json['employeeRole'] as String?,
      status: json['employeeStatus'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  factory EmployeeSummary.fromLocal(Map<String, dynamic> data) {
    return EmployeeSummary(
      id: data['employee_id'].toString(),
      name: data['employee_name'] as String,
      code: data['employee_code'] as String,
      username: data['username'] as String?,
      email: data['email'] as String?,
      phoneNumber: data['phone_number'] as String?,
      role: data['employee_role'] as String?,
      department: data['department'] as String?,
      status: data['employee_status'] as String?,
      isActive: data['employee_status'] == 'Active',
    );
  }
}

/// Customer summary entity for displaying customer information.
@freezed
class CustomerSummary with _$CustomerSummary {
  const factory CustomerSummary({
    required String id,
    required String name,
    required String code,
    String? contactInfo,
    String? address,
    String? phoneNumber,
    String? email,
    @Default(true) bool isActive,
  }) = _CustomerSummary;

  factory CustomerSummary.fromJson(Map<String, dynamic> json) =>
      _$CustomerSummaryFromJson(json);

  factory CustomerSummary.fromLocal(Map<String, dynamic> data) {
    return CustomerSummary(
      id: data['customer_id'].toString(),
      name: data['customer_name'] as String,
      code: data['customer_code'] as String,
      contactInfo: data['contact_info'] as String?,
      address: data['address'] as String?,
      phoneNumber: data['phone_number'] as String?,
      email: data['email'] as String?,
      isActive: data['is_active'] as bool? ?? true,
    );
  }
}

/// Capacity reference entity for commodity-specific harvest capacity parameters.
@freezed
class CapacityReference with _$CapacityReference {
  const factory CapacityReference({
    required String id,
    required String commodityCode,
    required String commodityName,
    String? possibleTechnology,
    String? category,
    String? intensityLevel,
    double? maxCapacity,
    String? maxCapacityUnit,
    double? maxCapacityKgPerSqm,
    String? maxCapacityNotes,
    String? scientificReferences,
    List<String>? referenceUrls,
    @Default(true) bool isActive,
  }) = _CapacityReference;

  factory CapacityReference.fromJson(Map<String, dynamic> json) =>
      _$CapacityReferenceFromJson(json);

  factory CapacityReference.fromLocal(Map<String, dynamic> data) {
    return CapacityReference(
      id: data['capacity_ref_id'].toString(),
      commodityCode: data['commodity_code'] as String,
      commodityName: data['commodity_name'] as String,
      possibleTechnology: data['possible_technology'] as String?,
      category: data['category'] as String?,
      intensityLevel: data['intensity_level'] as String?,
      maxCapacity: data['max_capacity'] as double?,
      maxCapacityUnit: data['max_capacity_unit'] as String?,
      maxCapacityKgPerSqm: data['max_capacity_kg_per_sqm'] as double?,
      maxCapacityNotes: data['max_capacity_notes'] as String?,
      scientificReferences: data['scientific_references'] as String?,
      referenceUrls: data['reference_urls'] != null
          ? (data['reference_urls'] as String).split(',')
          : null,
      isActive: data['is_active'] as bool? ?? true,
    );
  }
}

/// Unit entity for measurement units system.
@freezed
class UnitEntity with _$UnitEntity {
  const factory UnitEntity({
    required String id,
    required String code,
    required String category,
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
    @Default(true) bool isActive,
  }) = _UnitEntity;

  factory UnitEntity.fromJson(Map<String, dynamic> json) =>
      _$UnitEntityFromJson(json);

  factory UnitEntity.fromLocal(Map<String, dynamic> data) {
    return UnitEntity(
      id: data['unit_id'].toString(),
      code: data['unit_code'] as String,
      category: data['unit_category'] as String,
      name: data['unit_name'] as String?,
      symbol: data['unit_symbol'] as String?,
      description: data['unit_description'] as String?,
      isBaseUnit: data['is_base_unit'] as bool?,
      baseUnitCode: data['base_unit_code'] as String?,
      conversionFactor: data['default_conversion_factor'] as double?,
      isDynamic: data['is_dynamic'] as bool?,
      isMetric: data['is_metric'] as bool?,
      displayDecimals: data['display_decimals'] as int?,
      sortOrder: data['sort_order'] as int?,
      isActive: data['is_active'] as bool? ?? true,
    );
  }
}

/// Lab test type entity for lab test configurations.
@freezed
class LabTestTypeEntity with _$LabTestTypeEntity {
  const factory LabTestTypeEntity({
    required String code,
    required String name,
    String? description,
    String? category,
    int? turnaroundDays,
    @Default(true) bool isActive,
  }) = _LabTestTypeEntity;

  factory LabTestTypeEntity.fromJson(Map<String, dynamic> json) {
    return LabTestTypeEntity(
      code: json['code'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      category: json['category'] as String?,
      turnaroundDays: json['turnaroundDays'] as int?,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  factory LabTestTypeEntity.fromCompanion(Map<String, dynamic> data) {
    return LabTestTypeEntity(
      code: data['code'] as String,
      name: data['name'] as String,
      description: data['description'] as String?,
      category: data['category'] as String?,
      turnaroundDays: data['turnaround_days'] as int?,
      isActive: data['is_active'] as bool? ?? true,
    );
  }
}

/// Lab parameter entity for lab test parameters.
/// Based on schema.sql - fms_mt_lab_parameters
@freezed
class LabParameterEntity with _$LabParameterEntity {
  const factory LabParameterEntity({
    required String id,
    required int testTypeId,
    required String parameterCode,
    required String parameterName,
    String? parameterUuid,
    String? standardOperator,
    double? standardMin,
    double? standardMax,
    String? parameterUnit,
    @Default(true) bool isActive,
    DateTime? createdDate,
  }) = _LabParameterEntity;

  factory LabParameterEntity.fromJson(Map<String, dynamic> json) =>
      _$LabParameterEntityFromJson(json);

  factory LabParameterEntity.fromLocal(Map<String, dynamic> data) {
    return LabParameterEntity(
      id: data['parameter_id'].toString(),
      parameterUuid: data['parameter_uuid'] as String?,
      testTypeId: data['test_type_id'] as int,
      parameterCode: data['parameter_code'] as String,
      parameterName: data['parameter_name'] as String,
      standardOperator: data['standard_operator'] as String?,
      standardMin: data['standard_min'] as double?,
      standardMax: data['standard_max'] as double?,
      parameterUnit: data['parameter_unit'] as String?,
      isActive: data['is_active'] as bool? ?? true,
      createdDate: data['created_date'] != null
          ? DateTime.parse(data['created_date'] as String)
          : null,
    );
  }
}

/// Lab type entity for lab type configurations.
/// Based on schema.sql - fms_mt_lab_type
@freezed
class LabTypeEntity with _$LabTypeEntity {
  const factory LabTypeEntity({
    required String id,
    required String labSampleTestType,
    required String testType,
    required String testTypeDetail,
    String? uuid,
    String? standard,
    @Default(true) bool isActive,
    int? createdBy,
    DateTime? createdDate,
    int? lastUpdatedBy,
    DateTime? lastUpdatedDate,
  }) = _LabTypeEntity;

  factory LabTypeEntity.fromJson(Map<String, dynamic> json) =>
      _$LabTypeEntityFromJson(json);

  factory LabTypeEntity.fromLocal(Map<String, dynamic> data) {
    return LabTypeEntity(
      id: data['lab_type_id'].toString(),
      uuid: data['id_uuid'] as String?,
      labSampleTestType: data['lab_sample_test_type'] as String,
      standard: data['standard'] as String?,
      testType: data['test_type'] as String,
      testTypeDetail: data['test_type_detail'] as String,
      isActive: data['is_active'] as bool? ?? true,
      createdBy: data['created_by'] as int?,
      createdDate: data['created_date'] != null
          ? DateTime.parse(data['created_date'] as String)
          : null,
      lastUpdatedBy: data['last_updated_by'] as int?,
      lastUpdatedDate: data['last_updated_date'] != null
          ? DateTime.parse(data['last_updated_date'] as String)
          : null,
    );
  }
}

/// Sample lab type entity for sample lab type configurations.
/// Based on schema.sql - fms_mt_sample_lab_type
@freezed
class SampleLabTypeEntity with _$SampleLabTypeEntity {
  const factory SampleLabTypeEntity({
    required String id,
    required String sampleLabType,
    String? uuid,
    @Default(true) bool isActive,
    int? createdBy,
    DateTime? createdDate,
    int? lastUpdatedBy,
    DateTime? lastUpdatedDate,
  }) = _SampleLabTypeEntity;

  factory SampleLabTypeEntity.fromJson(Map<String, dynamic> json) =>
      _$SampleLabTypeEntityFromJson(json);

  factory SampleLabTypeEntity.fromLocal(Map<String, dynamic> data) {
    return SampleLabTypeEntity(
      id: data['sample_lab_type_id'].toString(),
      uuid: data['id_uuid'] as String?,
      sampleLabType: data['sample_lab_type'] as String,
      isActive: data['is_active'] as bool? ?? true,
      createdBy: data['created_by'] as int?,
      createdDate: data['created_date'] != null
          ? DateTime.parse(data['created_date'] as String)
          : null,
      lastUpdatedBy: data['last_updated_by'] as int?,
      lastUpdatedDate: data['last_updated_date'] != null
          ? DateTime.parse(data['last_updated_date'] as String)
          : null,
    );
  }
}
