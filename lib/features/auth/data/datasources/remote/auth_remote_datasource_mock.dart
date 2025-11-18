import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/auth/data/datasources/remote/auth_mock_data.dart';
import 'package:flutter_base_app/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:flutter_base_app/features/auth/data/models/login_response_model.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_request.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Mock implementation of [AuthRemoteDataSource].
///
/// This provides fake/mock data for development and testing.
/// In production, this should be replaced with actual API calls.
///
/// This implementation follows the same structure as [AuthRemoteDataSourceImpl]
/// to ensure consistency between mock and real API responses.
class AuthRemoteDataSourceMock implements AuthRemoteDataSource {
  /// Creates a new instance of [AuthRemoteDataSourceMock].
  AuthRemoteDataSourceMock({
    required AppConfig config,
    required FlutterSecureStorage secureStorage,
  }) : _config = config,
       _secureStorage = secureStorage;

  final AppConfig _config;
  final FlutterSecureStorage _secureStorage;

  /// Simulate network delay.
  Future<void> _simulateDelay() async {
    final delay = _config.mockApiDelayMs;
    if (delay > 0) {
      await Future<void>.delayed(Duration(milliseconds: delay));
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> loginWithPhone(
    PhoneLoginRequest request,
  ) async {
    await _simulateDelay();

    try {
      // ✅ Priority 3: Simulate request payload (validate structure)
      final requestPayload = AuthMockData.createPhoneLoginRequestPayload(
        phoneNumber: request.phoneNumber,
      );

      // Mock validation (phone login doesn't require password)
      if (request.phoneNumber.isEmpty) {
        return const Left(
          ValidationFailure(message: AuthConstants.errorPhoneNumberRequired),
        );
      }

      // Validate phone number length (digits only)
      final digitsOnly = request.phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
      if (digitsOnly.length < AuthConstants.phoneMinDigits ||
          digitsOnly.length > AuthConstants.phoneMaxDigits) {
        return const Left(
          ValidationFailure(message: AuthConstants.errorPhoneNumberLength),
        );
      }

      // ✅ Priority 1: Generate tokens with sessionId support
      final sessionId = AuthMockData.generateSessionId();
      final accessToken = AuthMockData.generateAccessToken();
      final refreshToken = AuthMockData.generateRefreshToken();

      // ✅ Priority 3: Create user object
      final userObject = AuthMockData.createPhoneUserObject(
        phoneNumber: requestPayload['phone'] as String,
      );

      // ✅ Priority 1: Create nested response structure (matches Real API)
      final mockResponseData = AuthMockData.createLoginResponseData(
        sessionId: sessionId,
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: AuthMockData.defaultTokenExpirationSeconds,
        tokenType: AuthMockData.defaultTokenType,
        user: userObject,
      );

      // ✅ Priority 1: Parse nested structure like Real API
      final outerData = mockResponseData['data'] as Map<String, dynamic>?;
      if (outerData == null) {
        return const Left(
          NetworkFailure.serverError('Invalid response format'),
        );
      }

      final innerData = outerData['data'] as Map<String, dynamic>?;
      if (innerData == null) {
        return const Left(
          NetworkFailure.serverError('Invalid response format: missing data'),
        );
      }

      // Map to LoginResponseModel (same as Real API)
      final loginResponse = LoginResponseModel(
        accessToken: innerData['accessToken'] as String?,
        refreshToken: innerData['refreshToken'] as String?,
        sessionId: innerData['sessionId'] as String?,
        expiresIn: innerData['expiresIn'] as int?,
        tokenType: innerData['tokenType'] as String? ?? 'Bearer',
        user:
            innerData['user'] as Map<String, dynamic>? ??
            outerData['user'] as Map<String, dynamic>?,
        phoneNumber: requestPayload['phone'] as String,
      );

      return Right(loginResponse);
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
    await _simulateDelay();

    try {
      // ✅ Priority 3: Simulate request payload (validate structure)
      final requestPayload = AuthMockData.createEmailLoginRequestPayload(
        email: request.email,
        password: request.password,
      );

      // Mock validation
      if (request.email.isEmpty || request.password.isEmpty) {
        return const Left(
          ValidationFailure(
            message: AuthConstants.errorEmailAndPasswordRequired,
          ),
        );
      }

      // Mock email format validation
      if (!request.email.contains('@')) {
        return const Left(
          ValidationFailure(message: AuthConstants.errorInvalidEmailFormat),
        );
      }

      // ✅ Priority 1: Generate tokens with sessionId support
      final sessionId = AuthMockData.generateSessionId();
      final accessToken = AuthMockData.generateAccessToken();
      final refreshToken = AuthMockData.generateRefreshToken();

      // ✅ Priority 3: Create user object
      final userObject = AuthMockData.createEmailUserObject(
        email: requestPayload['email'] as String,
      );

      // ✅ Priority 1: Create nested response structure (matches Real API)
      final mockResponseData = AuthMockData.createLoginResponseData(
        sessionId: sessionId,
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: AuthMockData.defaultTokenExpirationSeconds,
        tokenType: AuthMockData.defaultTokenType,
        user: userObject,
      );

      // ✅ Priority 1: Parse nested structure like Real API
      final outerData = mockResponseData['data'] as Map<String, dynamic>?;
      if (outerData == null) {
        return const Left(
          NetworkFailure.serverError('Invalid response format'),
        );
      }

      final innerData = outerData['data'] as Map<String, dynamic>?;
      if (innerData == null) {
        return const Left(
          NetworkFailure.serverError('Invalid response format: missing data'),
        );
      }

      // Map to LoginResponseModel (same as Real API)
      final loginResponse = LoginResponseModel(
        accessToken: innerData['accessToken'] as String?,
        refreshToken: innerData['refreshToken'] as String?,
        sessionId: innerData['sessionId'] as String?,
        expiresIn: innerData['expiresIn'] as int?,
        tokenType: innerData['tokenType'] as String? ?? 'Bearer',
        user:
            innerData['user'] as Map<String, dynamic>? ??
            outerData['user'] as Map<String, dynamic>?,
        email: requestPayload['email'] as String,
      );

      return Right(loginResponse);
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
    await _simulateDelay();

    try {
      // ✅ Priority 3: Simulate request payload (validate structure)
      // This ensures request structure matches Real API
      AuthMockData.createRefreshTokenRequestPayload(refreshToken: refreshToken);

      // ✅ Priority 1: Generate refreshed access token
      final refreshedAccessToken = AuthMockData.generateRefreshedAccessToken();

      // ✅ Priority 3: Create user object
      final userObject = AuthMockData.createRefreshUserObject();

      // ✅ Priority 1: Create nested response structure (matches Real API)
      final mockResponseData = AuthMockData.createRefreshTokenResponseData(
        accessToken: refreshedAccessToken,
        refreshToken: refreshToken, // Keep same refresh token
        expiresIn: AuthMockData.defaultTokenExpirationSeconds,
        tokenType: AuthMockData.defaultTokenType,
        user: userObject,
      );

      // ✅ Priority 1: Parse nested structure like Real API
      final data = mockResponseData['data'] as Map<String, dynamic>?;
      if (data == null) {
        return const Left(
          NetworkFailure.serverError('Invalid response format'),
        );
      }

      // Map to LoginResponseModel (same as Real API)
      final loginResponse = LoginResponseModel(
        accessToken: data['accessToken'] as String,
        refreshToken: data['refreshToken'] as String? ?? refreshToken,
        expiresIn: data['expiresIn'] as int,
        tokenType: data['tokenType'] as String? ?? 'Bearer',
        user: data['user'] as Map<String, dynamic>?,
      );

      return Right(loginResponse);
    } catch (e) {
      return Left(NetworkFailure.serverError('Token refresh failed: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    await _simulateDelay();

    try {
      // ✅ Priority 2: Simulate logout API call with sessionId (matches Real API)
      // Fetch session ID from secure storage to comply with API requirements
      final sessionId = await _secureStorage.read(
        key: AppConstants.storageAuthToken,
      );

      // ✅ Priority 3: Simulate request payload and headers
      // This ensures request structure matches Real API
      if (sessionId != null && sessionId.isNotEmpty) {
        AuthMockData.createLogoutRequestPayload(sessionId: sessionId);
        AuthMockData.createLogoutHeaders(sessionId: sessionId);
      }

      // Simulate validation: if no sessionId, return error (like Real API might)
      if (sessionId == null || sessionId.isEmpty) {
        // In mock, we'll still allow logout but log a warning
        // This matches Real API behavior where logout still succeeds even without sessionId
        return const Right(null);
      }

      // Simulate successful logout API call
      // In real implementation, this would be: await _dio.post<void>(...)
      // For mock, we just validate the request structure and return success
      return const Right(null);
    } catch (e) {
      // Even if logout API fails, we should still allow local logout
      // This matches Real API behavior
      return const Right(null);
    }
  }
}
