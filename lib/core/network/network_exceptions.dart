import 'package:dio/dio.dart';

/// Network-specific exceptions.
class NetworkException implements Exception {
  /// Creates a new instance of [NetworkException].
  const NetworkException({
    required this.message,
    this.statusCode,
    this.dioException,
  });

  /// Error message
  final String message;

  /// HTTP status code (if available)
  final int? statusCode;

  /// Original DioException (if available)
  final DioException? dioException;

  @override
  String toString() => 'NetworkException: $message';
}

/// Request timeout exception.
class RequestTimeoutException extends NetworkException {
  /// Creates a new instance of [RequestTimeoutException].
  const RequestTimeoutException()
      : super(
          message: 'Request timeout',
        );
}

/// No internet connection exception.
class NoConnectionException extends NetworkException {
  /// Creates a new instance of [NoConnectionException].
  const NoConnectionException()
      : super(
          message: 'No internet connection',
        );
}

/// Server error exception.
class ServerException extends NetworkException {
  /// Creates a new instance of [ServerException].
  const ServerException({
    required super.message,
    super.statusCode,
  });
}

/// Unauthorized exception.
class UnauthorizedException extends NetworkException {
  /// Creates a new instance of [UnauthorizedException].
  const UnauthorizedException()
      : super(
          message: 'Unauthorized',
          statusCode: 401,
        );
}
