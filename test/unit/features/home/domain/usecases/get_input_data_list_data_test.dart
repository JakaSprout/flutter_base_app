import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/home/domain/entities/input_data_item_entity.dart';
import 'package:flutter_base_app/features/home/domain/entities/input_data_list_data.dart';
import 'package:flutter_base_app/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_base_app/features/home/domain/usecases/get_input_data_list_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  group('GetInputDataListData', () {
    late GetInputDataListData useCase;
    late MockHomeRepository mockRepository;

    setUp(() {
      mockRepository = MockHomeRepository();
      useCase = GetInputDataListData(mockRepository);
    });

    test(
      'should return InputDataListData when repository call is successful',
      () async {
        // Arrange
        const expectedInputDataListData = InputDataListData(
          items: [
            InputDataItemEntity(
              id: 'item1',
              label: 'Item 1',
              iconPath: '/path/to/icon1',
              backgroundColor: '#FFFFFF',
              iconColor: '#000000',
              order: 1,
            ),
            InputDataItemEntity(
              id: 'item2',
              label: 'Item 2',
              iconPath: '/path/to/icon2',
              backgroundColor: '#000000',
              iconColor: '#FFFFFF',
              order: 2,
            ),
          ],
        );

        when(
          () => mockRepository.getInputDataListData(),
        ).thenAnswer((_) async => const Right(expectedInputDataListData));

        // Act
        final result = await useCase();

        // Assert
        expect(result, const Right(expectedInputDataListData));
        expect(result.fold((l) => null, (r) => r.items.length), equals(2));
        verify(() => mockRepository.getInputDataListData()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should return Failure when repository call fails', () async {
      // Arrange
      const expectedFailure = NetworkFailure.serverError('Server Error');

      when(
        () => mockRepository.getInputDataListData(),
      ).thenAnswer((_) async => const Left(expectedFailure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Left(expectedFailure));
      verify(() => mockRepository.getInputDataListData()).called(1);
    });

    test('should handle empty input data list', () async {
      // Arrange
      const expectedInputDataListData = InputDataListData(items: []);

      when(
        () => mockRepository.getInputDataListData(),
      ).thenAnswer((_) async => const Right(expectedInputDataListData));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Right(expectedInputDataListData));
      expect(result.fold((l) => null, (r) => r.items.length), equals(0));
    });
  });
}
