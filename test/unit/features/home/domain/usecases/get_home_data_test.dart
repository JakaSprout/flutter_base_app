import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/domain/entities/home_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/pond_entity.dart';
import 'package:app_mobile_afms/features/home/domain/repositories/home_repository.dart';
import 'package:app_mobile_afms/features/home/domain/usecases/get_home_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  group('GetHomeData', () {
    late GetHomeData useCase;
    late MockHomeRepository mockRepository;

    setUp(() {
      mockRepository = MockHomeRepository();
      useCase = GetHomeData(mockRepository);
    });

    test('should return HomeData when repository call is successful', () async {
      // Arrange
      const expectedHomeData = HomeData(
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

      when(
        () => mockRepository.getHomeData(),
      ).thenAnswer((_) async => const Right(expectedHomeData));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Right(expectedHomeData));
      verify(() => mockRepository.getHomeData()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Failure when repository call fails', () async {
      // Arrange
      const expectedFailure = NetworkFailure.serverError('Server Error');

      when(
        () => mockRepository.getHomeData(),
      ).thenAnswer((_) async => const Left(expectedFailure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Left(expectedFailure));
      verify(() => mockRepository.getHomeData()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return NetworkFailure when network error occurs', () async {
      // Arrange
      const expectedFailure = NetworkFailure.noConnection();

      when(
        () => mockRepository.getHomeData(),
      ).thenAnswer((_) async => const Left(expectedFailure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Left(expectedFailure));
      verify(() => mockRepository.getHomeData()).called(1);
    });
  });
}
