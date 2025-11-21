import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:app_mobile_afms/core/config/api_constants.dart';
import 'package:app_mobile_afms/core/config/app_config.dart';
import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/core/network/models/api_error_response.dart';
import 'package:app_mobile_afms/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:app_mobile_afms/features/auth/data/models/login_response_model.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_request.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Real implementation of [AuthRemoteDataSource].
///
/// This provides actual API calls to the backend.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  /// Creates a new instance of [AuthRemoteDataSourceImpl].
  AuthRemoteDataSourceImpl({
    required AppConfig config,
    required Dio dio,
    required FlutterSecureStorage secureStorage,
  }) : _dio = dio,
       _config = config,
       _secureStorage = secureStorage;

  final Dio _dio;
  // ignore: unused_field
  final AppConfig _config;
  final FlutterSecureStorage _secureStorage;

  @override
  Future<Either<Failure, LoginResponseModel>> loginWithPhone(
    PhoneLoginRequest request,
  ) async {
    try {
      // Use phone number directly (can include country code)
      // Remove any non-digit characters except +
      final phoneNumber = request.phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.authLoginPhone,
        data: {'phone': phoneNumber},
      );

      if (response.data == null) {
        return const Left(
          NetworkFailure.serverError('Invalid response from server'),
        );
      }

      // Extract data from response
      // Response structure: { "data": { "success": true, "data": { "sessionId": "..." }, "metadata": {...} } }
      final outerData = response.data!['data'] as Map<String, dynamic>?;
      if (outerData == null) {
        return const Left(
          NetworkFailure.serverError('Invalid response format'),
        );
      }

      // Get inner data (contains sessionId or tokens)
      final innerData = outerData['data'] as Map<String, dynamic>?;
      if (innerData == null) {
        return const Left(
          NetworkFailure.serverError('Invalid response format: missing data'),
        );
      }

      // Map API response to model
      // API returns sessionId instead of accessToken/refreshToken
      final sessionId = innerData['sessionId'] as String?;
      final accessToken = innerData['accessToken'] as String?;
      final refreshToken = innerData['refreshToken'] as String?;

      // Use sessionId if tokens are not available
      if (sessionId == null && accessToken == null) {
        return const Left(
          NetworkFailure.serverError(
            'Invalid response format: missing sessionId or accessToken',
          ),
        );
      }

      final loginResponse = LoginResponseModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
        sessionId: sessionId,
        expiresIn: innerData['expiresIn'] as int?,
        tokenType: innerData['tokenType'] as String? ?? 'Bearer',
        user:
            innerData['user'] as Map<String, dynamic>? ??
            outerData['user'] as Map<String, dynamic>?,
        phoneNumber: phoneNumber,
      );

      return Right(loginResponse);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(
        NetworkFailure.serverError('${AuthConstants.errorLoginFailed}: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> loginWithEmail(
    EmailLoginRequest request,
  ) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.authLoginEmail,
        data: {'email': request.email, 'password': request.password},
      );

      if (response.data == null) {
        return const Left(
          NetworkFailure.serverError('Invalid response from server'),
        );
      }

      // Extract data from response
      // Response structure: { "data": { "success": true, "data": { "sessionId": "..." }, "metadata": {...} } }
      final outerData = response.data!['data'] as Map<String, dynamic>?;
      if (outerData == null) {
        return const Left(
          NetworkFailure.serverError('Invalid response format'),
        );
      }

      // Get inner data (contains sessionId or tokens)
      final innerData = outerData['data'] as Map<String, dynamic>?;
      if (innerData == null) {
        return const Left(
          NetworkFailure.serverError('Invalid response format: missing data'),
        );
      }

      // Map API response to model
      // API returns sessionId instead of accessToken/refreshToken
      final sessionId = innerData['sessionId'] as String?;
      final accessToken = innerData['accessToken'] as String?;
      final refreshToken = innerData['refreshToken'] as String?;

      // Use sessionId if tokens are not available
      if (sessionId == null && accessToken == null) {
        return const Left(
          NetworkFailure.serverError(
            'Invalid response format: missing sessionId or accessToken',
          ),
        );
      }

      final loginResponse = LoginResponseModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
        sessionId: sessionId,
        expiresIn: innerData['expiresIn'] as int?,
        tokenType: innerData['tokenType'] as String? ?? 'Bearer',
        user:
            innerData['user'] as Map<String, dynamic>? ??
            outerData['user'] as Map<String, dynamic>?,
        email: request.email,
      );

      return Right(loginResponse);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(
        NetworkFailure.serverError('${AuthConstants.errorLoginFailed}: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> refreshToken(
    String refreshToken,
  ) async {
    try {
      // Note: API docs don't show refresh token endpoint, but we'll implement
      // the structure. Update endpoint when available.
      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.authRefreshToken,
        data: {'refreshToken': refreshToken},
      );

      if (response.data == null) {
        return const Left(
          NetworkFailure.serverError('Invalid response from server'),
        );
      }

      // Extract data from response
      final data = response.data!['data'] as Map<String, dynamic>?;
      if (data == null) {
        return const Left(
          NetworkFailure.serverError('Invalid response format'),
        );
      }

      // Map API response to model
      final loginResponse = LoginResponseModel(
        accessToken: data['accessToken'] as String,
        refreshToken: data['refreshToken'] as String? ?? refreshToken,
        expiresIn: data['expiresIn'] as int,
        tokenType: data['tokenType'] as String? ?? 'Bearer',
        user: data['user'] as Map<String, dynamic>?,
      );

      return Right(loginResponse);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(NetworkFailure.serverError('Token refresh failed: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Fetch session ID from secure storage to comply with API requirements
      final sessionId = await _secureStorage.read(
        key: AppConstants.storageAuthToken,
      );

      final headers = <String, dynamic>{};
      Map<String, dynamic>? body;

      if (sessionId != null && sessionId.isNotEmpty) {
        headers['x-session-id'] = sessionId;
        body = {'sessionId': sessionId};
      } else {
        AppLogger.warning(
          'Logout requested without session ID - skipping header/body',
        );
      }

      await _dio.post<void>(
        ApiConstants.authLogout,
        data: body,
        options: headers.isEmpty ? null : Options(headers: headers),
      );

      // Logout successful
      return const Right(null);
    } on DioException catch (e) {
      // Even if logout API fails, we should still clear local tokens
      // Log the error but don't fail the logout process
      AppLogger.warning(
        'Logout API call failed (non-critical): ${e.message}',
        e,
        StackTrace.current,
      );
      // Return success anyway - local logout will still happen
      return const Right(null);
    } catch (e) {
      // Log error but don't fail logout
      AppLogger.warning(
        'Logout error (non-critical): $e',
        e,
        StackTrace.current,
      );
      return const Right(null);
    }
  }

  /// Handle Dio errors and convert to appropriate Failure.
  ///
  /// Based on API documentation at:
  /// https://07f7ff2f6632.ngrok-free.app/api/docs
  ///
  /// Error response structure:
  /// - 401: { "error": "string", "message": "string" }
  /// - 404: Plain text or JSON (e.g., ngrok offline:
  ///   "The endpoint ... is offline. ERR_NGROK_3200")
  /// - 422: { "error": "string", "message": "string", "details": {} }
  /// - 500: { "statusCode": number, "code": "string",
  ///   "error": "string", "message": "string" }
  /// - 502/503: { "statusCode": number, "code": "string",
  ///   "error": "string", "message": "string" }
  ///
  /// Supports various response formats:
  /// - JSON objects with error/message fields
  /// - Plain text responses (e.g., ngrok error messages)
  /// - HTML responses (tags are stripped)
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure.timeout();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final responseData = error.response?.data;

        // Helper function to extract error message from various response formats
        String extractErrorMessage() {
          // Try to parse as JSON first
          if (responseData is Map<String, dynamic>) {
            try {
              final apiError = ApiErrorResponse.fromJson(responseData);
              return apiError.getErrorMessage();
            } catch (e) {
              // If parsing fails, try to get message/error fields directly
              final message = responseData['message'] as String?;
              final error = responseData['error'] as String?;
              if (message != null && message.isNotEmpty) return message;
              if (error != null && error.isNotEmpty) return error;
            }
          }

          // Try to parse as string (plain text, HTML, etc.)
          if (responseData is String) {
            // Extract meaningful message from plain text
            // Remove HTML tags and extra whitespace
            final cleaned = responseData
                .replaceAll(RegExp('<[^>]*>'), '')
                .trim()
                .replaceAll(RegExp(r'\s+'), ' ');
            if (cleaned.isNotEmpty) return cleaned;
          }

          // Fallback to status message or generic message
          final statusMsg = error.response?.statusMessage;
          return statusMsg ?? 'Request failed with status code $statusCode';
        }

        // Helper function to extract error code
        String? extractErrorCode() {
          if (responseData is Map<String, dynamic>) {
            try {
              final apiError = ApiErrorResponse.fromJson(responseData);
              return apiError.getErrorCode();
            } catch (e) {
              return responseData['code'] as String? ??
                  responseData['error'] as String?;
            }
          }
          return null;
        }

        final errorMessage = extractErrorMessage();
        final errorCode = extractErrorCode();

        if (statusCode == 401) {
          // 401: Invalid credentials or unauthorized
          // Response: { "error": "string", "message": "string" }
          return AuthFailure(
            message: errorMessage,
            code: errorCode ?? 'UNAUTHORIZED',
          );
        }

        if (statusCode == 404) {
          // 404: Not found (endpoint offline, resource not found, etc.)
          // Response can be JSON or plain text (e.g., ngrok offline message)
          return NetworkFailure(
            message: errorMessage,
            code: errorCode ?? 'NOT_FOUND',
          );
        }

        if (statusCode == 422) {
          // 422: Validation error
          // Response: { "error": "string", "message": "string", "details": {} }
          if (responseData is Map<String, dynamic>) {
            try {
              final apiError = ApiErrorResponse.fromJson(responseData);
              final fullMessage = apiError.getFullErrorMessage(errorMessage);
              return ValidationFailure(
                message: fullMessage,
                code: errorCode ?? apiError.getErrorCode(),
              );
            } catch (e) {
              // Fallback if parsing fails
            }
          }
          return ValidationFailure(message: errorMessage, code: errorCode);
        }

        if (statusCode == 500) {
          // 500: Internal server error
          // Response: { "statusCode": number, "code": "string",
          //   "error": "string", "message": "string" }
          return NetworkFailure(
            message: errorMessage,
            code: errorCode ?? 'SERVER_ERROR',
          );
        }

        if (statusCode == 502 || statusCode == 503) {
          // 502/503: Upstream error or service unavailable
          // Response: { "statusCode": number, "code": "string",
          //   "error": "string", "message": "string" }
          // Example: { "statusCode": 503, "code": "UPSTREAM_UNAVAILABLE",
          //   "error": "Service Unavailable", "message": "Users service unavailable" }
          return NetworkFailure(
            message: errorMessage,
            code: errorCode ?? 'SERVICE_UNAVAILABLE',
          );
        }

        // Other error status codes
        final finalCode =
            errorCode ?? statusCode?.toString() ?? 'UNKNOWN_ERROR';
        return NetworkFailure(message: errorMessage, code: finalCode);

      case DioExceptionType.connectionError:
        return const NetworkFailure.noConnection();
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return NetworkFailure.serverError(
          error.message ?? 'Network error occurred',
        );
    }
  }
}
