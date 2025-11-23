import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/domain/entities/header_data.dart';
import 'package:app_mobile_afms/features/home/domain/repositories/home_repository.dart';
import 'package:app_mobile_afms/features/home/domain/usecases/get_header_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  group('GetHeaderData', () {
    late GetHeaderData useCase;
    late MockHomeRepository mockRepository;

    setUp(() {
      mockRepository = MockHomeRepository();
      useCase = GetHeaderData(mockRepository);
    });

    test(
      'should return HeaderData when repository call is successful',
      () async {
        // Arrange
        const expectedHeaderData = HeaderData(notificationCount: 5);

        when(
          () => mockRepository.getHeaderData(),
        ).thenAnswer((_) async => const Right(expectedHeaderData));

        // Act
        final result = await useCase();

        // Assert
        expect(result, const Right(expectedHeaderData));
        expect(result.fold((l) => null, (r) => r.notificationCount), equals(5));
        verify(() => mockRepository.getHeaderData()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should return Failure when repository call fails', () async {
      // Arrange
      const expectedFailure = NetworkFailure.serverError('Server Error');

      when(
        () => mockRepository.getHeaderData(),
      ).thenAnswer((_) async => const Left(expectedFailure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Left(expectedFailure));
      verify(() => mockRepository.getHeaderData()).called(1);
    });

    test('should handle zero notification count', () async {
      // Arrange
      const expectedHeaderData = HeaderData(notificationCount: 0);

      when(
        () => mockRepository.getHeaderData(),
      ).thenAnswer((_) async => const Right(expectedHeaderData));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Right(expectedHeaderData));
      expect(result.fold((l) => null, (r) => r.notificationCount), equals(0));
    });
  });
}
