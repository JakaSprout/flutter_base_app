import 'package:app_mobile_afms/features/home/data/models/banner_model.dart';
import 'package:app_mobile_afms/features/home/domain/entities/banner_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BannerModel', () {
    group('creation', () {
      test('should create model with required fields', () {
        // Arrange & Act
        const model = BannerModel(
          id: 'banner1',
          title: 'Banner Title',
          description: 'Banner Description',
          imagePath: '/images/banner.png',
          backgroundColor: '#FF5733',
        );

        // Assert
        expect(model.id, equals('banner1'));
        expect(model.title, equals('Banner Title'));
        expect(model.description, equals('Banner Description'));
        expect(model.imagePath, equals('/images/banner.png'));
        expect(model.backgroundColor, equals('#FF5733'));
      });
    });

    group('fromJson', () {
      test('should create model from valid JSON', () {
        // Arrange
        final json = {
          'id': 'banner1',
          'title': 'Banner Title',
          'description': 'Banner Description',
          'imagePath': '/images/banner.png',
          'backgroundColor': '#FF5733',
        };

        // Act
        final model = BannerModel.fromJson(json);

        // Assert
        expect(model.id, equals('banner1'));
        expect(model.title, equals('Banner Title'));
        expect(model.description, equals('Banner Description'));
        expect(model.imagePath, equals('/images/banner.png'));
        expect(model.backgroundColor, equals('#FF5733'));
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'id': '',
          'title': '',
          'description': '',
          'imagePath': '',
          'backgroundColor': '',
        };

        // Act
        final model = BannerModel.fromJson(json);

        // Assert
        expect(model.id, isEmpty);
        expect(model.title, isEmpty);
        expect(model.description, isEmpty);
        expect(model.imagePath, isEmpty);
        expect(model.backgroundColor, isEmpty);
      });
    });

    group('toJson', () {
      test('should convert model to JSON', () {
        // Arrange
        const model = BannerModel(
          id: 'banner1',
          title: 'Banner Title',
          description: 'Banner Description',
          imagePath: '/images/banner.png',
          backgroundColor: '#FF5733',
        );

        // Act
        final json = model.toJson();

        // Assert
        expect(json['id'], equals('banner1'));
        expect(json['title'], equals('Banner Title'));
        expect(json['description'], equals('Banner Description'));
        expect(json['imagePath'], equals('/images/banner.png'));
        expect(json['backgroundColor'], equals('#FF5733'));
      });

      test('should maintain round-trip conversion', () {
        // Arrange
        final originalJson = {
          'id': 'banner1',
          'title': 'Banner Title',
          'description': 'Banner Description',
          'imagePath': '/images/banner.png',
          'backgroundColor': '#FF5733',
        };

        // Act
        final model = BannerModel.fromJson(originalJson);
        final convertedJson = model.toJson();

        // Assert
        expect(convertedJson, equals(originalJson));
      });
    });

    group('toEntity extension', () {
      test('should convert model to entity', () {
        // Arrange
        const model = BannerModel(
          id: 'banner1',
          title: 'Banner Title',
          description: 'Banner Description',
          imagePath: '/images/banner.png',
          backgroundColor: '#FF5733',
        );

        // Act
        final entity = model.toEntity();

        // Assert
        expect(entity, isA<BannerEntity>());
        expect(entity.id, equals('banner1'));
        expect(entity.title, equals('Banner Title'));
        expect(entity.description, equals('Banner Description'));
        expect(entity.imagePath, equals('/images/banner.png'));
        expect(entity.backgroundColor, equals('#FF5733'));
      });
    });

    group('toModel extension', () {
      test('should convert entity to model', () {
        // Arrange
        const entity = BannerEntity(
          id: 'banner1',
          title: 'Banner Title',
          description: 'Banner Description',
          imagePath: '/images/banner.png',
          backgroundColor: '#FF5733',
        );

        // Act
        final model = entity.toModel();

        // Assert
        expect(model, isA<BannerModel>());
        expect(model.id, equals('banner1'));
        expect(model.title, equals('Banner Title'));
        expect(model.description, equals('Banner Description'));
        expect(model.imagePath, equals('/images/banner.png'));
        expect(model.backgroundColor, equals('#FF5733'));
      });

      test('should maintain round-trip conversion', () {
        // Arrange
        const originalModel = BannerModel(
          id: 'banner1',
          title: 'Banner Title',
          description: 'Banner Description',
          imagePath: '/images/banner.png',
          backgroundColor: '#FF5733',
        );

        // Act
        final entity = originalModel.toEntity();
        final convertedModel = entity.toModel();

        // Assert
        expect(convertedModel.id, equals(originalModel.id));
        expect(convertedModel.title, equals(originalModel.title));
        expect(convertedModel.description, equals(originalModel.description));
        expect(convertedModel.imagePath, equals(originalModel.imagePath));
        expect(convertedModel.backgroundColor, equals(originalModel.backgroundColor));
      });
    });
  });
}

