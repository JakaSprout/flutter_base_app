import 'package:flutter_base_app/features/home/data/models/input_data_item_model.dart';
import 'package:flutter_base_app/features/home/domain/entities/input_data_item_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InputDataItemModel', () {
    group('creation', () {
      test('should create model with required fields', () {
        // Arrange & Act
        const model = InputDataItemModel(
          id: 'input1',
          label: 'Input Label',
          iconPath: '/icons/input.png',
          backgroundColor: '#FFFFFF',
          iconColor: '#000000',
          order: 1,
        );

        // Assert
        expect(model.id, equals('input1'));
        expect(model.label, equals('Input Label'));
        expect(model.iconPath, equals('/icons/input.png'));
        expect(model.backgroundColor, equals('#FFFFFF'));
        expect(model.iconColor, equals('#000000'));
        expect(model.order, equals(1));
      });
    });

    group('fromJson', () {
      test('should create model from valid JSON', () {
        // Arrange
        final json = {
          'id': 'input1',
          'label': 'Input Label',
          'iconPath': '/icons/input.png',
          'backgroundColor': '#FFFFFF',
          'iconColor': '#000000',
          'order': 1,
        };

        // Act
        final model = InputDataItemModel.fromJson(json);

        // Assert
        expect(model.id, equals('input1'));
        expect(model.label, equals('Input Label'));
        expect(model.iconPath, equals('/icons/input.png'));
        expect(model.backgroundColor, equals('#FFFFFF'));
        expect(model.iconColor, equals('#000000'));
        expect(model.order, equals(1));
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'id': '',
          'label': '',
          'iconPath': '',
          'backgroundColor': '',
          'iconColor': '',
          'order': 0,
        };

        // Act
        final model = InputDataItemModel.fromJson(json);

        // Assert
        expect(model.id, isEmpty);
        expect(model.label, isEmpty);
        expect(model.iconPath, isEmpty);
        expect(model.backgroundColor, isEmpty);
        expect(model.iconColor, isEmpty);
        expect(model.order, equals(0));
      });
    });

    group('toJson', () {
      test('should convert model to JSON', () {
        // Arrange
        const model = InputDataItemModel(
          id: 'input1',
          label: 'Input Label',
          iconPath: '/icons/input.png',
          backgroundColor: '#FFFFFF',
          iconColor: '#000000',
          order: 1,
        );

        // Act
        final json = model.toJson();

        // Assert
        expect(json['id'], equals('input1'));
        expect(json['label'], equals('Input Label'));
        expect(json['iconPath'], equals('/icons/input.png'));
        expect(json['backgroundColor'], equals('#FFFFFF'));
        expect(json['iconColor'], equals('#000000'));
        expect(json['order'], equals(1));
      });

      test('should maintain round-trip conversion', () {
        // Arrange
        final originalJson = {
          'id': 'input1',
          'label': 'Input Label',
          'iconPath': '/icons/input.png',
          'backgroundColor': '#FFFFFF',
          'iconColor': '#000000',
          'order': 1,
        };

        // Act
        final model = InputDataItemModel.fromJson(originalJson);
        final convertedJson = model.toJson();

        // Assert
        expect(convertedJson, equals(originalJson));
      });
    });

    group('toEntity extension', () {
      test('should convert model to entity', () {
        // Arrange
        const model = InputDataItemModel(
          id: 'input1',
          label: 'Input Label',
          iconPath: '/icons/input.png',
          backgroundColor: '#FFFFFF',
          iconColor: '#000000',
          order: 1,
        );

        // Act
        final entity = model.toEntity();

        // Assert
        expect(entity, isA<InputDataItemEntity>());
        expect(entity.id, equals('input1'));
        expect(entity.label, equals('Input Label'));
        expect(entity.iconPath, equals('/icons/input.png'));
        expect(entity.backgroundColor, equals('#FFFFFF'));
        expect(entity.iconColor, equals('#000000'));
        expect(entity.order, equals(1));
      });
    });

    group('toModel extension', () {
      test('should convert entity to model', () {
        // Arrange
        const entity = InputDataItemEntity(
          id: 'input1',
          label: 'Input Label',
          iconPath: '/icons/input.png',
          backgroundColor: '#FFFFFF',
          iconColor: '#000000',
          order: 1,
        );

        // Act
        final model = entity.toModel();

        // Assert
        expect(model, isA<InputDataItemModel>());
        expect(model.id, equals('input1'));
        expect(model.label, equals('Input Label'));
        expect(model.iconPath, equals('/icons/input.png'));
        expect(model.backgroundColor, equals('#FFFFFF'));
        expect(model.iconColor, equals('#000000'));
        expect(model.order, equals(1));
      });

      test('should maintain round-trip conversion', () {
        // Arrange
        const originalModel = InputDataItemModel(
          id: 'input1',
          label: 'Input Label',
          iconPath: '/icons/input.png',
          backgroundColor: '#FFFFFF',
          iconColor: '#000000',
          order: 1,
        );

        // Act
        final entity = originalModel.toEntity();
        final convertedModel = entity.toModel();

        // Assert
        expect(convertedModel.id, equals(originalModel.id));
        expect(convertedModel.label, equals(originalModel.label));
        expect(convertedModel.iconPath, equals(originalModel.iconPath));
        expect(convertedModel.backgroundColor, equals(originalModel.backgroundColor));
        expect(convertedModel.iconColor, equals(originalModel.iconColor));
        expect(convertedModel.order, equals(originalModel.order));
      });
    });
  });
}

