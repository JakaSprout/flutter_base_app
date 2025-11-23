/// Login response entity (domain layer).
class LoginResponse {
  /// Creates a new instance of [LoginResponse].
  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    this.expiresIn,
    this.employeeId,
  });

  /// Access token for API authentication
  final String accessToken;

  /// Refresh token for token renewal
  final String refreshToken;

  /// Token expiration time in seconds
  final int? expiresIn;

  /// Employee ID returned by the backend (preferred unique identifier)
  final String? employeeId;

  /// Get token expiration DateTime.
  ///
  /// Returns null if expiresIn is not available.
  DateTime? get expiresAt {
    if (expiresIn == null) return null;
    return DateTime.now().add(Duration(seconds: expiresIn!));
  }

  /// Check if token is expired.
  ///
  /// Returns false if expiresIn is not available (assume not expired).
  bool get isExpired {
    final expiration = expiresAt;
    if (expiration == null) return false;
    return DateTime.now().isAfter(expiration);
  }

  /// Check if token will expire soon (within threshold).
  ///
  /// Returns false if expiresIn is not available.
  bool willExpireSoon({Duration threshold = const Duration(minutes: 5)}) {
    final expiration = expiresAt;
    if (expiration == null) return false;
    final now = DateTime.now();
    final thresholdTime = expiration.subtract(threshold);
    return now.isAfter(thresholdTime);
  }
}
