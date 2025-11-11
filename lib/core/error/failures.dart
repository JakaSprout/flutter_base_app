import 'package:flutter/foundation.dart';

/// Base class for all failures in the application.
@immutable
abstract class Failure {
  /// Creates a new instance of [Failure].
  const Failure({required this.message, this.code});

  /// Failure message
  final String message;

  /// Optional error code
  final String? code;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure && other.message == message && other.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ code.hashCode;

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

/// Network-related failures.
class NetworkFailure extends Failure {
  /// Creates a new instance of [NetworkFailure].
  const NetworkFailure({required super.message, super.code});

  /// Network timeout failure
  const NetworkFailure.timeout()
    : super(
        message: 'Request timeout. Please check your connection.',
        code: 'TIMEOUT',
      );

  /// Network connection failure
  const NetworkFailure.noConnection()
    : super(
        message: 'No internet connection. Please check your network.',
        code: 'NO_CONNECTION',
      );

  /// Network server error
  const NetworkFailure.serverError([String? message])
    : super(
        message: message ?? 'Server error. Please try again later.',
        code: 'SERVER_ERROR',
      );
}

/// Cache-related failures.
class CacheFailure extends Failure {
  /// Creates a new instance of [CacheFailure].
  const CacheFailure({required super.message, super.code});

  /// Cache not found failure
  const CacheFailure.notFound()
    : super(message: 'Cache not found.', code: 'CACHE_NOT_FOUND');

  /// Cache write failure
  const CacheFailure.writeError([String? message])
    : super(
        message: message ?? 'Failed to write to cache.',
        code: 'CACHE_WRITE_ERROR',
      );
}

/// Validation failures.
class ValidationFailure extends Failure {
  /// Creates a new instance of [ValidationFailure].
  const ValidationFailure({required super.message, super.code});
}

/// Authentication failures.
class AuthFailure extends Failure {
  /// Creates a new instance of [AuthFailure].
  const AuthFailure({required super.message, super.code});

  /// Unauthorized failure
  const AuthFailure.unauthorized()
    : super(message: 'Unauthorized. Please login again.', code: 'UNAUTHORIZED');

  /// Token expired failure
  const AuthFailure.tokenExpired()
    : super(
        message: 'Session expired. Please login again.',
        code: 'TOKEN_EXPIRED',
      );
}

/// Unknown failures.
class UnknownFailure extends Failure {
  /// Creates a new instance of [UnknownFailure].
  const UnknownFailure({required super.message, super.code});

  /// Unknown error failure
  const UnknownFailure.unknown([String? message])
    : super(message: message ?? 'An unknown error occurred.', code: 'UNKNOWN');
}
