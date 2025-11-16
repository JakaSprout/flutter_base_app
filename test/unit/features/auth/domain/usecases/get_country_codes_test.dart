import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/auth/domain/entities/country_code.dart';
import 'package:flutter_base_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_base_app/features/auth/domain/usecases/get_country_codes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('GetCountryCodes', () {
    late GetCountryCodes useCase;
    late MockAuthRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthRepository();
      useCase = GetCountryCodes(mockRepository);
    });

    test(
      'should return list of CountryCode when repository call is successful',
      () async {
        // Arrange
        final expectedCountryCodes = [
          const CountryCode(
            code: 'ID',
            dialCode: '+62',
            name: 'Indonesia',
            flag: '🇮🇩',
          ),
          const CountryCode(
            code: 'MY',
            dialCode: '+60',
            name: 'Malaysia',
            flag: '🇲🇾',
          ),
          const CountryCode(
            code: 'SG',
            dialCode: '+65',
            name: 'Singapore',
            flag: '🇸🇬',
          ),
        ];

        when(
          () => mockRepository.getCountryCodes(),
        ).thenAnswer((_) async => Right(expectedCountryCodes));

        // Act
        final result = await useCase();

        // Assert
        expect(result, isA<Right<Failure, List<CountryCode>>>());
        result.fold((failure) => fail('Should not return failure'), (
          countryCodes,
        ) {
          expect(countryCodes.length, equals(3));
          expect(countryCodes[0].code, equals('ID'));
          expect(countryCodes[0].dialCode, equals('+62'));
          expect(countryCodes[0].name, equals('Indonesia'));
          expect(countryCodes[1].code, equals('MY'));
          expect(countryCodes[2].code, equals('SG'));
        });
        verify(() => mockRepository.getCountryCodes()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should return Failure when repository call fails', () async {
      // Arrange
      const failure = NetworkFailure(
        message: 'Failed to fetch country codes',
        code: 'NETWORK_ERROR',
      );

      when(
        () => mockRepository.getCountryCodes(),
      ).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Left<Failure, List<CountryCode>>>());
      result.fold((error) {
        expect(error, equals(failure));
        expect(error, isA<NetworkFailure>());
      }, (countryCodes) => fail('Should not return country codes'));
      verify(() => mockRepository.getCountryCodes()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return empty list when no country codes available', () async {
      // Arrange
      const expectedCountryCodes = <CountryCode>[];

      when(
        () => mockRepository.getCountryCodes(),
      ).thenAnswer((_) async => const Right(expectedCountryCodes));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Right<Failure, List<CountryCode>>>());
      result.fold((failure) => fail('Should not return failure'), (
        countryCodes,
      ) {
        expect(countryCodes, isEmpty);
      });
      verify(() => mockRepository.getCountryCodes()).called(1);
    });

    test('should handle server error', () async {
      // Arrange
      const failure = NetworkFailure.serverError('Server error occurred');

      when(
        () => mockRepository.getCountryCodes(),
      ).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Left<Failure, List<CountryCode>>>());
      result.fold((error) {
        expect(error, isA<NetworkFailure>());
        expect((error as NetworkFailure).code, equals('SERVER_ERROR'));
      }, (countryCodes) => fail('Should not return country codes'));
      verify(() => mockRepository.getCountryCodes()).called(1);
    });
  });
}
