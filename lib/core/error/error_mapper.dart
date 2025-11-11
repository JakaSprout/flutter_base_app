import 'package:dio/dio.dart';
import 'package:flutter_base_app/core/error/failures.dart';

/// Maps exceptions to failures.
class ErrorMapper {
  // Private constructor to prevent instantiation
  ErrorMapper._();

  /// Map exception to failure.
  static Failure mapException(dynamic exception) {
    if (exception is DioException) {
      return mapDioException(exception);
    }

    if (exception is FormatException) {
      return ValidationFailure(
        message: 'Invalid data format: ${exception.message}',
        code: 'FORMAT_ERROR',
      );
    }

    if (exception is TypeError) {
      return ValidationFailure(
        message: 'Type error: $exception',
        code: 'TYPE_ERROR',
      );
    }

    // Default to unknown failure
    return UnknownFailure.unknown(exception.toString());
  }

  /// Map DioException to failure.
  static Failure mapDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure.timeout();

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        if (statusCode == 401) {
          return const AuthFailure.unauthorized();
        }
        if (statusCode == 403) {
          return const AuthFailure(
            message: 'Forbidden. Access denied.',
            code: 'FORBIDDEN',
          );
        }
        if (statusCode == 404) {
          return const NetworkFailure(
            message: 'Resource not found.',
            code: 'NOT_FOUND',
          );
        }
        if (statusCode != null && statusCode >= 500) {
          return const NetworkFailure.serverError();
        }
        return NetworkFailure(
          message:
              exception.response?.statusMessage ??
              'Request failed with status code: $statusCode',
          code: statusCode?.toString(),
        );

      case DioExceptionType.cancel:
        return const NetworkFailure(
          message: 'Request cancelled.',
          code: 'CANCELLED',
        );

      case DioExceptionType.connectionError:
        return const NetworkFailure.noConnection();

      case DioExceptionType.badCertificate:
        return const NetworkFailure(
          message: 'SSL certificate error.',
          code: 'BAD_CERTIFICATE',
        );

      case DioExceptionType.unknown:
        return NetworkFailure(
          message: exception.message ?? 'Network error occurred.',
          code: 'UNKNOWN_NETWORK_ERROR',
        );
    }
  }
}
