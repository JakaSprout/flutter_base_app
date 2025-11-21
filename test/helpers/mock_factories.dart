import 'package:connectivity_plus/connectivity_plus.dart' as connectivity_plus;
import 'package:dio/dio.dart';
import 'package:app_mobile_afms/core/connectivity/connectivity_models.dart';
import 'package:app_mobile_afms/core/connectivity/connectivity_service.dart';
import 'package:app_mobile_afms/core/sync/models/sync_item.dart';
import 'package:app_mobile_afms/core/sync/models/sync_status.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';

/// Mock classes for testing.
///
/// These mocks can be used with mocktail to create test doubles.

/// Mock for FlutterSecureStorage.
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

/// Mock for Dio.
class MockDio extends Mock implements Dio {}

/// Mock for DioClient.
class MockDioClient extends Mock implements Dio {}

/// Mock for ConnectivityService.
class MockConnectivityService extends Mock implements ConnectivityService {}

/// Mock for connectivity_plus.Connectivity.
class MockConnectivity extends Mock implements connectivity_plus.Connectivity {}

/// Mock for Response.
class MockResponse extends Mock implements Response<dynamic> {}

/// Mock for RequestOptions.
class MockRequestOptions extends Mock implements RequestOptions {}

/// Factory functions for creating test data.

/// Create a test SyncItem.
SyncItem createTestSyncItem({
  String? id,
  SyncOperationType? operationType,
  String? entityType,
  String? entityId,
  Map<String, dynamic>? data,
  SyncPriority? priority,
  int? maxRetries,
  DateTime? createdAt,
  Map<String, dynamic>? metadata,
}) {
  return SyncItem(
    id: id ?? 'test-sync-id-1',
    operationType: operationType ?? SyncOperationType.create,
    entityType: entityType ?? 'test_entity',
    entityId: entityId ?? 'test-entity-id-1',
    data: data ?? {'test': 'data'},
    priority: priority ?? SyncPriority.normal,
    maxRetries: maxRetries ?? 3,
    createdAt: createdAt ?? DateTime.now(),
    metadata: metadata,
  );
}

/// Create a test SyncStatusModel.
SyncStatusModel createTestSyncStatus({
  SyncStatus? status,
  int? totalItems,
  int? syncedItems,
  int? failedItems,
  DateTime? lastSyncTime,
  String? message,
}) {
  return SyncStatusModel(
    status: status ?? SyncStatus.idle,
    totalItems: totalItems ?? 0,
    syncedItems: syncedItems ?? 0,
    failedItems: failedItems ?? 0,
    lastSyncTime: lastSyncTime,
    message: message,
  );
}

/// Create a test AppConnectivityResult.
AppConnectivityResult createTestConnectivityStatus({
  ConnectivityStatus? status,
  String? type,
  bool? isConnected,
}) {
  return AppConnectivityResult(
    status: status ?? ConnectivityStatus.connected,
    type: type ?? 'wifi',
  );
}

/// Create a test DioResponse.
Response<dynamic> createTestDioResponse({
  dynamic data,
  int? statusCode,
  Headers? headers,
  RequestOptions? requestOptions,
}) {
  return Response<dynamic>(
    data: data ?? {'success': true},
    statusCode: statusCode ?? 200,
    headers: headers ?? Headers(),
    requestOptions: requestOptions ?? RequestOptions(path: '/test'),
  );
}

/// Create a test DioResponse with Map<String, dynamic> data.
Response<Map<String, dynamic>> createTestDioResponseMap({
  Map<String, dynamic>? data,
  int? statusCode,
  Headers? headers,
  RequestOptions? requestOptions,
}) {
  return Response<Map<String, dynamic>>(
    data: data ?? {'success': true},
    statusCode: statusCode ?? 200,
    headers: headers ?? Headers(),
    requestOptions: requestOptions ?? RequestOptions(path: '/test'),
  );
}

/// Create a test DioException.
DioException createTestDioException({
  DioExceptionType? type,
  String? message,
  int? statusCode,
  Response<dynamic>? response,
  RequestOptions? requestOptions,
}) {
  return DioException(
    type: type ?? DioExceptionType.connectionTimeout,
    message: message ?? 'Test error',
    response: response,
    requestOptions: requestOptions ?? RequestOptions(path: '/test'),
  );
}
