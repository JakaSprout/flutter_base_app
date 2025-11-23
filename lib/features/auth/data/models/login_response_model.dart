import 'package:app_mobile_afms/features/auth/domain/entities/login_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_model.freezed.dart';
part 'login_response_model.g.dart';

/// Login response data model (data layer).
@freezed
class LoginResponseModel with _$LoginResponseModel {
  /// Creates a new instance of [LoginResponseModel].
  const factory LoginResponseModel({
    String? accessToken,
    String? refreshToken,
    int? expiresIn,
    @Default('Bearer') String tokenType,
    int? employeeId,
    String? sessionId,
  }) = _LoginResponseModel;

  /// Creates [LoginResponseModel] from JSON.
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}

/// Extension to convert [LoginResponseModel] to [LoginResponse].
extension LoginResponseModelExtension on LoginResponseModel {
  /// Converts [LoginResponseModel] to [LoginResponse].
  LoginResponse toEntity() {
    final token = accessToken ?? sessionId;
    final refresh = refreshToken ?? sessionId;

    if (token == null || token.isEmpty) {
      throw Exception('No access token or session ID available');
    }

    return LoginResponse(
      accessToken: token,
      refreshToken: refresh ?? token,
      expiresIn: expiresIn,
      employeeId: employeeId?.toString(),
    );
  }
}
