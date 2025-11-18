/// Login request entity (domain layer).
abstract class LoginRequest {
  /// Creates a new instance of [LoginRequest].
  const LoginRequest();
}

/// Phone number login request.
///
/// Phone login does not require password.
class PhoneLoginRequest extends LoginRequest {
  /// Creates a new instance of [PhoneLoginRequest].
  const PhoneLoginRequest({required this.phoneNumber});

  /// Phone number (can include country code, e.g., '+6281234567890')
  final String phoneNumber;
}

/// Email login request.
///
/// Email login requires password.
class EmailLoginRequest extends LoginRequest {
  /// Creates a new instance of [EmailLoginRequest].
  const EmailLoginRequest({required this.email, required this.password});

  /// User email address
  final String email;

  /// User password
  final String password;
}
