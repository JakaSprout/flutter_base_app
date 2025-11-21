import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:app_mobile_afms/features/home/domain/repositories/home_repository.dart';
import 'package:app_mobile_afms/features/home/domain/usecases/get_dashboard_summary_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  group('GetDashboardSummaryData', () {
    late GetDashboardSummaryData useCase;
    late MockHomeRepository mockRepository;

    setUp(() {
      mockRepository = MockHomeRepository();
      useCase = GetDashboardSummaryData(mockRepository);
    });

    test(
      'should return DashboardSummaryData when repository call is successful',
      () async {
        // Arrange
        const expectedDashboardSummaryData = DashboardSummaryData(
          activePonds: 5,
          estimasiBiomassa: '1000 kg',
          totalPakan: '500 kg',
          biayaPakan: 'Rp 1.000.000',
          estimasiSR: '80%',
        );

        when(
          () => mockRepository.getDashboardSummaryData(),
        ).thenAnswer((_) async => const Right(expectedDashboardSummaryData));

        // Act
        final result = await useCase();

        // Assert
        expect(result, const Right(expectedDashboardSummaryData));
        expect(result.fold((l) => null, (r) => r.activePonds), equals(5));
        verify(() => mockRepository.getDashboardSummaryData()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should return Failure when repository call fails', () async {
      // Arrange
      const expectedFailure = NetworkFailure.serverError('Server Error');

      when(
        () => mockRepository.getDashboardSummaryData(),
      ).thenAnswer((_) async => const Left(expectedFailure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Left(expectedFailure));
      verify(() => mockRepository.getDashboardSummaryData()).called(1);
    });

    test('should handle zero active ponds', () async {
      // Arrange
      const expectedDashboardSummaryData = DashboardSummaryData(
        activePonds: 0,
        estimasiBiomassa: '0 kg',
        totalPakan: '0 kg',
        biayaPakan: 'Rp 0',
        estimasiSR: '0%',
      );

      when(
        () => mockRepository.getDashboardSummaryData(),
      ).thenAnswer((_) async => const Right(expectedDashboardSummaryData));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Right(expectedDashboardSummaryData));
      expect(result.fold((l) => null, (r) => r.activePonds), equals(0));
    });
  });
}
