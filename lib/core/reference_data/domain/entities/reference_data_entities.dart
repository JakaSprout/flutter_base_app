import 'package:freezed_annotation/freezed_annotation.dart';

part 'reference_data_entities.freezed.dart';
part 'reference_data_entities.g.dart';

/// Farm summary entity for displaying farm information.
@freezed
class FarmSummary with _$FarmSummary {
  const factory FarmSummary({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'farm_name') required String name,
    @JsonKey(name: 'farm_code') required String code,
    @JsonKey(name: 'farm_location') String? location,
    @JsonKey(name: 'latitude') double? latitude,
    @JsonKey(name: 'longitude') double? longitude,
    @JsonKey(name: 'farm_area_sqm') double? area,
    String? areaUnit,
    @JsonKey(name: 'owner_name') String? ownerName,
    @JsonKey(name: 'contact_info') String? contactInfo,
    DateTime? establishedDate,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _FarmSummary;

  factory FarmSummary.fromJson(Map<String, dynamic> json) =>
      _$FarmSummaryFromJson(json);

  factory FarmSummary.fromLocal(Map<String, dynamic> data) {
    return FarmSummary(
      id: data['farm_id'].toString(),
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
    );
  }
}

/// Pond summary entity for displaying pond information.
@freezed
class PondSummary with _$PondSummary {
  const factory PondSummary({
    required String id,
    required String code,
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
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? deletedAt,
  }) = _PondSummary;

  factory PondSummary.fromJson(Map<String, dynamic> json) {
    return PondSummary(
      id: json['id'].toString(),
      code: json['pond_code'] as String,
      name: json['pond_name'] as String?,
      farmId: json['farm_id']?.toString(),
      size: (json['pond_size_sqm'] as num?)?.toDouble(),
      pwa: (json['pwa_sqm'] as num?)?.toDouble(),
      depth: (json['depth_meter'] as num?)?.toDouble(),
      maxDepth: (json['max_depth_meter'] as num?)?.toDouble(),
      volume: (json['volume_cubic_meter'] as num?)?.toDouble(),
      pondType: json['pond_type'] as String?,
      pondShape: json['pond_shape'] as String?,
      bottomType: json['bottom_type'] as String?,
      hasAerator: json['has_aerator'] as bool?,
      aeratorCount: json['aerator_count'] as int?,
      aeratorTotalHp: (json['aerator_total_hp'] as num?)?.toDouble(),
      hasCentralDrain: json['has_central_drain'] as bool?,
      waterSource: json['water_source'] as String?,
      pondStatus: json['pond_status'] as String?,
      currentCycleId: json['current_cycle_id'] as int?,
      maxBiomass: (json['max_biomass_kg_per_sqm'] as num?)?.toDouble(),
      recommendedStockingDensity: (json['recommended_stocking_density'] as num?)
          ?.toDouble(),
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
    );
  }

  factory PondSummary.fromLocal(Map<String, dynamic> data) {
    return PondSummary(
      id: data['pond_id'].toString(),
      code: data['pond_code'] as String,
      name: data['pond_name'] as String?,
      farmId: data['farm_id']?.toString(),
      farmName: data['farm_name'] as String?,
      size: data['pond_size'] as double?,
      sizeUnit: data['pond_size_unit'] as String?,
      pwa: data['pwa'] as double?,
      pwaUnit: data['pwa_unit'] as String?,
      depth: data['depth'] as double?,
      depthUnit: data['depth_unit'] as String?,
      pondType: data['pond_type'] as String?,
      pondStatus: data['pond_status'] as String?,
      maxBiomass: data['max_biomass'] as double?,
      maxBiomassUnit: data['max_biomass_unit'] as String?,
      isActive: data['is_active'] as bool? ?? true,
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
