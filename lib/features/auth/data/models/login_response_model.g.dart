// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginResponseModelImpl _$$LoginResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$LoginResponseModelImpl(
  accessToken: json['accessToken'] as String?,
  refreshToken: json['refreshToken'] as String?,
  expiresIn: (json['expiresIn'] as num?)?.toInt(),
  tokenType: json['tokenType'] as String? ?? 'Bearer',
  user: json['user'] as Map<String, dynamic>?,
  userId: json['userId'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  sessionId: json['sessionId'] as String?,
);

Map<String, dynamic> _$$LoginResponseModelImplToJson(
  _$LoginResponseModelImpl instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'expiresIn': instance.expiresIn,
  'tokenType': instance.tokenType,
  'user': instance.user,
  'userId': instance.userId,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'sessionId': instance.sessionId,
};
