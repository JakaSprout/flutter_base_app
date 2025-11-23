import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/domain/entities/pond_entity.dart';
import 'package:app_mobile_afms/features/home/domain/entities/pond_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/repositories/home_repository.dart';
import 'package:app_mobile_afms/features/home/domain/usecases/get_pond_list_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  group('GetPondListData', () {
    late GetPondListData useCase;
    late MockHomeRepository mockRepository;

    setUp(() {
      mockRepository = MockHomeRepository();
      useCase = GetPondListData(mockRepository);
    });

    test(
      'should return PondListData when repository call is successful',
      () async {
        // Arrange
        const expectedPondListData = PondListData(
          ponds: [
            PondEntity(id: 'pond1', name: 'Pond 1'),
            PondEntity(id: 'pond2', name: 'Pond 2'),
            PondEntity(id: 'pond3', name: 'Pond 3'),
          ],
        );

        when(
          () => mockRepository.getPondListData(),
        ).thenAnswer((_) async => const Right(expectedPondListData));

        // Act
        final result = await useCase();

        // Assert
        expect(result, const Right(expectedPondListData));
        expect(result.fold((l) => null, (r) => r.ponds.length), equals(3));
        verify(() => mockRepository.getPondListData()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should return Failure when repository call fails', () async {
      // Arrange
      const expectedFailure = NetworkFailure.serverError('Server Error');

      when(
        () => mockRepository.getPondListData(),
      ).thenAnswer((_) async => const Left(expectedFailure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Left(expectedFailure));
      verify(() => mockRepository.getPondListData()).called(1);
    });

    test('should handle empty pond list', () async {
      // Arrange
      const expectedPondListData = PondListData(ponds: []);

      when(
        () => mockRepository.getPondListData(),
      ).thenAnswer((_) async => const Right(expectedPondListData));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Right(expectedPondListData));
      expect(result.fold((l) => null, (r) => r.ponds.length), equals(0));
    });
  });
}
