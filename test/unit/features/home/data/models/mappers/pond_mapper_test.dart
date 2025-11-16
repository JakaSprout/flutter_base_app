import 'package:flutter_base_app/features/home/data/models/mappers/pond_mapper.dart';
import 'package:flutter_base_app/features/home/data/models/pond_model.dart';
import 'package:flutter_base_app/features/home/domain/entities/pond_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PondMapper', () {
    group('toEntity', () {
      test('should convert PondModel to PondEntity', () {
        // Arrange
        const pondModel = PondModel(id: 'pond1', name: 'Pond 1');

        // Act
        final result = PondMapper.toEntity(pondModel);

        // Assert
        expect(result, isA<PondEntity>());
        expect(result.id, equals('pond1'));
        expect(result.name, equals('Pond 1'));
      });

      test('should handle empty strings', () {
        // Arrange
        const pondModel = PondModel(id: '', name: '');

        // Act
        final result = PondMapper.toEntity(pondModel);

        // Assert
        expect(result.id, isEmpty);
        expect(result.name, isEmpty);
      });

      test('should handle long strings', () {
        // Arrange
        const longId = 'pond-12345678901234567890';
        const longName = 'Very Long Pond Name That Exceeds Normal Length';
        const pondModel = PondModel(id: longId, name: longName);

        // Act
        final result = PondMapper.toEntity(pondModel);

        // Assert
        expect(result.id, equals(longId));
        expect(result.name, equals(longName));
      });
    });

    group('toModel', () {
      test('should convert PondEntity to PondModel', () {
        // Arrange
        const pondEntity = PondEntity(id: 'pond1', name: 'Pond 1');

        // Act
        final result = PondMapper.toModel(pondEntity);

        // Assert
        expect(result, isA<PondModel>());
        expect(result.id, equals('pond1'));
        expect(result.name, equals('Pond 1'));
      });

      test('should handle empty strings', () {
        // Arrange
        const pondEntity = PondEntity(id: '', name: '');

        // Act
        final result = PondMapper.toModel(pondEntity);

        // Assert
        expect(result.id, isEmpty);
        expect(result.name, isEmpty);
      });

      test('should handle long strings', () {
        // Arrange
        const longId = 'pond-12345678901234567890';
        const longName = 'Very Long Pond Name That Exceeds Normal Length';
        const pondEntity = PondEntity(id: longId, name: longName);

        // Act
        final result = PondMapper.toModel(pondEntity);

        // Assert
        expect(result.id, equals(longId));
        expect(result.name, equals(longName));
      });

      test('should maintain round-trip conversion', () {
        // Arrange
        const originalModel = PondModel(id: 'pond1', name: 'Pond 1');

        // Act
        final entity = PondMapper.toEntity(originalModel);
        final convertedModel = PondMapper.toModel(entity);

        // Assert
        expect(convertedModel.id, equals(originalModel.id));
        expect(convertedModel.name, equals(originalModel.name));
      });
    });
  });
}

