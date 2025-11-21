// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registered_pond.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisteredPondImpl _$$RegisteredPondImplFromJson(Map<String, dynamic> json) =>
    _$RegisteredPondImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      area: (json['area'] as num).toDouble(),
      location: json['location'] as String,
      registeredAt: DateTime.parse(json['registeredAt'] as String),
    );

Map<String, dynamic> _$$RegisteredPondImplToJson(
  _$RegisteredPondImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'area': instance.area,
  'location': instance.location,
  'registeredAt': instance.registeredAt.toIso8601String(),
};
