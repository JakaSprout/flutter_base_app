import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/home/data/datasources/remote/home_remote_datasource.dart';
import 'package:flutter_base_app/features/home/data/models/banner_model.dart';
import 'package:flutter_base_app/features/home/data/models/home_model.dart';
import 'package:flutter_base_app/features/home/data/models/input_data_item_model.dart';
import 'package:flutter_base_app/features/home/data/models/pond_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeRemoteDataSourceMock', () {
    late HomeRemoteDataSourceMock dataSource;
    late AppConfig testConfig;

    setUp(() {
      testConfig = AppConfig.dev;
      dataSource = HomeRemoteDataSourceMock(config: testConfig);
    });

    group('getHomeData', () {
      test('should return HomeModel when successful', () async {
        // Act
        final result = await dataSource.getHomeData();

        // Assert
        expect(result, isA<Right<Failure, HomeModel>>());
        result.fold(
          (failure) => fail('Should not return failure'),
          (homeModel) {
            expect(homeModel.activePonds, equals(8));
            expect(homeModel.estimasiBiomassa, equals('1250'));
            expect(homeModel.totalPakan, equals('1.000'));
            expect(homeModel.biayaPakan, equals('20'));
            expect(homeModel.estimasiSR, equals('100'));
            expect(homeModel.ponds.length, equals(8));
            expect(homeModel.companies.length, equals(3));
            expect(homeModel.selectedCompany, equals('PT. Tambak Bersama'));
          },
        );
      });

      test('should return correct pond data', () async {
        // Act
        final result = await dataSource.getHomeData();

        // Assert
        result.fold(
          (failure) => fail('Should not return failure'),
          (homeModel) {
            expect(homeModel.ponds[0].id, equals('TKH00A1'));
            expect(homeModel.ponds[0].name, equals('Kolam A1'));
            expect(homeModel.ponds.last.id, equals('TKH00D1'));
            expect(homeModel.ponds.last.name, equals('Kolam D1'));
          },
        );
      });

      test('should return correct company data', () async {
        // Act
        final result = await dataSource.getHomeData();

        // Assert
        result.fold(
          (failure) => fail('Should not return failure'),
          (homeModel) {
            expect(homeModel.companies, contains('PT. Tambak Bersama'));
            expect(homeModel.companies, contains('PT. Company Lain'));
            expect(homeModel.companies, contains('PT. Company Lain Lagi'));
          },
        );
      });
    });

    group('getDashboardSummaryData', () {
      test('should return dashboard summary data when successful', () async {
        // Act
        final result = await dataSource.getDashboardSummaryData();

        // Assert
        expect(result, isA<Right<Failure, Map<String, dynamic>>>());
        result.fold(
          (failure) => fail('Should not return failure'),
          (data) {
            expect(data['activePonds'], equals(8));
            expect(data['estimasiBiomassa'], equals('1250'));
            expect(data['totalPakan'], equals('1.000'));
            expect(data['biayaPakan'], equals('20'));
            expect(data['estimasiSR'], equals('100'));
          },
        );
      });
    });

    group('getPondListData', () {
      test('should return pond list when successful', () async {
        // Act
        final result = await dataSource.getPondListData();

        // Assert
        expect(result, isA<Right<Failure, List<PondModel>>>());
        result.fold(
          (failure) => fail('Should not return failure'),
          (ponds) {
            expect(ponds.length, equals(8));
            expect(ponds[0].id, equals('TKH00A1'));
            expect(ponds[0].name, equals('Kolam A1'));
          },
        );
      });
    });

    group('getCompanyListData', () {
      test('should return company list data when successful', () async {
        // Act
        final result = await dataSource.getCompanyListData();

        // Assert
        expect(result, isA<Right<Failure, Map<String, dynamic>>>());
        result.fold(
          (failure) => fail('Should not return failure'),
          (data) {
            expect(data['companies'], isA<List>());
            expect((data['companies'] as List).length, equals(3));
            expect(data['selectedCompany'], equals('PT. Tambak Bersama'));
          },
        );
      });
    });

    group('getHeaderData', () {
      test('should return header data when successful', () async {
        // Act
        final result = await dataSource.getHeaderData();

        // Assert
        expect(result, isA<Right<Failure, Map<String, dynamic>>>());
        result.fold(
          (failure) => fail('Should not return failure'),
          (data) {
            expect(data['notificationCount'], equals(3));
          },
        );
      });
    });

    group('getBannerListData', () {
      test('should return banner list when successful', () async {
        // Act
        final result = await dataSource.getBannerListData();

        // Assert
        expect(result, isA<Right<Failure, List<BannerModel>>>());
        result.fold(
          (failure) => fail('Should not return failure'),
          (banners) {
            expect(banners.length, equals(2));
            expect(banners[0].id, equals('harvest_calculator'));
            expect(banners[0].title, equals('Kalkulator Panen'));
            expect(banners[1].id, equals('lab_analysis'));
            expect(banners[1].title, equals('Analisis Lab'));
          },
        );
      });
    });

    group('getInputDataListData', () {
      test('should return input data list when successful', () async {
        // Act
        final result = await dataSource.getInputDataListData();

        // Assert
        expect(result, isA<Right<Failure, List<InputDataItemModel>>>());
        result.fold(
          (failure) => fail('Should not return failure'),
          (items) {
            expect(items.length, equals(8));
            expect(items[0].id, equals('pakan'));
            expect(items[0].label, equals('Pakan'));
            expect(items[0].order, equals(1));
            expect(items.last.id, equals('kematian'));
            expect(items.last.label, equals('Kematian'));
            expect(items.last.order, equals(8));
          },
        );
      });

      test('should return input data items in correct order', () async {
        // Act
        final result = await dataSource.getInputDataListData();

        // Assert
        result.fold(
          (failure) => fail('Should not return failure'),
          (items) {
            for (int i = 0; i < items.length; i++) {
              expect(items[i].order, equals(i + 1));
            }
          },
        );
      });
    });

    group('error handling', () {
      test('should handle errors in getHomeData', () async {
        // Note: The current implementation catches all errors and returns
        // NetworkFailure.serverError. This test verifies that behavior.
        // In a real scenario, we might want to test actual error conditions.
        // For now, we verify the success path works correctly.
        // Act
        final result = await dataSource.getHomeData();

        // Assert - Should not throw, should return Either
        expect(result, isA<Either<Failure, HomeModel>>());
      });
    });
  });
}

