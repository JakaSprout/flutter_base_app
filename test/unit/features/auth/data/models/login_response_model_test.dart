import 'package:flutter_base_app/features/auth/data/models/login_response_model.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginResponseModel', () {
    test('should create LoginResponseModel with all fields', () {
      // Act
      const model = LoginResponseModel(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_456',
        userId: 'user_123',
        email: 'test@example.com',
        phoneNumber: '81234567890',
      );

      // Assert
      expect(model.accessToken, equals('access_token_123'));
      expect(model.refreshToken, equals('refresh_token_456'));
      expect(model.userId, equals('user_123'));
      expect(model.email, equals('test@example.com'));
      expect(model.phoneNumber, equals('81234567890'));
    });

    test('should create LoginResponseModel with required fields only', () {
      // Act
      const model = LoginResponseModel(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_456',
      );

      // Assert
      expect(model.accessToken, equals('access_token_123'));
      expect(model.refreshToken, equals('refresh_token_456'));
      expect(model.userId, isNull);
      expect(model.email, isNull);
      expect(model.phoneNumber, isNull);
    });

    test('should create LoginResponseModel with email only', () {
      // Act
      const model = LoginResponseModel(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_456',
        email: 'test@example.com',
      );

      // Assert
      expect(model.email, equals('test@example.com'));
      expect(model.phoneNumber, isNull);
    });

    test('should create LoginResponseModel with phoneNumber only', () {
      // Act
      const model = LoginResponseModel(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_456',
        phoneNumber: '81234567890',
      );

      // Assert
      expect(model.phoneNumber, equals('81234567890'));
      expect(model.email, isNull);
    });
  });

  group('LoginResponseModelExtension', () {
    test('should convert to LoginResponse entity with all fields', () {
      // Arrange
      const model = LoginResponseModel(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_456',
        userId: 'user_123',
        email: 'test@example.com',
        phoneNumber: '81234567890',
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity, isA<LoginResponse>());
      expect(entity.accessToken, equals('access_token_123'));
      expect(entity.refreshToken, equals('refresh_token_456'));
      expect(entity.userId, equals('user_123'));
      expect(entity.email, equals('test@example.com'));
      expect(entity.phoneNumber, equals('81234567890'));
    });

    test(
      'should convert to LoginResponse entity with null optional fields',
      () {
        // Arrange
        const model = LoginResponseModel(
          accessToken: 'access_token_123',
          refreshToken: 'refresh_token_456',
        );

        // Act
        final entity = model.toEntity();

        // Assert
        expect(entity, isA<LoginResponse>());
        expect(entity.accessToken, equals('access_token_123'));
        expect(entity.refreshToken, equals('refresh_token_456'));
        expect(entity.userId, isNull);
        expect(entity.email, isNull);
        expect(entity.phoneNumber, isNull);
      },
    );

    test('should convert to LoginResponse entity with email only', () {
      // Arrange
      const model = LoginResponseModel(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_456',
        email: 'test@example.com',
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.email, equals('test@example.com'));
      expect(entity.phoneNumber, isNull);
    });

    test('should convert to LoginResponse entity with phoneNumber only', () {
      // Arrange
      const model = LoginResponseModel(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_456',
        phoneNumber: '81234567890',
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.phoneNumber, equals('81234567890'));
      expect(entity.email, isNull);
    });
  });

  group('fromJson', () {
    test(
      'should create LoginResponseModel from valid JSON with all fields',
      () {
        // Arrange
        final json = {
          'accessToken': 'access_token_123',
          'refreshToken': 'refresh_token_456',
          'userId': 'user_123',
          'email': 'test@example.com',
          'phoneNumber': '81234567890',
        };

        // Act
        final model = LoginResponseModel.fromJson(json);

        // Assert
        expect(model.accessToken, equals('access_token_123'));
        expect(model.refreshToken, equals('refresh_token_456'));
        expect(model.userId, equals('user_123'));
        expect(model.email, equals('test@example.com'));
        expect(model.phoneNumber, equals('81234567890'));
      },
    );

    test(
      'should create LoginResponseModel from JSON with required fields only',
      () {
        // Arrange
        final json = {
          'accessToken': 'access_token_123',
          'refreshToken': 'refresh_token_456',
        };

        // Act
        final model = LoginResponseModel.fromJson(json);

        // Assert
        expect(model.accessToken, equals('access_token_123'));
        expect(model.refreshToken, equals('refresh_token_456'));
        expect(model.userId, isNull);
        expect(model.email, isNull);
        expect(model.phoneNumber, isNull);
      },
    );

    test('should handle null optional fields in JSON', () {
      // Arrange
      final json = {
        'accessToken': 'access_token_123',
        'refreshToken': 'refresh_token_456',
        'userId': null,
        'email': null,
        'phoneNumber': null,
      };

      // Act
      final model = LoginResponseModel.fromJson(json);

      // Assert
      expect(model.userId, isNull);
      expect(model.email, isNull);
      expect(model.phoneNumber, isNull);
    });
  });

  group('toJson', () {
    test('should convert LoginResponseModel to JSON with all fields', () {
      // Arrange
      const model = LoginResponseModel(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_456',
        userId: 'user_123',
        email: 'test@example.com',
        phoneNumber: '81234567890',
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['accessToken'], equals('access_token_123'));
      expect(json['refreshToken'], equals('refresh_token_456'));
      expect(json['userId'], equals('user_123'));
      expect(json['email'], equals('test@example.com'));
      expect(json['phoneNumber'], equals('81234567890'));
    });

    test(
      'should convert LoginResponseModel to JSON without optional fields',
      () {
        // Arrange
        const model = LoginResponseModel(
          accessToken: 'access_token_123',
          refreshToken: 'refresh_token_456',
        );

        // Act
        final json = model.toJson();

        // Assert
        expect(json['accessToken'], equals('access_token_123'));
        expect(json['refreshToken'], equals('refresh_token_456'));
        expect(json['userId'], isNull);
        expect(json['email'], isNull);
        expect(json['phoneNumber'], isNull);
      },
    );

    test('should maintain round-trip conversion', () {
      // Arrange
      final originalJson = {
        'accessToken': 'access_token_123',
        'refreshToken': 'refresh_token_456',
        'userId': 'user_123',
        'email': 'test@example.com',
        'phoneNumber': '81234567890',
      };

      // Act
      final model = LoginResponseModel.fromJson(originalJson);
      final convertedJson = model.toJson();

      // Assert
      expect(convertedJson['accessToken'], equals(originalJson['accessToken']));
      expect(
        convertedJson['refreshToken'],
        equals(originalJson['refreshToken']),
      );
      expect(convertedJson['userId'], equals(originalJson['userId']));
      expect(convertedJson['email'], equals(originalJson['email']));
      expect(convertedJson['phoneNumber'], equals(originalJson['phoneNumber']));
    });
  });
}
