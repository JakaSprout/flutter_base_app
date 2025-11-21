import 'package:flutter_base_app/features/home/data/models/pond_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PondModel', () {
    test('should create PondModel with id and name', () {
      // Act
      const model = PondModel(id: 'TKH00A1', name: 'Kolam A1');

      // Assert
      expect(model.id, equals('TKH00A1'));
      expect(model.name, equals('Kolam A1'));
    });

    test('should create PondModel with different values', () {
      // Act
      const model = PondModel(id: 'TKH00B2', name: 'Kolam B2');

      // Assert
      expect(model.id, equals('TKH00B2'));
      expect(model.name, equals('Kolam B2'));
    });
  });

  group('fromJson', () {
    test('should create PondModel from valid JSON', () {
      // Arrange
      final json = {'id': 'TKH00A1', 'name': 'Kolam A1'};

      // Act
      final model = PondModel.fromJson(json);

      // Assert
      expect(model.id, equals('TKH00A1'));
      expect(model.name, equals('Kolam A1'));
    });

    test('should handle empty strings', () {
      // Arrange
      final json = {'id': '', 'name': ''};

      // Act
      final model = PondModel.fromJson(json);

      // Assert
      expect(model.id, isEmpty);
      expect(model.name, isEmpty);
    });

    test('should handle long strings', () {
      // Arrange
      final longId = 'TKH${'0' * 100}';
      final longName = 'Kolam ${'A' * 100}';
      final json = {'id': longId, 'name': longName};

      // Act
      final model = PondModel.fromJson(json);

      // Assert
      expect(model.id, equals(longId));
      expect(model.name, equals(longName));
    });
  });

  group('toJson', () {
    test('should convert PondModel to JSON', () {
      // Arrange
      const model = PondModel(id: 'TKH00A1', name: 'Kolam A1');

      // Act
      final json = model.toJson();

      // Assert
      expect(json['id'], equals('TKH00A1'));
      expect(json['name'], equals('Kolam A1'));
    });

    test('should maintain round-trip conversion', () {
      // Arrange
      final originalJson = {'id': 'TKH00A1', 'name': 'Kolam A1'};

      // Act
      final model = PondModel.fromJson(originalJson);
      final convertedJson = model.toJson();

      // Assert
      expect(convertedJson, equals(originalJson));
    });
  });
}
