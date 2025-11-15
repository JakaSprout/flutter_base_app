// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CountryCodeModelImpl _$$CountryCodeModelImplFromJson(
  Map<String, dynamic> json,
) => _$CountryCodeModelImpl(
  code: json['code'] as String,
  dialCode: json['dialCode'] as String,
  name: json['name'] as String,
  flag: json['flag'] as String?,
);

Map<String, dynamic> _$$CountryCodeModelImplToJson(
  _$CountryCodeModelImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'dialCode': instance.dialCode,
  'name': instance.name,
  'flag': instance.flag,
};
