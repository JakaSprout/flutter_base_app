import 'package:dio/dio.dart';
import 'package:app_mobile_afms/core/sync/models/sync_item.dart';
import 'package:app_mobile_afms/core/sync/services/batch_sync_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_factories.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('BatchSyncService', () {
    late BatchSyncService service;
    late MockDio mockDio;
    const baseUrl = 'https://api.example.com';

    setUp(() {
      mockDio = MockDio();
      service = BatchSyncService(dio: mockDio, baseUrl: baseUrl);
    });

    group('syncBatch', () {
      test('should throw exception when items list is empty', () async {
        // Act & Assert
        expect(() => service.syncBatch([]), throwsA(isA<Exception>()));
      });

      test('should sync single item successfully', () async {
        // Arrange
        final items = [createTestSyncItem(id: 'item1', entityType: 'pond')];
        final response = createTestDioResponseMap(
          statusCode: 202,
          data: {'batchId': 'batch-123', 'accepted': true},
        );

        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        // Act
        final result = await service.syncBatch(items);

        // Assert
        expect(result.batchId, equals('batch-123'));
        expect(result.accepted, isTrue);
        verify(
          () => mockDio.post<Map<String, dynamic>>(
            '$baseUrl/api/sync/pond/batch',
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(1);
      });

      test('should group items by entityType and sync separately', () async {
        // Arrange
        final items = [
          createTestSyncItem(id: 'item1', entityType: 'pond'),
          createTestSyncItem(id: 'item2', entityType: 'pond'),
          createTestSyncItem(id: 'item3', entityType: 'input'),
        ];
        final response = createTestDioResponseMap(
          statusCode: 202,
          data: {'batchId': 'batch-123', 'accepted': true},
        );

        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        // Act
        final result = await service.syncBatch(items);

        // Assert
        expect(result.batchId, equals('batch-123'));
        expect(result.accepted, isTrue);
        // Should call sync for each module
        verify(
          () => mockDio.post<Map<String, dynamic>>(
            '$baseUrl/api/sync/pond/batch',
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(1);
        verify(
          () => mockDio.post<Map<String, dynamic>>(
            '$baseUrl/api/sync/input/batch',
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(1);
      });

      test('should split large batches into smaller chunks', () async {
        // Arrange
        final service = BatchSyncService(
          dio: mockDio,
          baseUrl: baseUrl,
          batchSize: 2, // Small batch size for testing
        );
        final items = [
          createTestSyncItem(id: 'item1', entityType: 'pond'),
          createTestSyncItem(id: 'item2', entityType: 'pond'),
          createTestSyncItem(id: 'item3', entityType: 'pond'),
          createTestSyncItem(id: 'item4', entityType: 'pond'),
        ];
        final response = createTestDioResponseMap(
          statusCode: 202,
          data: {'batchId': 'batch-123', 'accepted': true},
        );

        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        // Act
        final result = await service.syncBatch(items);

        // Assert
        expect(result.batchId, equals('batch-123'));
        // Should split into 2 batches (4 items / 2 batchSize = 2 batches)
        verify(
          () => mockDio.post<Map<String, dynamic>>(
            '$baseUrl/api/sync/pond/batch',
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(2);
      });

      test('should handle immediate results from backend', () async {
        // Arrange
        final items = [createTestSyncItem(id: 'item1', entityType: 'pond')];
        final response = createTestDioResponseMap(
          statusCode: 200,
          data: {
            'batchId': 'batch-123',
            'accepted': true,
            'results': [
              {'id': 'item1', 'success': true, 'entityId': 'entity-123'},
            ],
          },
        );

        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        // Act
        final result = await service.syncBatch(items);

        // Assert
        // Note: syncBatch returns only batchId, results are available via SSE
        expect(result.batchId, equals('batch-123'));
        expect(result.accepted, isTrue);
        // Results are not included in syncBatch response, only batchId for tracking
        expect(result.results, isNull);
      });

      test('should handle failed items in results', () async {
        // Arrange
        final items = [
          createTestSyncItem(id: 'item1', entityType: 'pond'),
          createTestSyncItem(id: 'item2', entityType: 'pond'),
        ];
        final response = createTestDioResponseMap(
          statusCode: 200,
          data: {
            'batchId': 'batch-123',
            'accepted': true,
            'results': [
              {'id': 'item1', 'success': true, 'entityId': 'entity-123'},
              {'id': 'item2', 'success': false, 'error': 'Validation failed'},
            ],
          },
        );

        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        // Act
        final result = await service.syncBatch(items);

        // Assert
        // Note: syncBatch returns only batchId, results are available via SSE
        expect(result.batchId, equals('batch-123'));
        expect(result.accepted, isTrue);
        // Results are not included in syncBatch response, only batchId for tracking
        expect(result.results, isNull);
      });

      test('should accept batchId or jobId from backend', () async {
        // Arrange
        final items = [createTestSyncItem(id: 'item1', entityType: 'pond')];
        final response = createTestDioResponseMap(
          statusCode: 202,
          data: {
            'jobId': 'job-456', // Using jobId instead of batchId
            'accepted': true,
          },
        );

        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        // Act
        final result = await service.syncBatch(items);

        // Assert
        expect(result.batchId, equals('job-456'));
      });

      test(
        'should throw exception when backend does not return batchId',
        () async {
          // Arrange
          final items = [createTestSyncItem(id: 'item1', entityType: 'pond')];
          final response = createTestDioResponseMap(
            statusCode: 202,
            data: {
              'accepted': true,
              // Missing batchId and jobId
            },
          );

          when(
            () => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenAnswer((_) async => response);

          // Act & Assert
          expectLater(service.syncBatch(items), throwsA(isA<Exception>()));
        },
      );

      test(
        'should throw exception when status code is not 200 or 202',
        () async {
          // Arrange
          final items = [createTestSyncItem(id: 'item1', entityType: 'pond')];
          final response = createTestDioResponseMap(
            statusCode: 400,
            data: {'error': 'Bad Request'},
          );

          when(
            () => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenAnswer((_) async => response);

          // Act & Assert
          expectLater(service.syncBatch(items), throwsA(isA<Exception>()));
        },
      );

      test('should handle DioException and rethrow', () async {
        // Arrange
        final items = [createTestSyncItem(id: 'item1', entityType: 'pond')];
        final dioException = createTestDioException();

        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(dioException);

        // Act & Assert
        expectLater(service.syncBatch(items), throwsA(isA<DioException>()));
      });

      test('should include metadata in payload when available', () async {
        // Arrange
        final items = [
          createTestSyncItem(
            id: 'item1',
            entityType: 'pond',
            metadata: {'key': 'value'},
          ),
        ];
        final response = createTestDioResponseMap(
          statusCode: 202,
          data: {'batchId': 'batch-123', 'accepted': true},
        );

        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        // Act
        await service.syncBatch(items);

        // Assert
        verify(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(
              that: predicate<Map<String, dynamic>>((data) {
                final items = data['items'] as List;
                final item = items.first as Map<String, dynamic>;
                return item['metadata'] != null &&
                    item['metadata']['key'] == 'value';
              }),
              named: 'data',
            ),
            options: any(named: 'options'),
          ),
        ).called(1);
      });

      test('should map operation types correctly', () async {
        // Arrange
        final items = [
          createTestSyncItem(
            id: 'item1',
            entityType: 'pond',
            operationType: SyncOperationType.create,
          ),
          createTestSyncItem(
            id: 'item2',
            entityType: 'pond',
            operationType: SyncOperationType.update,
          ),
          createTestSyncItem(
            id: 'item3',
            entityType: 'pond',
            operationType: SyncOperationType.delete,
          ),
        ];
        final response = createTestDioResponseMap(
          statusCode: 202,
          data: {'batchId': 'batch-123', 'accepted': true},
        );

        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => response);

        // Act
        await service.syncBatch(items);

        // Assert
        verify(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(
              that: predicate<Map<String, dynamic>>((data) {
                final items = data['items'] as List;
                final operations = items
                    .map((item) => (item as Map)['operation'] as String)
                    .toList();
                return operations.contains('create') &&
                    operations.contains('update') &&
                    operations.contains('delete');
              }),
              named: 'data',
            ),
            options: any(named: 'options'),
          ),
        ).called(1);
      });
    });
  });
}
