import 'dart:async';

import 'package:app_mobile_afms/core/connectivity/connectivity_models.dart';
import 'package:app_mobile_afms/core/connectivity/connectivity_service.dart';
import 'package:app_mobile_afms/core/di/providers/connectivity_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_helpers.dart';

class MockConnectivityService extends Mock implements ConnectivityService {}

void main() {
  group('ConnectivityProvider', () {
    late ProviderContainer container;
    late MockConnectivityService mockService;

    setUp(() {
      mockService = MockConnectivityService();
      container = TestHelpers.createContainer(
        overrides: [connectivityServiceProvider.overrideWithValue(mockService)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('connectivityServiceProvider', () {
      test('should return ConnectivityService instance', () {
        // Act
        final service = container.read(connectivityServiceProvider);

        // Assert
        expect(service, isA<ConnectivityService>());
      });
    });

    group('connectivityStatusProvider', () {
      test('should return AsyncValue from stream', () {
        // Arrange
        final testStream = Stream.value(
          const AppConnectivityResult(
            status: ConnectivityStatus.connected,
            type: 'wifi',
          ),
        );
        when(() => mockService.onStatusChanged).thenAnswer((_) => testStream);

        // Act
        final asyncStatus = container.read(connectivityStatusProvider);

        // Assert
        expect(asyncStatus, isA<AsyncValue<AppConnectivityResult>>());
        verify(() => mockService.onStatusChanged).called(1);
      });
    });

    group('connectivityStatusSyncProvider', () {
      test('should return null when status stream has no value', () {
        // Arrange
        const testStream = Stream<AppConnectivityResult>.empty();
        when(() => mockService.onStatusChanged).thenAnswer((_) => testStream);

        // Act
        final status = container.read(connectivityStatusSyncProvider);

        // Assert
        expect(status, isNull);
      });

      test('should return status when stream has value', () async {
        // Arrange
        const testResult = AppConnectivityResult(
          status: ConnectivityStatus.connected,
          type: 'wifi',
        );
        // Use StreamController to allow multiple listens
        final streamController = StreamController<AppConnectivityResult>();
        when(
          () => mockService.onStatusChanged,
        ).thenAnswer((_) => streamController.stream);

        // Act
        // Set up listener BEFORE reading provider (per best practice)
        final completer = Completer<AppConnectivityResult?>();
        final subscription = container.listen(connectivityStatusSyncProvider, (
          previous,
          next,
        ) {
          if (next != null && !completer.isCompleted) {
            completer.complete(next);
          }
        });

        // Trigger provider read to start stream subscription
        container.read(connectivityStatusProvider);

        // Emit value to stream
        streamController.add(testResult);

        // Wait for provider to update
        final status = await completer.future.timeout(
          const Duration(seconds: 2),
          onTimeout: () => container.read(connectivityStatusSyncProvider),
        );

        // Cleanup
        subscription.close();
        await streamController.close();

        // Assert
        expect(status, isNotNull);
        expect(status?.status, equals(ConnectivityStatus.connected));
        expect(status?.type, equals('wifi'));
      });
    });

    group('isConnectedProvider', () {
      test('should return false when status is null', () {
        // Arrange
        const testStream = Stream<AppConnectivityResult>.empty();
        when(() => mockService.onStatusChanged).thenAnswer((_) => testStream);

        // Act
        final isConnected = container.read(isConnectedProvider);

        // Assert
        expect(isConnected, isFalse);
      });

      test('should return true when status is connected', () async {
        // Arrange
        const testResult = AppConnectivityResult(
          status: ConnectivityStatus.connected,
        );
        // Use StreamController to allow multiple listens
        final streamController = StreamController<AppConnectivityResult>();
        when(
          () => mockService.onStatusChanged,
        ).thenAnswer((_) => streamController.stream);

        // Act
        // Set up listener BEFORE reading provider (per best practice)
        final completer = Completer<bool>();
        final subscription = container.listen(isConnectedProvider, (
          previous,
          next,
        ) {
          if (next == true && !completer.isCompleted) {
            completer.complete(next);
          }
        });

        // Trigger provider read to start stream subscription
        container.read(connectivityStatusProvider);

        // Emit value to stream
        streamController.add(testResult);

        // Wait for provider to update
        final isConnected = await completer.future.timeout(
          const Duration(seconds: 2),
          onTimeout: () => container.read(isConnectedProvider),
        );

        // Cleanup
        subscription.close();
        await streamController.close();

        // Assert
        expect(isConnected, isTrue);
      });

      test('should return false when status is disconnected', () async {
        // Arrange
        const testResult = AppConnectivityResult(
          status: ConnectivityStatus.disconnected,
        );
        // Use StreamController to allow multiple listens
        final streamController = StreamController<AppConnectivityResult>();
        when(
          () => mockService.onStatusChanged,
        ).thenAnswer((_) => streamController.stream);

        // Act
        // Set up listener BEFORE reading provider (per best practice)
        final completer = Completer<bool>();
        final subscription = container.listen(isConnectedProvider, (
          previous,
          next,
        ) {
          if (next == false && !completer.isCompleted) {
            completer.complete(next);
          }
        });

        // Trigger provider read to start stream subscription
        container.read(connectivityStatusProvider);

        // Emit value to stream
        streamController.add(testResult);

        // Wait for provider to update
        final isConnected = await completer.future.timeout(
          const Duration(seconds: 2),
          onTimeout: () => container.read(isConnectedProvider),
        );

        // Cleanup
        subscription.close();
        await streamController.close();

        // Assert
        expect(isConnected, isFalse);
      });

      test('should return false when status is unknown', () async {
        // Arrange
        const testResult = AppConnectivityResult(
          status: ConnectivityStatus.unknown,
        );
        // Use StreamController to allow multiple listens
        final streamController = StreamController<AppConnectivityResult>();
        when(
          () => mockService.onStatusChanged,
        ).thenAnswer((_) => streamController.stream);

        // Act
        // Set up listener BEFORE reading provider (per best practice)
        final completer = Completer<bool>();
        final subscription = container.listen(isConnectedProvider, (
          previous,
          next,
        ) {
          if (next == false && !completer.isCompleted) {
            completer.complete(next);
          }
        });

        // Trigger provider read to start stream subscription
        container.read(connectivityStatusProvider);

        // Emit value to stream
        streamController.add(testResult);

        // Wait for provider to update
        final isConnected = await completer.future.timeout(
          const Duration(seconds: 2),
          onTimeout: () => container.read(isConnectedProvider),
        );

        // Cleanup
        subscription.close();
        await streamController.close();

        // Assert
        expect(isConnected, isFalse);
      });
    });
  });
}
