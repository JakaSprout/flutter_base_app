import 'package:flutter_base_app/features/home/data/models/home_model.dart';
import 'package:flutter_base_app/features/home/data/models/mappers/home_mapper.dart';
import 'package:flutter_base_app/features/home/data/models/pond_model.dart';
import 'package:flutter_base_app/features/home/domain/entities/home_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/pond_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeMapper', () {
    group('toEntity', () {
      test('should convert HomeModel to HomeData entity', () {
        // Arrange
        const homeModel = HomeModel(
          activePonds: 5,
          estimasiBiomassa: '1000 kg',
          totalPakan: '500 kg',
          biayaPakan: 'Rp 1.000.000',
          estimasiSR: '80%',
          ponds: [
            PondModel(id: 'pond1', name: 'Pond 1'),
            PondModel(id: 'pond2', name: 'Pond 2'),
          ],
          companies: ['Company A', 'Company B'],
          selectedCompany: 'Company A',
        );

        // Act
        final result = HomeMapper.toEntity(homeModel);

        // Assert
        expect(result, isA<HomeData>());
        expect(result.activePonds, equals(5));
        expect(result.estimasiBiomassa, equals('1000 kg'));
        expect(result.totalPakan, equals('500 kg'));
        expect(result.biayaPakan, equals('Rp 1.000.000'));
        expect(result.estimasiSR, equals('80%'));
        expect(result.ponds.length, equals(2));
        expect(result.ponds[0].id, equals('pond1'));
        expect(result.ponds[0].name, equals('Pond 1'));
        expect(result.ponds[1].id, equals('pond2'));
        expect(result.ponds[1].name, equals('Pond 2'));
        expect(result.companies, equals(['Company A', 'Company B']));
        expect(result.selectedCompany, equals('Company A'));
      });

      test('should handle empty ponds list', () {
        // Arrange
        const homeModel = HomeModel(
          activePonds: 0,
          estimasiBiomassa: '0 kg',
          totalPakan: '0 kg',
          biayaPakan: 'Rp 0',
          estimasiSR: '0%',
          ponds: [],
          companies: [],
        );

        // Act
        final result = HomeMapper.toEntity(homeModel);

        // Assert
        expect(result.ponds, isEmpty);
        expect(result.companies, isEmpty);
        expect(result.selectedCompany, isNull);
      });

      test('should handle null selectedCompany', () {
        // Arrange
        const homeModel = HomeModel(
          activePonds: 3,
          estimasiBiomassa: '500 kg',
          totalPakan: '250 kg',
          biayaPakan: 'Rp 500.000',
          estimasiSR: '75%',
          ponds: [PondModel(id: 'pond1', name: 'Pond 1')],
          companies: ['Company A'],
        );

        // Act
        final result = HomeMapper.toEntity(homeModel);

        // Assert
        expect(result.selectedCompany, isNull);
      });
    });

    group('toModel', () {
      test('should convert HomeData entity to HomeModel', () {
        // Arrange
        const homeData = HomeData(
          activePonds: 5,
          estimasiBiomassa: '1000 kg',
          totalPakan: '500 kg',
          biayaPakan: 'Rp 1.000.000',
          estimasiSR: '80%',
          ponds: [
            PondEntity(id: 'pond1', name: 'Pond 1'),
            PondEntity(id: 'pond2', name: 'Pond 2'),
          ],
          companies: ['Company A', 'Company B'],
          selectedCompany: 'Company A',
        );

        // Act
        final result = HomeMapper.toModel(homeData);

        // Assert
        expect(result, isA<HomeModel>());
        expect(result.activePonds, equals(5));
        expect(result.estimasiBiomassa, equals('1000 kg'));
        expect(result.totalPakan, equals('500 kg'));
        expect(result.biayaPakan, equals('Rp 1.000.000'));
        expect(result.estimasiSR, equals('80%'));
        expect(result.ponds.length, equals(2));
        expect(result.ponds[0].id, equals('pond1'));
        expect(result.ponds[0].name, equals('Pond 1'));
        expect(result.ponds[1].id, equals('pond2'));
        expect(result.ponds[1].name, equals('Pond 2'));
        expect(result.companies, equals(['Company A', 'Company B']));
        expect(result.selectedCompany, equals('Company A'));
      });

      test('should handle empty ponds list', () {
        // Arrange
        const homeData = HomeData(
          activePonds: 0,
          estimasiBiomassa: '0 kg',
          totalPakan: '0 kg',
          biayaPakan: 'Rp 0',
          estimasiSR: '0%',
          ponds: [],
          companies: [],
        );

        // Act
        final result = HomeMapper.toModel(homeData);

        // Assert
        expect(result.ponds, isEmpty);
        expect(result.companies, isEmpty);
        expect(result.selectedCompany, isNull);
      });

      test('should handle null selectedCompany', () {
        // Arrange
        const homeData = HomeData(
          activePonds: 3,
          estimasiBiomassa: '500 kg',
          totalPakan: '250 kg',
          biayaPakan: 'Rp 500.000',
          estimasiSR: '75%',
          ponds: [PondEntity(id: 'pond1', name: 'Pond 1')],
          companies: ['Company A'],
        );

        // Act
        final result = HomeMapper.toModel(homeData);

        // Assert
        expect(result.selectedCompany, isNull);
      });

      test('should maintain round-trip conversion', () {
        // Arrange
        const originalModel = HomeModel(
          activePonds: 5,
          estimasiBiomassa: '1000 kg',
          totalPakan: '500 kg',
          biayaPakan: 'Rp 1.000.000',
          estimasiSR: '80%',
          ponds: [
            PondModel(id: 'pond1', name: 'Pond 1'),
            PondModel(id: 'pond2', name: 'Pond 2'),
          ],
          companies: ['Company A', 'Company B'],
          selectedCompany: 'Company A',
        );

        // Act
        final entity = HomeMapper.toEntity(originalModel);
        final convertedModel = HomeMapper.toModel(entity);

        // Assert
        expect(convertedModel.activePonds, equals(originalModel.activePonds));
        expect(
          convertedModel.estimasiBiomassa,
          equals(originalModel.estimasiBiomassa),
        );
        expect(convertedModel.totalPakan, equals(originalModel.totalPakan));
        expect(convertedModel.biayaPakan, equals(originalModel.biayaPakan));
        expect(convertedModel.estimasiSR, equals(originalModel.estimasiSR));
        expect(convertedModel.ponds.length, equals(originalModel.ponds.length));
        expect(convertedModel.ponds[0].id, equals(originalModel.ponds[0].id));
        expect(
          convertedModel.ponds[0].name,
          equals(originalModel.ponds[0].name),
        );
        expect(convertedModel.companies, equals(originalModel.companies));
        expect(
          convertedModel.selectedCompany,
          equals(originalModel.selectedCompany),
        );
      });
    });
  });
}
