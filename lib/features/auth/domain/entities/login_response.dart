/// Login response entity (domain layer).
class LoginResponse {
  /// Creates a new instance of [LoginResponse].
  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    this.userId,
    this.email,
    this.phoneNumber,
  });

  /// Access token for API authentication
  final String accessToken;

  /// Refresh token for token renewal
  final String refreshToken;

  /// User ID (optional)
  final String? userId;

  /// User email (optional)
  final String? email;

  /// User phone number (optional)
  final String? phoneNumber;
}


