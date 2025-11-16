import 'package:flutter_base_app/core/connectivity/connectivity_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConnectivityStatus', () {
    test('should have all three status values', () {
      // Assert
      expect(ConnectivityStatus.values, hasLength(3));
      expect(ConnectivityStatus.values, contains(ConnectivityStatus.connected));
      expect(
        ConnectivityStatus.values,
        contains(ConnectivityStatus.disconnected),
      );
      expect(ConnectivityStatus.values, contains(ConnectivityStatus.unknown));
    });
  });

  group('AppConnectivityResult', () {
    group('constructor', () {
      test('should create result with required status', () {
        // Act
        const result = AppConnectivityResult(
          status: ConnectivityStatus.connected,
        );

        // Assert
        expect(result.status, equals(ConnectivityStatus.connected));
        expect(result.type, isNull);
        expect(result.message, isNull);
      });

      test('should create result with all properties', () {
        // Act
        const result = AppConnectivityResult(
          status: ConnectivityStatus.connected,
          type: 'wifi',
          message: 'Connected via WiFi',
        );

        // Assert
        expect(result.status, equals(ConnectivityStatus.connected));
        expect(result.type, equals('wifi'));
        expect(result.message, equals('Connected via WiFi'));
      });
    });

    group('getters', () {
      test('isConnected should return true for connected status', () {
        // Arrange
        const result = AppConnectivityResult(
          status: ConnectivityStatus.connected,
        );

        // Assert
        expect(result.isConnected, isTrue);
        expect(result.isDisconnected, isFalse);
      });

      test('isDisconnected should return true for disconnected status', () {
        // Arrange
        const result = AppConnectivityResult(
          status: ConnectivityStatus.disconnected,
        );

        // Assert
        expect(result.isDisconnected, isTrue);
        expect(result.isConnected, isFalse);
      });

      test('isConnected should return false for unknown status', () {
        // Arrange
        const result = AppConnectivityResult(
          status: ConnectivityStatus.unknown,
        );

        // Assert
        expect(result.isConnected, isFalse);
        expect(result.isDisconnected, isFalse);
      });
    });

    group('toString', () {
      test('should return formatted string representation', () {
        // Arrange
        const result = AppConnectivityResult(
          status: ConnectivityStatus.connected,
          type: 'wifi',
        );

        // Act
        final string = result.toString();

        // Assert
        expect(string, contains('AppConnectivityResult'));
        expect(string, contains('status: ConnectivityStatus.connected'));
        expect(string, contains('type: wifi'));
      });

      test('should handle null type in toString', () {
        // Arrange
        const result = AppConnectivityResult(
          status: ConnectivityStatus.disconnected,
        );

        // Act
        final string = result.toString();

        // Assert
        expect(string, contains('AppConnectivityResult'));
        expect(string, contains('status: ConnectivityStatus.disconnected'));
        expect(string, contains('type: null'));
      });
    });

    group('equality', () {
      test('should be equal when all properties match', () {
        // Arrange
        const result1 = AppConnectivityResult(
          status: ConnectivityStatus.connected,
          type: 'wifi',
          message: 'Connected',
        );
        const result2 = AppConnectivityResult(
          status: ConnectivityStatus.connected,
          type: 'wifi',
          message: 'Connected',
        );

        // Assert
        expect(result1, equals(result2));
        expect(result1.hashCode, equals(result2.hashCode));
      });

      test('should not be equal when status differs', () {
        // Arrange
        const result1 = AppConnectivityResult(
          status: ConnectivityStatus.connected,
        );
        const result2 = AppConnectivityResult(
          status: ConnectivityStatus.disconnected,
        );

        // Assert
        expect(result1, isNot(equals(result2)));
      });

      test('should not be equal when type differs', () {
        // Arrange
        const result1 = AppConnectivityResult(
          status: ConnectivityStatus.connected,
          type: 'wifi',
        );
        const result2 = AppConnectivityResult(
          status: ConnectivityStatus.connected,
          type: 'mobile',
        );

        // Assert
        expect(result1, isNot(equals(result2)));
      });

      test('should not be equal when message differs', () {
        // Arrange
        const result1 = AppConnectivityResult(
          status: ConnectivityStatus.connected,
          message: 'Message 1',
        );
        const result2 = AppConnectivityResult(
          status: ConnectivityStatus.connected,
          message: 'Message 2',
        );

        // Assert
        expect(result1, isNot(equals(result2)));
      });

      test('should be equal when both have null type and message', () {
        // Arrange
        const result1 = AppConnectivityResult(
          status: ConnectivityStatus.connected,
        );
        const result2 = AppConnectivityResult(
          status: ConnectivityStatus.connected,
        );

        // Assert
        expect(result1, equals(result2));
        expect(result1.hashCode, equals(result2.hashCode));
      });
    });
  });
}

