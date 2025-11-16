import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/home/domain/entities/banner_entity.dart';
import 'package:flutter_base_app/features/home/domain/entities/banner_list_data.dart';
import 'package:flutter_base_app/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_base_app/features/home/domain/usecases/get_banner_list_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  group('GetBannerListData', () {
    late GetBannerListData useCase;
    late MockHomeRepository mockRepository;

    setUp(() {
      mockRepository = MockHomeRepository();
      useCase = GetBannerListData(mockRepository);
    });

    test(
      'should return BannerListData when repository call is successful',
      () async {
        // Arrange
        const expectedBannerListData = BannerListData(
          banners: [
            BannerEntity(
              id: 'banner1',
              title: 'Banner 1',
              description: 'Description 1',
              imagePath: '/path/to/image1',
              backgroundColor: '#FFFFFF',
            ),
            BannerEntity(
              id: 'banner2',
              title: 'Banner 2',
              description: 'Description 2',
              imagePath: '/path/to/image2',
              backgroundColor: '#000000',
            ),
          ],
        );

        when(
          () => mockRepository.getBannerListData(),
        ).thenAnswer((_) async => const Right(expectedBannerListData));

        // Act
        final result = await useCase();

        // Assert
        expect(result, const Right(expectedBannerListData));
        expect(result.fold((l) => null, (r) => r.banners.length), equals(2));
        verify(() => mockRepository.getBannerListData()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should return Failure when repository call fails', () async {
      // Arrange
      const expectedFailure = NetworkFailure.serverError('Server Error');

      when(
        () => mockRepository.getBannerListData(),
      ).thenAnswer((_) async => const Left(expectedFailure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Left(expectedFailure));
      verify(() => mockRepository.getBannerListData()).called(1);
    });

    test('should handle empty banner list', () async {
      // Arrange
      const expectedBannerListData = BannerListData(banners: []);

      when(
        () => mockRepository.getBannerListData(),
      ).thenAnswer((_) async => const Right(expectedBannerListData));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Right(expectedBannerListData));
      expect(result.fold((l) => null, (r) => r.banners.length), equals(0));
    });
  });
}
