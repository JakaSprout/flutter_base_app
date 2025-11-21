import 'package:app_mobile_afms/core/sync/models/sync_item.dart';
import 'package:app_mobile_afms/core/sync/services/sync_executor.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/mock_factories.dart';

void main() {
  group('SyncExecutor', () {
    late SyncExecutor executor;

    setUp(() {
      executor = SyncExecutor();
    });

    group('execute', () {
      test(
        'should return true when operation succeeds on first attempt',
        () async {
          // Arrange
          final item = createTestSyncItem();
          var callCount = 0;

          Future<void> operation(SyncItem item) async {
            callCount++;
            await Future<void>.delayed(const Duration(milliseconds: 10));
          }

          // Act
          final result = await executor.execute(item, operation);

          // Assert
          expect(result, isTrue);
          expect(callCount, equals(1));
        },
      );

      test('should retry and succeed on second attempt', () async {
        // Arrange
        final item = createTestSyncItem();
        var callCount = 0;

        Future<void> operation(SyncItem item) async {
          callCount++;
          if (callCount == 1) {
            throw Exception('First attempt failed');
          }
          await Future<void>.delayed(const Duration(milliseconds: 10));
        }

        // Act
        final result = await executor.execute(item, operation);

        // Assert
        expect(result, isTrue);
        expect(callCount, equals(2));
      });

      test('should return false after max retries exceeded', () async {
        // Arrange
        final item = createTestSyncItem();
        var callCount = 0;

        Future<void> operation(SyncItem item) async {
          callCount++;
          throw Exception('Always fails');
        }

        // Act
        final result = await executor.execute(item, operation);

        // Assert
        expect(result, isFalse);
        expect(callCount, equals(executor.maxRetries + 1));
      });

      test('should use exponential backoff for retries', () async {
        // Arrange
        final executor = SyncExecutor(
          retryDelay: const Duration(milliseconds: 100),
        );
        final item = createTestSyncItem();
        final retryTimes = <DateTime>[];
        var callCount = 0;

        Future<void> operation(SyncItem item) async {
          callCount++;
          retryTimes.add(DateTime.now());
          if (callCount < 3) {
            throw Exception('Retry needed');
          }
        }

        // Act
        await executor.execute(item, operation);

        // Assert
        expect(callCount, equals(3));
        // Verify exponential backoff: delays should increase
        if (retryTimes.length >= 3) {
          final delay1 = retryTimes[1].difference(retryTimes[0]);
          final delay2 = retryTimes[2].difference(retryTimes[1]);
          // delay2 should be approximately 2x delay1 (exponential backoff)
          expect(delay2.inMilliseconds, greaterThan(delay1.inMilliseconds));
        }
      });

      test('should handle custom max retries', () async {
        // Arrange
        final executor = SyncExecutor(maxRetries: 2);
        final item = createTestSyncItem();
        var callCount = 0;

        Future<void> operation(SyncItem item) async {
          callCount++;
          throw Exception('Always fails');
        }

        // Act
        final result = await executor.execute(item, operation);

        // Assert
        expect(result, isFalse);
        expect(callCount, equals(3)); // maxRetries + 1
      });

      test('should handle custom retry delay', () async {
        // Arrange
        final executor = SyncExecutor(
          maxRetries: 2,
          retryDelay: const Duration(milliseconds: 50),
        );
        final item = createTestSyncItem();
        var callCount = 0;

        Future<void> operation(SyncItem item) async {
          callCount++;
          if (callCount < 2) {
            throw Exception('Retry needed');
          }
        }

        // Act
        final startTime = DateTime.now();
        await executor.execute(item, operation);
        final endTime = DateTime.now();

        // Assert
        expect(callCount, equals(2));
        // Should have some delay due to retry
        expect(
          endTime.difference(startTime).inMilliseconds,
          greaterThanOrEqualTo(50),
        );
      });
    });

    group('calculateRetryDelay', () {
      test('should calculate exponential backoff delay correctly', () {
        // Arrange
        final executor = SyncExecutor(
          retryDelay: const Duration(milliseconds: 100),
        );

        // Act & Assert
        final delay1 = executor.calculateRetryDelay(1);
        expect(delay1.inMilliseconds, equals(100)); // 100 * 2^0

        final delay2 = executor.calculateRetryDelay(2);
        expect(delay2.inMilliseconds, equals(200)); // 100 * 2^1

        final delay3 = executor.calculateRetryDelay(3);
        expect(delay3.inMilliseconds, equals(400)); // 100 * 2^2
      });

      test('should handle different base delays', () {
        // Arrange
        final executor = SyncExecutor(
          retryDelay: const Duration(milliseconds: 50),
        );

        // Act & Assert
        final delay1 = executor.calculateRetryDelay(1);
        expect(delay1.inMilliseconds, equals(50));

        final delay2 = executor.calculateRetryDelay(2);
        expect(delay2.inMilliseconds, equals(100));
      });
    });
  });
}
