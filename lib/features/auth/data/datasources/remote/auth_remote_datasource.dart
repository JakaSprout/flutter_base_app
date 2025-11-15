import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/config/flavor_config.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/auth/data/models/country_code_model.dart';
import 'package:flutter_base_app/features/auth/data/models/login_response_model.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_request.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';

/// Remote data source interface for Auth feature.
abstract class AuthRemoteDataSource {
  /// Get list of supported country codes from remote API.
  Future<Either<Failure, List<CountryCodeModel>>> getCountryCodes();

  /// Login with phone number and password.
  Future<Either<Failure, LoginResponseModel>> loginWithPhone(
    PhoneLoginRequest request,
  );

  /// Login with email and password.
  Future<Either<Failure, LoginResponseModel>> loginWithEmail(
    EmailLoginRequest request,
  );
}

/// Mock implementation of [AuthRemoteDataSource].
///
/// This provides fake/mock data for development and testing.
/// In production, this should be replaced with actual API calls.
class AuthRemoteDataSourceMock implements AuthRemoteDataSource {
  /// Creates a new instance of [AuthRemoteDataSourceMock].
  AuthRemoteDataSourceMock({required AppConfig config}) : _config = config;

  final AppConfig _config;

  /// Simulate network delay.
  Future<void> _simulateDelay() async {
    final delay = FlavorConfig.getMockApiDelay(_config.flavor);
    if (delay > 0) {
      await Future<void>.delayed(Duration(milliseconds: delay));
    }
  }

  @override
  Future<Either<Failure, List<CountryCodeModel>>> getCountryCodes() async {
    await _simulateDelay();

    try {
      // Mock country codes - common countries
      final mockData = [
        const CountryCodeModel(
          code: 'ID',
          dialCode: '+62',
          name: 'Indonesia',
          flag: '🇮🇩',
        ),
        const CountryCodeModel(
          code: 'MY',
          dialCode: '+60',
          name: 'Malaysia',
          flag: '🇲🇾',
        ),
        const CountryCodeModel(
          code: 'SG',
          dialCode: '+65',
          name: 'Singapore',
          flag: '🇸🇬',
        ),
        const CountryCodeModel(
          code: 'TH',
          dialCode: '+66',
          name: 'Thailand',
          flag: '🇹🇭',
        ),
        const CountryCodeModel(
          code: 'PH',
          dialCode: '+63',
          name: 'Philippines',
          flag: '🇵🇭',
        ),
        const CountryCodeModel(
          code: 'VN',
          dialCode: '+84',
          name: 'Vietnam',
          flag: '🇻🇳',
        ),
        const CountryCodeModel(
          code: 'US',
          dialCode: '+1',
          name: 'United States',
          flag: '🇺🇸',
        ),
        const CountryCodeModel(
          code: 'GB',
          dialCode: '+44',
          name: 'United Kingdom',
          flag: '🇬🇧',
        ),
      ];

      return Right(mockData);
    } catch (e) {
      return Left(NetworkFailure.serverError(
        '${AuthConstants.errorFailedToGetCountryCodes}: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> loginWithPhone(
    PhoneLoginRequest request,
  ) async {
    await _simulateDelay();

    try {
      // Mock validation
      if (request.phoneNumber.isEmpty || request.password.isEmpty) {
        return const Left(
          ValidationFailure(
            message: AuthConstants.errorPhoneNumberAndPasswordRequired,
          ),
        );
      }

      // Validate phone number length (remove non-digit characters for validation)
      final phoneDigits = request.phoneNumber.replaceAll(RegExp(r'\D'), '');
      if (phoneDigits.length < AuthConstants.phoneMinDigits ||
          phoneDigits.length > AuthConstants.phoneMaxDigits) {
        return const Left(
          ValidationFailure(
            message: AuthConstants.errorPhoneNumberLength,
          ),
        );
      }

      // Mock successful login
      final mockResponse = LoginResponseModel(
        accessToken: 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken: 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        userId: 'user_123',
        phoneNumber: '${request.countryCode}${request.phoneNumber}',
      );

      return Right(mockResponse);
    } catch (e) {
      return Left(NetworkFailure.serverError(
        '${AuthConstants.errorLoginFailed}: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> loginWithEmail(
    EmailLoginRequest request,
  ) async {
    await _simulateDelay();

    try {
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

      // Mock successful login
      final mockResponse = LoginResponseModel(
        accessToken: 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken: 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        userId: 'user_456',
        email: request.email,
      );

      return Right(mockResponse);
    } catch (e) {
      return Left(NetworkFailure.serverError(
        '${AuthConstants.errorLoginFailed}: $e',
      ));
    }
  }
}

