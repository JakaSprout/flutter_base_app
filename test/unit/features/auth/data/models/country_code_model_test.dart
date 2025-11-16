import 'package:flutter_base_app/features/auth/data/models/country_code_model.dart';
import 'package:flutter_base_app/features/auth/domain/entities/country_code.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CountryCodeModel', () {
    group('creation', () {
      test('should create model with required fields', () {
        // Arrange & Act
        const model = CountryCodeModel(
          code: 'ID',
          dialCode: '+62',
          name: 'Indonesia',
          flag: '🇮🇩',
        );

        // Assert
        expect(model.code, equals('ID'));
        expect(model.dialCode, equals('+62'));
        expect(model.name, equals('Indonesia'));
        expect(model.flag, equals('🇮🇩'));
      });

      test('should create model without optional flag', () {
        // Arrange & Act
        const model = CountryCodeModel(
          code: 'US',
          dialCode: '+1',
          name: 'United States',
        );

        // Assert
        expect(model.code, equals('US'));
        expect(model.dialCode, equals('+1'));
        expect(model.name, equals('United States'));
        expect(model.flag, isNull);
      });
    });

    group('fromJson', () {
      test('should create model from valid JSON with flag', () {
        // Arrange
        final json = {
          'code': 'ID',
          'dialCode': '+62',
          'name': 'Indonesia',
          'flag': '🇮🇩',
        };

        // Act
        final model = CountryCodeModel.fromJson(json);

        // Assert
        expect(model.code, equals('ID'));
        expect(model.dialCode, equals('+62'));
        expect(model.name, equals('Indonesia'));
        expect(model.flag, equals('🇮🇩'));
      });

      test('should create model from valid JSON without flag', () {
        // Arrange
        final json = {
          'code': 'US',
          'dialCode': '+1',
          'name': 'United States',
        };

        // Act
        final model = CountryCodeModel.fromJson(json);

        // Assert
        expect(model.code, equals('US'));
        expect(model.dialCode, equals('+1'));
        expect(model.name, equals('United States'));
        expect(model.flag, isNull);
      });

      test('should handle null flag in JSON', () {
        // Arrange
        final json = {
          'code': 'GB',
          'dialCode': '+44',
          'name': 'United Kingdom',
          'flag': null,
        };

        // Act
        final model = CountryCodeModel.fromJson(json);

        // Assert
        expect(model.code, equals('GB'));
        expect(model.dialCode, equals('+44'));
        expect(model.name, equals('United Kingdom'));
        expect(model.flag, isNull);
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'code': '',
          'dialCode': '',
          'name': '',
        };

        // Act
        final model = CountryCodeModel.fromJson(json);

        // Assert
        expect(model.code, isEmpty);
        expect(model.dialCode, isEmpty);
        expect(model.name, isEmpty);
        expect(model.flag, isNull);
      });
    });

    group('toJson', () {
      test('should convert model to JSON with flag', () {
        // Arrange
        const model = CountryCodeModel(
          code: 'ID',
          dialCode: '+62',
          name: 'Indonesia',
          flag: '🇮🇩',
        );

        // Act
        final json = model.toJson();

        // Assert
        expect(json['code'], equals('ID'));
        expect(json['dialCode'], equals('+62'));
        expect(json['name'], equals('Indonesia'));
        expect(json['flag'], equals('🇮🇩'));
      });

      test('should convert model to JSON without flag', () {
        // Arrange
        const model = CountryCodeModel(
          code: 'US',
          dialCode: '+1',
          name: 'United States',
        );

        // Act
        final json = model.toJson();

        // Assert
        expect(json['code'], equals('US'));
        expect(json['dialCode'], equals('+1'));
        expect(json['name'], equals('United States'));
        expect(json['flag'], isNull);
      });

      test('should maintain round-trip conversion', () {
        // Arrange
        final originalJson = {
          'code': 'ID',
          'dialCode': '+62',
          'name': 'Indonesia',
          'flag': '🇮🇩',
        };

        // Act
        final model = CountryCodeModel.fromJson(originalJson);
        final convertedJson = model.toJson();

        // Assert
        expect(convertedJson['code'], equals(originalJson['code']));
        expect(convertedJson['dialCode'], equals(originalJson['dialCode']));
        expect(convertedJson['name'], equals(originalJson['name']));
        expect(convertedJson['flag'], equals(originalJson['flag']));
      });
    });

    group('toEntity extension', () {
      test('should convert model to entity with flag', () {
        // Arrange
        const model = CountryCodeModel(
          code: 'ID',
          dialCode: '+62',
          name: 'Indonesia',
          flag: '🇮🇩',
        );

        // Act
        final entity = model.toEntity();

        // Assert
        expect(entity, isA<CountryCode>());
        expect(entity.code, equals('ID'));
        expect(entity.dialCode, equals('+62'));
        expect(entity.name, equals('Indonesia'));
        expect(entity.flag, equals('🇮🇩'));
      });

      test('should convert model to entity without flag', () {
        // Arrange
        const model = CountryCodeModel(
          code: 'US',
          dialCode: '+1',
          name: 'United States',
        );

        // Act
        final entity = model.toEntity();

        // Assert
        expect(entity.code, equals('US'));
        expect(entity.dialCode, equals('+1'));
        expect(entity.name, equals('United States'));
        expect(entity.flag, isNull);
      });
    });

    group('toModel extension', () {
      test('should convert entity to model with flag', () {
        // Arrange
        const entity = CountryCode(
          code: 'ID',
          dialCode: '+62',
          name: 'Indonesia',
          flag: '🇮🇩',
        );

        // Act
        final model = entity.toModel();

        // Assert
        expect(model, isA<CountryCodeModel>());
        expect(model.code, equals('ID'));
        expect(model.dialCode, equals('+62'));
        expect(model.name, equals('Indonesia'));
        expect(model.flag, equals('🇮🇩'));
      });

      test('should convert entity to model without flag', () {
        // Arrange
        const entity = CountryCode(
          code: 'US',
          dialCode: '+1',
          name: 'United States',
        );

        // Act
        final model = entity.toModel();

        // Assert
        expect(model.code, equals('US'));
        expect(model.dialCode, equals('+1'));
        expect(model.name, equals('United States'));
        expect(model.flag, isNull);
      });

      test('should maintain round-trip conversion', () {
        // Arrange
        const originalModel = CountryCodeModel(
          code: 'ID',
          dialCode: '+62',
          name: 'Indonesia',
          flag: '🇮🇩',
        );

        // Act
        final entity = originalModel.toEntity();
        final convertedModel = entity.toModel();

        // Assert
        expect(convertedModel.code, equals(originalModel.code));
        expect(convertedModel.dialCode, equals(originalModel.dialCode));
        expect(convertedModel.name, equals(originalModel.name));
        expect(convertedModel.flag, equals(originalModel.flag));
      });
    });
  });
}

