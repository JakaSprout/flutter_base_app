import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_base_app/features/auth/domain/usecases/logout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('Logout', () {
    late Logout useCase;
    late MockAuthRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthRepository();
      useCase = Logout(mockRepository);
    });

    test('should return void when repository logout is successful', () async {
      // Arrange
      when(
        () => mockRepository.logout(),
      ).thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Right<Failure, void>>());
      result.fold((failure) => fail('Should not return failure'), (_) {
        // Success - void return
      });
      verify(() => mockRepository.logout()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Failure when repository logout fails', () async {
      // Arrange
      const failure = NetworkFailure(
        message: 'Network error',
        code: 'NETWORK_ERROR',
      );

      when(
        () => mockRepository.logout(),
      ).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Left<Failure, void>>());
      result.fold((error) {
        expect(error, equals(failure));
        expect(error, isA<NetworkFailure>());
      }, (_) => fail('Should not return success'));
      verify(() => mockRepository.logout()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test(
      'should return AuthFailure when logout fails due to auth error',
      () async {
        // Arrange
        const failure = AuthFailure(
          message: 'Unauthorized',
          code: 'UNAUTHORIZED',
        );

        when(
          () => mockRepository.logout(),
        ).thenAnswer((_) async => const Left(failure));

        // Act
        final result = await useCase();

        // Assert
        expect(result, isA<Left<Failure, void>>());
        result.fold((error) {
          expect(error, equals(failure));
          expect(error, isA<AuthFailure>());
        }, (_) => fail('Should not return success'));
        verify(() => mockRepository.logout()).called(1);
      },
    );

    test(
      'should return NetworkFailure when logout fails due to server error',
      () async {
        // Arrange
        const failure = NetworkFailure.serverError('Internal server error');

        when(
          () => mockRepository.logout(),
        ).thenAnswer((_) async => const Left(failure));

        // Act
        final result = await useCase();

        // Assert
        expect(result, isA<Left<Failure, void>>());
        result.fold((error) {
          expect(error, equals(failure));
          expect(error, isA<NetworkFailure>());
        }, (_) => fail('Should not return success'));
        verify(() => mockRepository.logout()).called(1);
      },
    );
  });
}
