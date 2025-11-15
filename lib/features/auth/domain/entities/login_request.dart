/// Login request entity (domain layer).
abstract class LoginRequest {
  /// Creates a new instance of [LoginRequest].
  const LoginRequest({required this.password});

  /// User password
  final String password;
}

/// Phone number login request.
class PhoneLoginRequest extends LoginRequest {
  /// Creates a new instance of [PhoneLoginRequest].
  const PhoneLoginRequest({
    required this.countryCode,
    required this.phoneNumber,
    required super.password,
  });

  /// Country dial code (e.g., '+62')
  final String countryCode;

  /// Phone number without country code
  final String phoneNumber;
}

/// Email login request.
class EmailLoginRequest extends LoginRequest {
  /// Creates a new instance of [EmailLoginRequest].
  const EmailLoginRequest({
    required this.email,
    required super.password,
  });

  /// User email address
  final String email;
}


