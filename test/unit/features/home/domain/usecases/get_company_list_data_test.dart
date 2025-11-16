import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/home/domain/entities/company_list_data.dart';
import 'package:flutter_base_app/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_base_app/features/home/domain/usecases/get_company_list_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  group('GetCompanyListData', () {
    late GetCompanyListData useCase;
    late MockHomeRepository mockRepository;

    setUp(() {
      mockRepository = MockHomeRepository();
      useCase = GetCompanyListData(mockRepository);
    });

    test(
      'should return CompanyListData when repository call is successful',
      () async {
        // Arrange
        const expectedCompanyListData = CompanyListData(
          companies: ['Company A', 'Company B', 'Company C'],
          selectedCompany: 'Company A',
        );

        when(
          () => mockRepository.getCompanyListData(),
        ).thenAnswer((_) async => const Right(expectedCompanyListData));

        // Act
        final result = await useCase();

        // Assert
        expect(result, const Right(expectedCompanyListData));
        expect(result.fold((l) => null, (r) => r.companies.length), equals(3));
        expect(
          result.fold((l) => null, (r) => r.selectedCompany),
          equals('Company A'),
        );
        verify(() => mockRepository.getCompanyListData()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should return Failure when repository call fails', () async {
      // Arrange
      const expectedFailure = NetworkFailure.serverError('Server Error');

      when(
        () => mockRepository.getCompanyListData(),
      ).thenAnswer((_) async => const Left(expectedFailure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Left(expectedFailure));
      verify(() => mockRepository.getCompanyListData()).called(1);
    });

    test('should handle null selectedCompany', () async {
      // Arrange
      const expectedCompanyListData = CompanyListData(
        companies: ['Company A', 'Company B'],
      );

      when(
        () => mockRepository.getCompanyListData(),
      ).thenAnswer((_) async => const Right(expectedCompanyListData));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Right(expectedCompanyListData));
      expect(result.fold((l) => null, (r) => r.selectedCompany), isNull);
    });
  });
}
