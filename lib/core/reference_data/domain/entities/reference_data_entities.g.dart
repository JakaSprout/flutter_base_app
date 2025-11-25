// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_data_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmSummary _$FarmSummaryFromJson(Map<String, dynamic> json) => FarmSummary(
  id: _idFromJson(json['id']),
  name: json['farm_name'] as String,
  code: json['farm_code'] as String,
  farmUuid: json['farm_uuid'] as String?,
  location: json['farm_location'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  area: (json['farm_area_sqm'] as num?)?.toDouble(),
  ownerName: json['owner_name'] as String?,
  contactInfo: json['contact_info'] as String?,
  establishedDate: json['establishedDate'] == null
      ? null
      : DateTime.parse(json['establishedDate'] as String),
  isActive: json['is_active'] as bool,
  createdDate: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  createdBy: _intFromJson(json['created_by']),
  lastUpdatedDate: json['last_updated_date'] == null
      ? null
      : DateTime.parse(json['last_updated_date'] as String),
  lastUpdatedBy: _intFromJson(json['last_updated_by']),
);

Map<String, dynamic> _$FarmSummaryToJson(FarmSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'farm_name': instance.name,
      'farm_code': instance.code,
      'farm_uuid': instance.farmUuid,
      'farm_location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'farm_area_sqm': instance.area,
      'owner_name': instance.ownerName,
      'contact_info': instance.contactInfo,
      'establishedDate': instance.establishedDate?.toIso8601String(),
      'is_active': instance.isActive,
      'created_at': instance.createdDate?.toIso8601String(),
      'created_by': instance.createdBy,
      'last_updated_date': instance.lastUpdatedDate?.toIso8601String(),
      'last_updated_by': instance.lastUpdatedBy,
    };

_$CustomerSummaryImpl _$$CustomerSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$CustomerSummaryImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  code: json['code'] as String,
  contactInfo: json['contactInfo'] as String?,
  address: json['address'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  email: json['email'] as String?,
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$$CustomerSummaryImplToJson(
  _$CustomerSummaryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
  'contactInfo': instance.contactInfo,
  'address': instance.address,
  'phoneNumber': instance.phoneNumber,
  'email': instance.email,
  'isActive': instance.isActive,
};

_$CapacityReferenceImpl _$$CapacityReferenceImplFromJson(
  Map<String, dynamic> json,
) => _$CapacityReferenceImpl(
  id: json['id'] as String,
  commodityCode: json['commodityCode'] as String,
  commodityName: json['commodityName'] as String,
  possibleTechnology: json['possibleTechnology'] as String?,
  category: json['category'] as String?,
  intensityLevel: json['intensityLevel'] as String?,
  maxCapacity: (json['maxCapacity'] as num?)?.toDouble(),
  maxCapacityUnit: json['maxCapacityUnit'] as String?,
  maxCapacityKgPerSqm: (json['maxCapacityKgPerSqm'] as num?)?.toDouble(),
  maxCapacityNotes: json['maxCapacityNotes'] as String?,
  scientificReferences: json['scientificReferences'] as String?,
  referenceUrls: (json['referenceUrls'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$$CapacityReferenceImplToJson(
  _$CapacityReferenceImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'commodityCode': instance.commodityCode,
  'commodityName': instance.commodityName,
  'possibleTechnology': instance.possibleTechnology,
  'category': instance.category,
  'intensityLevel': instance.intensityLevel,
  'maxCapacity': instance.maxCapacity,
  'maxCapacityUnit': instance.maxCapacityUnit,
  'maxCapacityKgPerSqm': instance.maxCapacityKgPerSqm,
  'maxCapacityNotes': instance.maxCapacityNotes,
  'scientificReferences': instance.scientificReferences,
  'referenceUrls': instance.referenceUrls,
  'isActive': instance.isActive,
};

_$UnitEntityImpl _$$UnitEntityImplFromJson(Map<String, dynamic> json) =>
    _$UnitEntityImpl(
      id: json['id'] as String,
      code: json['code'] as String,
      category: json['category'] as String,
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
      description: json['description'] as String?,
      isBaseUnit: json['isBaseUnit'] as bool?,
      baseUnitCode: json['baseUnitCode'] as String?,
      conversionFactor: (json['conversionFactor'] as num?)?.toDouble(),
      isDynamic: json['isDynamic'] as bool?,
      isMetric: json['isMetric'] as bool?,
      displayDecimals: (json['displayDecimals'] as num?)?.toInt(),
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$UnitEntityImplToJson(_$UnitEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'category': instance.category,
      'name': instance.name,
      'symbol': instance.symbol,
      'description': instance.description,
      'isBaseUnit': instance.isBaseUnit,
      'baseUnitCode': instance.baseUnitCode,
      'conversionFactor': instance.conversionFactor,
      'isDynamic': instance.isDynamic,
      'isMetric': instance.isMetric,
      'displayDecimals': instance.displayDecimals,
      'sortOrder': instance.sortOrder,
      'isActive': instance.isActive,
    };

_$LabParameterEntityImpl _$$LabParameterEntityImplFromJson(
  Map<String, dynamic> json,
) => _$LabParameterEntityImpl(
  id: json['id'] as String,
  testTypeId: (json['testTypeId'] as num).toInt(),
  parameterCode: json['parameterCode'] as String,
  parameterName: json['parameterName'] as String,
  parameterUuid: json['parameterUuid'] as String?,
  standardOperator: json['standardOperator'] as String?,
  standardMin: (json['standardMin'] as num?)?.toDouble(),
  standardMax: (json['standardMax'] as num?)?.toDouble(),
  parameterUnit: json['parameterUnit'] as String?,
  isActive: json['isActive'] as bool? ?? true,
  createdDate: json['createdDate'] == null
      ? null
      : DateTime.parse(json['createdDate'] as String),
);

Map<String, dynamic> _$$LabParameterEntityImplToJson(
  _$LabParameterEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'testTypeId': instance.testTypeId,
  'parameterCode': instance.parameterCode,
  'parameterName': instance.parameterName,
  'parameterUuid': instance.parameterUuid,
  'standardOperator': instance.standardOperator,
  'standardMin': instance.standardMin,
  'standardMax': instance.standardMax,
  'parameterUnit': instance.parameterUnit,
  'isActive': instance.isActive,
  'createdDate': instance.createdDate?.toIso8601String(),
};

_$LabTypeEntityImpl _$$LabTypeEntityImplFromJson(Map<String, dynamic> json) =>
    _$LabTypeEntityImpl(
      id: json['id'] as String,
      labSampleTestType: json['labSampleTestType'] as String,
      testType: json['testType'] as String,
      testTypeDetail: json['testTypeDetail'] as String,
      uuid: json['uuid'] as String?,
      standard: json['standard'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdBy: (json['createdBy'] as num?)?.toInt(),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      lastUpdatedBy: (json['lastUpdatedBy'] as num?)?.toInt(),
      lastUpdatedDate: json['lastUpdatedDate'] == null
          ? null
          : DateTime.parse(json['lastUpdatedDate'] as String),
    );

Map<String, dynamic> _$$LabTypeEntityImplToJson(_$LabTypeEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'labSampleTestType': instance.labSampleTestType,
      'testType': instance.testType,
      'testTypeDetail': instance.testTypeDetail,
      'uuid': instance.uuid,
      'standard': instance.standard,
      'isActive': instance.isActive,
      'createdBy': instance.createdBy,
      'createdDate': instance.createdDate?.toIso8601String(),
      'lastUpdatedBy': instance.lastUpdatedBy,
      'lastUpdatedDate': instance.lastUpdatedDate?.toIso8601String(),
    };

_$SampleLabTypeEntityImpl _$$SampleLabTypeEntityImplFromJson(
  Map<String, dynamic> json,
) => _$SampleLabTypeEntityImpl(
  id: json['id'] as String,
  sampleLabType: json['sampleLabType'] as String,
  uuid: json['uuid'] as String?,
  isActive: json['isActive'] as bool? ?? true,
  createdBy: (json['createdBy'] as num?)?.toInt(),
  createdDate: json['createdDate'] == null
      ? null
      : DateTime.parse(json['createdDate'] as String),
  lastUpdatedBy: (json['lastUpdatedBy'] as num?)?.toInt(),
  lastUpdatedDate: json['lastUpdatedDate'] == null
      ? null
      : DateTime.parse(json['lastUpdatedDate'] as String),
);

Map<String, dynamic> _$$SampleLabTypeEntityImplToJson(
  _$SampleLabTypeEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'sampleLabType': instance.sampleLabType,
  'uuid': instance.uuid,
  'isActive': instance.isActive,
  'createdBy': instance.createdBy,
  'createdDate': instance.createdDate?.toIso8601String(),
  'lastUpdatedBy': instance.lastUpdatedBy,
  'lastUpdatedDate': instance.lastUpdatedDate?.toIso8601String(),
};
