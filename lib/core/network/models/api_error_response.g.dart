// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiErrorResponseImpl _$$ApiErrorResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ApiErrorResponseImpl(
  error: json['error'] as String?,
  message: json['message'] as String?,
  statusCode: (json['statusCode'] as num?)?.toInt(),
  code: json['code'] as String?,
  details: json['details'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$ApiErrorResponseImplToJson(
  _$ApiErrorResponseImpl instance,
) => <String, dynamic>{
  'error': instance.error,
  'message': instance.message,
  'statusCode': instance.statusCode,
  'code': instance.code,
  'details': instance.details,
};
