import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_response.dart';

part 'login_response_model.freezed.dart';
part 'login_response_model.g.dart';

/// Login response data model (data layer).
@freezed
class LoginResponseModel with _$LoginResponseModel {
  /// Creates a new instance of [LoginResponseModel].
  const factory LoginResponseModel({
    required String accessToken,
    required String refreshToken,
    String? userId,
    String? email,
    String? phoneNumber,
  }) = _LoginResponseModel;

  /// Creates [LoginResponseModel] from JSON.
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}

/// Extension to convert [LoginResponseModel] to [LoginResponse].
extension LoginResponseModelExtension on LoginResponseModel {
  /// Converts [LoginResponseModel] to [LoginResponse].
  LoginResponse toEntity() {
    return LoginResponse(
      accessToken: accessToken,
      refreshToken: refreshToken,
      userId: userId,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}




