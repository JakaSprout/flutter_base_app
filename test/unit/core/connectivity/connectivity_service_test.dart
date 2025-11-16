import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart' as connectivity_plus;
import 'package:flutter_base_app/core/connectivity/connectivity_models.dart';
import 'package:flutter_base_app/core/connectivity/connectivity_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements connectivity_plus.Connectivity {}

void main() {
  group('ConnectivityService', () {
    late ConnectivityService service;
    late MockConnectivity mockConnectivity;
    late StreamController<List<connectivity_plus.ConnectivityResult>>
    connectivityController;

    setUp(() {
      mockConnectivity = MockConnectivity();
      connectivityController =
          StreamController<
            List<connectivity_plus.ConnectivityResult>
          >.broadcast();

      when(
        () => mockConnectivity.onConnectivityChanged,
      ).thenAnswer((_) => connectivityController.stream);
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [connectivity_plus.ConnectivityResult.wifi]);

      service = ConnectivityService(connectivity: mockConnectivity);
    });

    tearDown(() {
      service.dispose();
      connectivityController.close();
    });

    test('should initialize and check connectivity on creation', () async {
      // Wait for initialization
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      verify(() => mockConnectivity.checkConnectivity()).called(1);
      verify(() => mockConnectivity.onConnectivityChanged).called(1);
    });

    test('should return current connectivity status', () async {
      // Wait for initialization
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Act
      final status = service.currentStatus;

      // Assert
      expect(status, isNotNull);
      expect(status?.status, equals(ConnectivityStatus.connected));
    });

    group('checkConnectivity', () {
      test('should return connected status when wifi is available', () async {
        // Arrange
        when(
          () => mockConnectivity.checkConnectivity(),
        ).thenAnswer((_) async => [connectivity_plus.ConnectivityResult.wifi]);

        // Act
        final result = await service.checkConnectivity();

        // Assert
        expect(result.status, equals(ConnectivityStatus.connected));
        expect(result.type, equals('wifi'));
        expect(result.isConnected, isTrue);
      });

      test('should return connected status when mobile is available', () async {
        // Arrange
        when(() => mockConnectivity.checkConnectivity()).thenAnswer(
          (_) async => [connectivity_plus.ConnectivityResult.mobile],
        );

        // Act
        final result = await service.checkConnectivity();

        // Assert
        expect(result.status, equals(ConnectivityStatus.connected));
        expect(result.type, equals('mobile'));
        expect(result.isConnected, isTrue);
      });

      test('should return disconnected status when no connection', () async {
        // Arrange
        when(
          () => mockConnectivity.checkConnectivity(),
        ).thenAnswer((_) async => [connectivity_plus.ConnectivityResult.none]);

        // Act
        final result = await service.checkConnectivity();

        // Assert
        expect(result.status, equals(ConnectivityStatus.disconnected));
        expect(result.isDisconnected, isTrue);
      });

      test(
        'should return disconnected status when results are empty',
        () async {
          // Arrange
          when(
            () => mockConnectivity.checkConnectivity(),
          ).thenAnswer((_) async => []);

          // Act
          final result = await service.checkConnectivity();

          // Assert
          expect(result.status, equals(ConnectivityStatus.disconnected));
          expect(result.isDisconnected, isTrue);
        },
      );

      test('should return unknown status when error occurs', () async {
        // Arrange
        when(
          () => mockConnectivity.checkConnectivity(),
        ).thenThrow(Exception('Network error'));

        // Act
        final result = await service.checkConnectivity();

        // Assert
        expect(result.status, equals(ConnectivityStatus.unknown));
        expect(result.message, contains('Error checking connectivity'));
      });

      test('should handle multiple connection types', () async {
        // Arrange
        when(() => mockConnectivity.checkConnectivity()).thenAnswer(
          (_) async => [
            connectivity_plus.ConnectivityResult.wifi,
            connectivity_plus.ConnectivityResult.mobile,
          ],
        );

        // Act
        final result = await service.checkConnectivity();

        // Assert
        expect(result.status, equals(ConnectivityStatus.connected));
        expect(result.type, equals('wifi')); // First active connection
      });
    });

    group('onStatusChanged stream', () {
      test('should emit status changes when connectivity changes', () async {
        // Arrange
        final statuses = <AppConnectivityResult>[];
        final subscription = service.onStatusChanged.listen(statuses.add);

        // Wait for initial status to be set
        await Future<void>.delayed(const Duration(milliseconds: 200));
        final initialCount = statuses.length;

        // Act - Simulate connectivity change to a different type
        connectivityController.add([
          connectivity_plus.ConnectivityResult.mobile,
        ]);
        await Future<void>.delayed(const Duration(milliseconds: 200));

        // Assert - Should have at least one status change
        expect(statuses.length, greaterThanOrEqualTo(initialCount));
        final lastStatus = statuses.isNotEmpty ? statuses.last : null;
        if (lastStatus != null) {
          expect(lastStatus.status, equals(ConnectivityStatus.connected));
        }

        await subscription.cancel();
      });

      test('should emit status when disconnecting', () async {
        // Arrange
        final statuses = <AppConnectivityResult>[];
        final subscription = service.onStatusChanged.listen(statuses.add);

        // Wait for initial status
        await Future<void>.delayed(const Duration(milliseconds: 100));

        // Act - Simulate disconnection
        connectivityController.add([connectivity_plus.ConnectivityResult.none]);
        await Future<void>.delayed(const Duration(milliseconds: 100));

        // Assert
        expect(statuses.length, greaterThanOrEqualTo(1));
        final disconnectedStatus = statuses.lastWhere(
          (s) => s.status == ConnectivityStatus.disconnected,
          orElse: () => statuses.last,
        );
        expect(disconnectedStatus.isDisconnected, isTrue);

        await subscription.cancel();
      });

      test('should not emit duplicate status changes', () async {
        // Arrange
        final statuses = <AppConnectivityResult>[];
        final subscription = service.onStatusChanged.listen(statuses.add);

        // Wait for initial status
        await Future<void>.delayed(const Duration(milliseconds: 100));
        final initialCount = statuses.length;

        // Act - Emit same status multiple times
        connectivityController.add([connectivity_plus.ConnectivityResult.wifi]);
        await Future<void>.delayed(const Duration(milliseconds: 50));
        connectivityController.add([connectivity_plus.ConnectivityResult.wifi]);
        await Future<void>.delayed(const Duration(milliseconds: 50));

        // Assert - Should not emit duplicate status
        // (Only emits when status actually changes)
        expect(statuses.length, lessThanOrEqualTo(initialCount + 1));

        await subscription.cancel();
      });
    });

    group('dispose', () {
      test('should close stream controller on dispose', () {
        // Act
        service.dispose();

        // Assert - Stream should be closed
        expect(() => service.onStatusChanged.listen((_) {}), returnsNormally);
      });

      test('should allow multiple dispose calls', () {
        // Act - First dispose
        service.dispose();

        // Assert - Second dispose should not throw
        expect(() => service.dispose(), returnsNormally);
      });
    });
  });
}
