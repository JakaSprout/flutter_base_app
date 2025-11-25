// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_data_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FarmSummaryImpl _$$FarmSummaryImplFromJson(Map<String, dynamic> json) =>
    _$FarmSummaryImpl(
      id: json['id'] as String,
      name: json['farm_name'] as String,
      code: json['farm_code'] as String,
      location: json['farm_location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      area: (json['farm_area_sqm'] as num?)?.toDouble(),
      areaUnit: json['areaUnit'] as String?,
      ownerName: json['owner_name'] as String?,
      contactInfo: json['contact_info'] as String?,
      establishedDate: json['establishedDate'] == null
          ? null
          : DateTime.parse(json['establishedDate'] as String),
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$FarmSummaryImplToJson(_$FarmSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'farm_name': instance.name,
      'farm_code': instance.code,
      'farm_location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'farm_area_sqm': instance.area,
      'areaUnit': instance.areaUnit,
      'owner_name': instance.ownerName,
      'contact_info': instance.contactInfo,
      'establishedDate': instance.establishedDate?.toIso8601String(),
      'is_active': instance.isActive,
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
