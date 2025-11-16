import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/home/data/datasources/remote/home_remote_datasource.dart';
import 'package:flutter_base_app/features/home/data/models/banner_model.dart';
import 'package:flutter_base_app/features/home/data/models/home_model.dart';
import 'package:flutter_base_app/features/home/data/models/input_data_item_model.dart';
import 'package:flutter_base_app/features/home/data/models/pond_model.dart';
import 'package:flutter_base_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_base_app/features/home/domain/entities/banner_list_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/company_list_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/header_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/home_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/input_data_list_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/pond_list_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRemoteDataSource extends Mock implements HomeRemoteDataSource {}

void main() {
  group('HomeRepositoryImpl', () {
    late HomeRepositoryImpl repository;
    late MockHomeRemoteDataSource mockRemoteDataSource;

    setUp(() {
      mockRemoteDataSource = MockHomeRemoteDataSource();
      repository = HomeRepositoryImpl(remoteDataSource: mockRemoteDataSource);
    });

    group('getHomeData', () {
      test('should return HomeData when remote data source succeeds', () async {
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

        when(
          () => mockRemoteDataSource.getHomeData(),
        ).thenAnswer((_) async => const Right(homeModel));

        // Act
        final result = await repository.getHomeData();

        // Assert
        expect(result, isA<Right<Failure, HomeData>>());
        result.fold((failure) => fail('Should not return failure'), (homeData) {
          expect(homeData.activePonds, equals(5));
          expect(homeData.estimasiBiomassa, equals('1000 kg'));
          expect(homeData.ponds.length, equals(2));
          expect(homeData.companies.length, equals(2));
          expect(homeData.selectedCompany, equals('Company A'));
        });
        verify(() => mockRemoteDataSource.getHomeData()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test('should return Failure when remote data source fails', () async {
        // Arrange
        const expectedFailure = NetworkFailure.serverError('Server Error');

        when(
          () => mockRemoteDataSource.getHomeData(),
        ).thenAnswer((_) async => const Left(expectedFailure));

        // Act
        final result = await repository.getHomeData();

        // Assert
        expect(result, const Left(expectedFailure));
        verify(() => mockRemoteDataSource.getHomeData()).called(1);
      });
    });

    group('getDashboardSummaryData', () {
      test(
        'should return DashboardSummaryData when remote data source succeeds',
        () async {
          // Arrange
          const mockData = {
            'activePonds': 5,
            'estimasiBiomassa': '1000 kg',
            'totalPakan': '500 kg',
            'biayaPakan': 'Rp 1.000.000',
            'estimasiSR': '80%',
          };

          when(
            () => mockRemoteDataSource.getDashboardSummaryData(),
          ).thenAnswer((_) async => const Right(mockData));

          // Act
          final result = await repository.getDashboardSummaryData();

          // Assert
          expect(result, isA<Right<Failure, DashboardSummaryData>>());
          result.fold((failure) => fail('Should not return failure'), (data) {
            expect(data.activePonds, equals(5));
            expect(data.estimasiBiomassa, equals('1000 kg'));
            expect(data.totalPakan, equals('500 kg'));
            expect(data.biayaPakan, equals('Rp 1.000.000'));
            expect(data.estimasiSR, equals('80%'));
          });
          verify(
            () => mockRemoteDataSource.getDashboardSummaryData(),
          ).called(1);
        },
      );

      test('should return Failure when remote data source fails', () async {
        // Arrange
        const expectedFailure = NetworkFailure.serverError('Server Error');

        when(
          () => mockRemoteDataSource.getDashboardSummaryData(),
        ).thenAnswer((_) async => const Left(expectedFailure));

        // Act
        final result = await repository.getDashboardSummaryData();

        // Assert
        expect(result, const Left(expectedFailure));
        verify(() => mockRemoteDataSource.getDashboardSummaryData()).called(1);
      });
    });

    group('getPondListData', () {
      test(
        'should return PondListData when remote data source succeeds',
        () async {
          // Arrange
          const pondModels = [
            PondModel(id: 'pond1', name: 'Pond 1'),
            PondModel(id: 'pond2', name: 'Pond 2'),
          ];

          when(
            () => mockRemoteDataSource.getPondListData(),
          ).thenAnswer((_) async => const Right(pondModels));

          // Act
          final result = await repository.getPondListData();

          // Assert
          expect(result, isA<Right<Failure, PondListData>>());
          result.fold((failure) => fail('Should not return failure'), (data) {
            expect(data.ponds.length, equals(2));
            expect(data.ponds[0].id, equals('pond1'));
            expect(data.ponds[0].name, equals('Pond 1'));
          });
          verify(() => mockRemoteDataSource.getPondListData()).called(1);
        },
      );

      test('should return Failure when remote data source fails', () async {
        // Arrange
        const expectedFailure = NetworkFailure.serverError('Server Error');

        when(
          () => mockRemoteDataSource.getPondListData(),
        ).thenAnswer((_) async => const Left(expectedFailure));

        // Act
        final result = await repository.getPondListData();

        // Assert
        expect(result, const Left(expectedFailure));
        verify(() => mockRemoteDataSource.getPondListData()).called(1);
      });
    });

    group('getCompanyListData', () {
      test(
        'should return CompanyListData when remote data source succeeds',
        () async {
          // Arrange
          const mockData = {
            'companies': ['Company A', 'Company B', 'Company C'],
            'selectedCompany': 'Company A',
          };

          when(
            () => mockRemoteDataSource.getCompanyListData(),
          ).thenAnswer((_) async => const Right(mockData));

          // Act
          final result = await repository.getCompanyListData();

          // Assert
          expect(result, isA<Right<Failure, CompanyListData>>());
          result.fold((failure) => fail('Should not return failure'), (data) {
            expect(data.companies.length, equals(3));
            expect(data.selectedCompany, equals('Company A'));
          });
          verify(() => mockRemoteDataSource.getCompanyListData()).called(1);
        },
      );

      test('should return Failure when remote data source fails', () async {
        // Arrange
        const expectedFailure = NetworkFailure.serverError('Server Error');

        when(
          () => mockRemoteDataSource.getCompanyListData(),
        ).thenAnswer((_) async => const Left(expectedFailure));

        // Act
        final result = await repository.getCompanyListData();

        // Assert
        expect(result, const Left(expectedFailure));
        verify(() => mockRemoteDataSource.getCompanyListData()).called(1);
      });

      test('should handle null selectedCompany', () async {
        // Arrange
        const mockData = {
          'companies': ['Company A', 'Company B'],
          'selectedCompany': null,
        };

        when(
          () => mockRemoteDataSource.getCompanyListData(),
        ).thenAnswer((_) async => const Right(mockData));

        // Act
        final result = await repository.getCompanyListData();

        // Assert
        result.fold((failure) => fail('Should not return failure'), (data) {
          expect(data.selectedCompany, isNull);
        });
      });
    });

    group('getHeaderData', () {
      test(
        'should return HeaderData when remote data source succeeds',
        () async {
          // Arrange
          const mockData = {'notificationCount': 5};

          when(
            () => mockRemoteDataSource.getHeaderData(),
          ).thenAnswer((_) async => const Right(mockData));

          // Act
          final result = await repository.getHeaderData();

          // Assert
          expect(result, isA<Right<Failure, HeaderData>>());
          result.fold((failure) => fail('Should not return failure'), (data) {
            expect(data.notificationCount, equals(5));
          });
          verify(() => mockRemoteDataSource.getHeaderData()).called(1);
        },
      );

      test('should return Failure when remote data source fails', () async {
        // Arrange
        const expectedFailure = NetworkFailure.serverError('Server Error');

        when(
          () => mockRemoteDataSource.getHeaderData(),
        ).thenAnswer((_) async => const Left(expectedFailure));

        // Act
        final result = await repository.getHeaderData();

        // Assert
        expect(result, const Left(expectedFailure));
        verify(() => mockRemoteDataSource.getHeaderData()).called(1);
      });
    });

    group('getBannerListData', () {
      test(
        'should return BannerListData when remote data source succeeds',
        () async {
          // Arrange
          const bannerModels = [
            BannerModel(
              id: 'banner1',
              title: 'Banner 1',
              description: 'Description 1',
              imagePath: '/path/to/image1',
              backgroundColor: '#FFFFFF',
            ),
          ];

          when(
            () => mockRemoteDataSource.getBannerListData(),
          ).thenAnswer((_) async => const Right(bannerModels));

          // Act
          final result = await repository.getBannerListData();

          // Assert
          expect(result, isA<Right<Failure, BannerListData>>());
          result.fold((failure) => fail('Should not return failure'), (data) {
            expect(data.banners.length, equals(1));
            expect(data.banners[0].id, equals('banner1'));
          });
          verify(() => mockRemoteDataSource.getBannerListData()).called(1);
        },
      );

      test('should return Failure when remote data source fails', () async {
        // Arrange
        const expectedFailure = NetworkFailure.serverError('Server Error');

        when(
          () => mockRemoteDataSource.getBannerListData(),
        ).thenAnswer((_) async => const Left(expectedFailure));

        // Act
        final result = await repository.getBannerListData();

        // Assert
        expect(result, const Left(expectedFailure));
        verify(() => mockRemoteDataSource.getBannerListData()).called(1);
      });
    });

    group('getInputDataListData', () {
      test(
        'should return InputDataListData sorted by order when remote data source succeeds',
        () async {
          // Arrange
          final inputDataModels = [
            const InputDataItemModel(
              id: 'item2',
              label: 'Item 2',
              iconPath: '/path/to/icon2',
              backgroundColor: '#000000',
              iconColor: '#FFFFFF',
              order: 2,
            ),
            const InputDataItemModel(
              id: 'item1',
              label: 'Item 1',
              iconPath: '/path/to/icon1',
              backgroundColor: '#FFFFFF',
              iconColor: '#000000',
              order: 1,
            ),
          ];

          when(
            () => mockRemoteDataSource.getInputDataListData(),
          ).thenAnswer((_) async => Right(inputDataModels));

          // Act
          final result = await repository.getInputDataListData();

          // Assert
          expect(result, isA<Right<Failure, InputDataListData>>());
          result.fold((failure) => fail('Should not return failure'), (data) {
            expect(data.items.length, equals(2));
            // Should be sorted by order
            expect(data.items[0].id, equals('item1'));
            expect(data.items[0].order, equals(1));
            expect(data.items[1].id, equals('item2'));
            expect(data.items[1].order, equals(2));
          });
          verify(() => mockRemoteDataSource.getInputDataListData()).called(1);
        },
      );

      test('should return Failure when remote data source fails', () async {
        // Arrange
        const expectedFailure = NetworkFailure.serverError('Server Error');

        when(
          () => mockRemoteDataSource.getInputDataListData(),
        ).thenAnswer((_) async => const Left(expectedFailure));

        // Act
        final result = await repository.getInputDataListData();

        // Assert
        expect(result, const Left(expectedFailure));
        verify(() => mockRemoteDataSource.getInputDataListData()).called(1);
      });
    });

    group('updateSelectedCompany', () {
      test(
        'should return CompanyListData with updated selectedCompany when successful',
        () async {
          // Arrange
          const company = 'Company B';
          const currentCompanyListData = {
            'companies': ['Company A', 'Company B', 'Company C'],
            'selectedCompany': 'Company A',
          };

          when(
            () => mockRemoteDataSource.getCompanyListData(),
          ).thenAnswer((_) async => const Right(currentCompanyListData));

          // Act
          final result = await repository.updateSelectedCompany(company);

          // Assert
          expect(result, isA<Right<Failure, CompanyListData>>());
          result.fold((failure) => fail('Should not return failure'), (data) {
            expect(data.companies.length, equals(3));
            expect(data.selectedCompany, equals('Company B'));
          });
          verify(() => mockRemoteDataSource.getCompanyListData()).called(1);
        },
      );

      test('should return Failure when getCompanyListData fails', () async {
        // Arrange
        const company = 'Company B';
        const expectedFailure = NetworkFailure.serverError('Server Error');

        when(
          () => mockRemoteDataSource.getCompanyListData(),
        ).thenAnswer((_) async => const Left(expectedFailure));

        // Act
        final result = await repository.updateSelectedCompany(company);

        // Assert
        expect(result, const Left(expectedFailure));
        verify(() => mockRemoteDataSource.getCompanyListData()).called(1);
      });
    });
  });
}
