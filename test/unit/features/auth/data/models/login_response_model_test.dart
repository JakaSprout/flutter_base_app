import 'package:app_mobile_afms/features/auth/data/models/login_response_model.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginResponseModel', () {
    test('should create LoginResponseModel with employeeId', () {
      const model = LoginResponseModel(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_456',
        expiresIn: 3600,
        employeeId: 17,
        sessionId: 'session_abc',
      );

      expect(model.accessToken, equals('access_token_123'));
      expect(model.refreshToken, equals('refresh_token_456'));
      expect(model.expiresIn, equals(3600));
      expect(model.employeeId, equals(17));
      expect(model.sessionId, equals('session_abc'));
    });

    test('should allow creation without optional fields', () {
      const model = LoginResponseModel();
      expect(model.accessToken, isNull);
      expect(model.refreshToken, isNull);
      expect(model.employeeId, isNull);
      expect(model.sessionId, isNull);
    });
  });

  group('LoginResponseModelExtension', () {
    test('should convert to LoginResponse entity using employeeId', () {
      const model = LoginResponseModel(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_456',
        employeeId: 99,
        expiresIn: 1200,
      );

      final entity = model.toEntity();

      expect(entity.accessToken, equals('access_token_123'));
      expect(entity.refreshToken, equals('refresh_token_456'));
      expect(entity.employeeId, equals('99'));
      expect(entity.expiresIn, equals(1200));
    });

    test('should fallback to sessionId when access token is null', () {
      const model = LoginResponseModel(
        sessionId: 'session_only',
        employeeId: 5,
      );

      final entity = model.toEntity();

      expect(entity.accessToken, equals('session_only'));
      expect(entity.refreshToken, equals('session_only'));
      expect(entity.employeeId, equals('5'));
    });
  });

  group('fromJson / toJson', () {
    test('should deserialize JSON with employeeId', () {
      final json = {
        'accessToken': 'token',
        'refreshToken': 'refresh',
        'employeeId': 42,
        'sessionId': 'session',
      };

      final model = LoginResponseModel.fromJson(json);

      expect(model.accessToken, equals('token'));
      expect(model.refreshToken, equals('refresh'));
      expect(model.employeeId, equals(42));
      expect(model.sessionId, equals('session'));
    });

    test('should serialize to JSON with employeeId', () {
      const model = LoginResponseModel(
        accessToken: 'token',
        refreshToken: 'refresh',
        employeeId: 42,
      );

      final json = model.toJson();

      expect(json['accessToken'], equals('token'));
      expect(json['refreshToken'], equals('refresh'));
      expect(json['employeeId'], equals(42));
    });

    test('should round-trip JSON conversion', () {
      final original = {
        'accessToken': 'token',
        'refreshToken': 'refresh',
        'sessionId': 'session',
        'employeeId': 7,
      };

      final model = LoginResponseModel.fromJson(original);
      final converted = model.toJson();

      expect(converted['accessToken'], equals('token'));
      expect(converted['refreshToken'], equals('refresh'));
      expect(converted['employeeId'], equals(7));
      expect(converted['sessionId'], equals('session'));
    });
  });
}
