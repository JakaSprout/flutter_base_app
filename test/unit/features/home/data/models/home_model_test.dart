import 'package:flutter_base_app/features/home/data/models/home_model.dart';
import 'package:flutter_base_app/features/home/data/models/pond_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeModel', () {
    test('should create HomeModel with all required fields', () {
      // Arrange
      const ponds = [
        PondModel(id: 'TKH00A1', name: 'Kolam A1'),
        PondModel(id: 'TKH00A2', name: 'Kolam A2'),
      ];
      const companies = ['PT. Tambak Bersama', 'PT. Company Lain'];

      // Act
      const model = HomeModel(
        activePonds: 8,
        estimasiBiomassa: '1250',
        totalPakan: '1.000',
        biayaPakan: '20',
        estimasiSR: '100',
        ponds: ponds,
        companies: companies,
        selectedCompany: 'PT. Tambak Bersama',
      );

      // Assert
      expect(model.activePonds, equals(8));
      expect(model.estimasiBiomassa, equals('1250'));
      expect(model.totalPakan, equals('1.000'));
      expect(model.biayaPakan, equals('20'));
      expect(model.estimasiSR, equals('100'));
      expect(model.ponds.length, equals(2));
      expect(model.companies.length, equals(2));
      expect(model.selectedCompany, equals('PT. Tambak Bersama'));
    });

    test('should create HomeModel without selectedCompany', () {
      // Arrange
      const ponds = [PondModel(id: 'TKH00A1', name: 'Kolam A1')];
      const companies = ['PT. Tambak Bersama'];

      // Act
      const model = HomeModel(
        activePonds: 5,
        estimasiBiomassa: '1000',
        totalPakan: '500',
        biayaPakan: '10',
        estimasiSR: '95',
        ponds: ponds,
        companies: companies,
      );

      // Assert
      expect(model.selectedCompany, isNull);
    });
  });

  group('fromJson', () {
    test('should create HomeModel from valid JSON', () {
      // Arrange
      final json = {
        'activePonds': 8,
        'estimasiBiomassa': '1250',
        'totalPakan': '1.000',
        'biayaPakan': '20',
        'estimasiSR': '100',
        'ponds': [
          {'id': 'TKH00A1', 'name': 'Kolam A1'},
          {'id': 'TKH00A2', 'name': 'Kolam A2'},
        ],
        'companies': ['PT. Tambak Bersama', 'PT. Company Lain'],
        'selectedCompany': 'PT. Tambak Bersama',
      };

      // Act
      final model = HomeModel.fromJson(json);

      // Assert
      expect(model.activePonds, equals(8));
      expect(model.estimasiBiomassa, equals('1250'));
      expect(model.totalPakan, equals('1.000'));
      expect(model.biayaPakan, equals('20'));
      expect(model.estimasiSR, equals('100'));
      expect(model.ponds.length, equals(2));
      expect(model.companies.length, equals(2));
      expect(model.selectedCompany, equals('PT. Tambak Bersama'));
    });

    test('should create HomeModel from JSON without selectedCompany', () {
      // Arrange
      final json = {
        'activePonds': 5,
        'estimasiBiomassa': '1000',
        'totalPakan': '500',
        'biayaPakan': '10',
        'estimasiSR': '95',
        'ponds': [
          {'id': 'TKH00A1', 'name': 'Kolam A1'},
        ],
        'companies': ['PT. Tambak Bersama'],
      };

      // Act
      final model = HomeModel.fromJson(json);

      // Assert
      expect(model.selectedCompany, isNull);
    });

    test('should handle empty lists', () {
      // Arrange
      final json = {
        'activePonds': 0,
        'estimasiBiomassa': '0',
        'totalPakan': '0',
        'biayaPakan': '0',
        'estimasiSR': '0',
        'ponds': <Map<String, dynamic>>[],
        'companies': <String>[],
      };

      // Act
      final model = HomeModel.fromJson(json);

      // Assert
      expect(model.ponds, isEmpty);
      expect(model.companies, isEmpty);
    });
  });

  group('toJson', () {
    test('should convert HomeModel to JSON', () {
      // Arrange
      const model = HomeModel(
        activePonds: 8,
        estimasiBiomassa: '1250',
        totalPakan: '1.000',
        biayaPakan: '20',
        estimasiSR: '100',
        ponds: [
          PondModel(id: 'TKH00A1', name: 'Kolam A1'),
          PondModel(id: 'TKH00A2', name: 'Kolam A2'),
        ],
        companies: ['PT. Tambak Bersama', 'PT. Company Lain'],
        selectedCompany: 'PT. Tambak Bersama',
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['activePonds'], equals(8));
      expect(json['estimasiBiomassa'], equals('1250'));
      expect(json['totalPakan'], equals('1.000'));
      expect(json['biayaPakan'], equals('20'));
      expect(json['estimasiSR'], equals('100'));
      expect(json['ponds'], isA<List>());
      expect(json['companies'], isA<List>());
      expect(json['selectedCompany'], equals('PT. Tambak Bersama'));
    });

    test('should convert HomeModel to JSON without selectedCompany', () {
      // Arrange
      const model = HomeModel(
        activePonds: 5,
        estimasiBiomassa: '1000',
        totalPakan: '500',
        biayaPakan: '10',
        estimasiSR: '95',
        ponds: [PondModel(id: 'TKH00A1', name: 'Kolam A1')],
        companies: ['PT. Tambak Bersama'],
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['selectedCompany'], isNull);
    });

    test('should maintain round-trip conversion', () {
      // Arrange
      final originalJson = {
        'activePonds': 8,
        'estimasiBiomassa': '1250',
        'totalPakan': '1.000',
        'biayaPakan': '20',
        'estimasiSR': '100',
        'ponds': [
          {'id': 'TKH00A1', 'name': 'Kolam A1'},
          {'id': 'TKH00A2', 'name': 'Kolam A2'},
        ],
        'companies': ['PT. Tambak Bersama', 'PT. Company Lain'],
        'selectedCompany': 'PT. Tambak Bersama',
      };

      // Act
      final model = HomeModel.fromJson(originalJson);
      final convertedJson = model.toJson();

      // Assert
      expect(convertedJson['activePonds'], equals(originalJson['activePonds']));
      expect(
        convertedJson['estimasiBiomassa'],
        equals(originalJson['estimasiBiomassa']),
      );
      expect(convertedJson['totalPakan'], equals(originalJson['totalPakan']));
      expect(convertedJson['biayaPakan'], equals(originalJson['biayaPakan']));
      expect(convertedJson['estimasiSR'], equals(originalJson['estimasiSR']));
      expect(convertedJson['companies'], equals(originalJson['companies']));
      expect(
        convertedJson['selectedCompany'],
        equals(originalJson['selectedCompany']),
      );
    });
  });
}

