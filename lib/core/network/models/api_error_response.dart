import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error_response.freezed.dart';
part 'api_error_response.g.dart';

/// API error response model.
///
/// Represents the structure of error responses from the API.
/// Based on API documentation at: https://07f7ff2f6632.ngrok-free.app/api/docs
///
/// Error response structures vary by status code:
/// - 401: { "error": "string", "message": "string" }
/// - 422: { "error": "string", "message": "string", "details": {} }
/// - 500: { "statusCode": number, "code": "string",
///   "error": "string", "message": "string" }
/// - 502/503: { "statusCode": number, "code": "string",
///   "error": "string", "message": "string" }
@freezed
class ApiErrorResponse with _$ApiErrorResponse {
  /// Creates a new instance of [ApiErrorResponse].
  const factory ApiErrorResponse({
    /// Error code or type
    String? error,

    /// Human-readable error message
    String? message,

    /// HTTP status code (for 500, 502, 503 errors)
    int? statusCode,

    /// Error code (for 500, 502, 503 errors)
    /// Example: "UPSTREAM_UNAVAILABLE" for 503 errors
    String? code,

    /// Validation error details (for 422 errors)
    /// Map of field names to error messages
    Map<String, dynamic>? details,
  }) = _ApiErrorResponse;

  /// Creates [ApiErrorResponse] from JSON.
  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorResponseFromJson(json);
}

/// Extension methods for [ApiErrorResponse].
extension ApiErrorResponseExtension on ApiErrorResponse {
  /// Get the primary error message.
  ///
  /// Returns [message] if available, otherwise [error], otherwise default.
  String getErrorMessage([String defaultMessage = 'Server error']) {
    return message ?? error ?? defaultMessage;
  }

  /// Get the error code.
  ///
  /// Returns [code] if available, otherwise [error], otherwise default.
  String? getErrorCode() {
    return code ?? error;
  }

  /// Check if this is a validation error (422).
  bool get isValidationError => details != null && details!.isNotEmpty;

  /// Get validation error details as formatted string.
  ///
  /// Returns a comma-separated list of field names with errors.
  String? getValidationDetailsString() {
    if (!isValidationError) return null;
    return details!.keys.join(', ');
  }

  /// Get full error message including validation details.
  ///
  /// For validation errors, includes field names in the message.
  String getFullErrorMessage([String defaultMessage = 'Server error']) {
    final baseMessage = getErrorMessage(defaultMessage);
    if (isValidationError) {
      final detailsStr = getValidationDetailsString();
      return detailsStr != null ? '$baseMessage ($detailsStr)' : baseMessage;
    }
    return baseMessage;
  }
}
