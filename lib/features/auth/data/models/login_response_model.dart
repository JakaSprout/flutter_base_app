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
    Map<String, dynamic>? user,
    String? userId,
    String? email,
    String? phoneNumber,
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
    // Extract user info from user object if available
    final userEmail = email ?? user?['email'] as String?;
    final userPhone = phoneNumber ?? user?['phone'] as String?;
    final userIdFromUser = userId ?? user?['id']?.toString();

    // Use sessionId as accessToken if accessToken is not available
    // API returns sessionId instead of accessToken/refreshToken
    final token = accessToken ?? sessionId;
    final refresh = refreshToken ?? sessionId;

    // Ensure we have at least one token
    if (token == null || token.isEmpty) {
      throw Exception('No access token or session ID available');
    }

    return LoginResponse(
      accessToken: token,
      refreshToken:
          refresh ?? token, // Use same token as refresh if not available
      expiresIn: expiresIn,
      userId: userIdFromUser,
      email: userEmail,
      phoneNumber: userPhone,
    );
  }
}
