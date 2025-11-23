import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/domain/entities/company_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/repositories/home_repository.dart';
import 'package:app_mobile_afms/features/home/domain/usecases/update_selected_company.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  group('UpdateSelectedCompany', () {
    late UpdateSelectedCompany useCase;
    late MockHomeRepository mockRepository;

    setUp(() {
      mockRepository = MockHomeRepository();
      useCase = UpdateSelectedCompany(mockRepository);
    });

    test(
      'should return CompanyListData with updated selectedCompany when repository call is successful',
      () async {
        // Arrange
        const company = 'Company B';
        const expectedCompanyListData = CompanyListData(
          companies: ['Company A', 'Company B', 'Company C'],
          selectedCompany: 'Company B',
        );

        when(
          () => mockRepository.updateSelectedCompany(any()),
        ).thenAnswer((_) async => const Right(expectedCompanyListData));

        // Act
        final result = await useCase(company);

        // Assert
        expect(result, const Right(expectedCompanyListData));
        expect(
          result.fold((l) => null, (r) => r.selectedCompany),
          equals('Company B'),
        );
        verify(() => mockRepository.updateSelectedCompany(company)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should return Failure when repository call fails', () async {
      // Arrange
      const company = 'Company B';
      const expectedFailure = NetworkFailure.serverError('Server Error');

      when(
        () => mockRepository.updateSelectedCompany(any()),
      ).thenAnswer((_) async => const Left(expectedFailure));

      // Act
      final result = await useCase(company);

      // Assert
      expect(result, const Left(expectedFailure));
      verify(() => mockRepository.updateSelectedCompany(company)).called(1);
    });

    test('should handle different company names', () async {
      // Arrange
      const company1 = 'Company A';
      const company2 = 'Company C';
      const expectedCompanyListData1 = CompanyListData(
        companies: ['Company A', 'Company B', 'Company C'],
        selectedCompany: 'Company A',
      );
      const expectedCompanyListData2 = CompanyListData(
        companies: ['Company A', 'Company B', 'Company C'],
        selectedCompany: 'Company C',
      );

      when(
        () => mockRepository.updateSelectedCompany(company1),
      ).thenAnswer((_) async => const Right(expectedCompanyListData1));
      when(
        () => mockRepository.updateSelectedCompany(company2),
      ).thenAnswer((_) async => const Right(expectedCompanyListData2));

      // Act
      final result1 = await useCase(company1);
      final result2 = await useCase(company2);

      // Assert
      expect(result1, const Right(expectedCompanyListData1));
      expect(result2, const Right(expectedCompanyListData2));
      expect(
        result1.fold((l) => null, (r) => r.selectedCompany),
        equals('Company A'),
      );
      expect(
        result2.fold((l) => null, (r) => r.selectedCompany),
        equals('Company C'),
      );
    });
  });
}
