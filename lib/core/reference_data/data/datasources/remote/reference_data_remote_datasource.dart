import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/core/reference_data/domain/entities/reference_data_entities.dart';
import 'package:dio/dio.dart';

/// Remote response containing data plus optional metadata headers.
class ReferenceDataRemoteResponse<T> {
  ReferenceDataRemoteResponse({
    required this.data,
    this.etag,
    this.version,
    DateTime? fetchedAt,
  }) : fetchedAt = fetchedAt ?? DateTime.now();

  final List<T> data;
  final String? etag;
  final String? version;
  final DateTime fetchedAt;
}

/// Remote datasource responsible for fetching reference data from API.
abstract class ReferenceDataRemoteDatasource {
  Future<ReferenceDataRemoteResponse<LabTestTypeEntity>> fetchLabTestTypes(
    String employeeId,
  );
  Future<ReferenceDataRemoteResponse<EmployeeSummary>> fetchEmployees(
    String employeeId,
  );
  Future<ReferenceDataRemoteResponse<CustomerSummary>> fetchCustomers(
    String employeeId,
  );
  Future<ReferenceDataRemoteResponse<FarmSummary>> fetchFarms(
    String employeeId,
  );
  Future<ReferenceDataRemoteResponse<PondSummary>> fetchPonds(
    String employeeId,
  );
}

class ReferenceDataRemoteDatasourceImpl
    implements ReferenceDataRemoteDatasource {
  ReferenceDataRemoteDatasourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<ReferenceDataRemoteResponse<LabTestTypeEntity>> fetchLabTestTypes(
    String employeeId,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/v1/request-lab/lab-test-types',
      queryParameters: _buildQuery(employeeId),
    );
    final data = _extractList(response.data);
    final entities = data
        .map(
          (json) => LabTestTypeEntity(
            id: _asString(json, 'id'),
            name: _asString(json, 'name'),
            description: _asString(json, 'description').isEmpty
                ? null
                : _asString(json, 'description'),
            displayOrder: _asInt(json, 'order'),
            isActive: _asBool(json, 'is_active', fallback: true),
          ),
        )
        .toList();
    return ReferenceDataRemoteResponse<LabTestTypeEntity>(
      data: entities,
      etag: response.headers.value('etag'),
      version: response.headers.value('x-version'),
    );
  }

  @override
  Future<ReferenceDataRemoteResponse<EmployeeSummary>> fetchEmployees(
    String employeeId,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/v1/employees',
      queryParameters: _buildQuery(employeeId),
    );
    final data = _extractList(response.data);
    final entities = data
        .map(
          (json) => EmployeeSummary(
            id: _asInt(json, 'id'),
            name: _asString(json, 'name', fallback: 'Unknown Employee'),
            email: _asNullableString(json, 'email'),
            phone: _asNullableString(json, 'phone'),
            position: _asNullableString(json, 'position'),
            department: _asNullableString(json, 'department'),
            isActive: _asBool(json, 'is_active', fallback: true),
          ),
        )
        .toList();
    return ReferenceDataRemoteResponse<EmployeeSummary>(
      data: entities,
      etag: response.headers.value('etag'),
      version: response.headers.value('x-version'),
    );
  }

  @override
  Future<ReferenceDataRemoteResponse<CustomerSummary>> fetchCustomers(
    String employeeId,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/v1/customers',
      queryParameters: _buildQuery(employeeId),
    );
    final data = _extractList(response.data);
    final entities = data
        .map(
          (json) => CustomerSummary(
            id: _asInt(json, 'id'),
            name: _asString(json, 'name', fallback: 'Unknown Customer'),
            code: _asNullableString(json, 'code'),
            email: _asNullableString(json, 'email'),
            phone: _asNullableString(json, 'phone'),
            address: _asNullableString(json, 'address'),
            isActive: _asBool(json, 'is_active', fallback: true),
          ),
        )
        .toList();
    return ReferenceDataRemoteResponse<CustomerSummary>(
      data: entities,
      etag: response.headers.value('etag'),
      version: response.headers.value('x-version'),
    );
  }

  @override
  Future<ReferenceDataRemoteResponse<FarmSummary>> fetchFarms(
    String employeeId,
  ) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/api/v1/farms',
        queryParameters: _buildQuery(employeeId),
      );

      AppLogger.debug('fetchFarms: Response status: ${response.statusCode}');
      AppLogger.debug(
        'fetchFarms: Response data type: ${response.data.runtimeType}',
      );

      final data = _extractList(response.data);

      AppLogger.debug(
        'fetchFarms: Extracted ${data.length} farms from response',
      );

      if (data.isEmpty) {
        AppLogger.warning('fetchFarms: No farms found in API response');
      }

      final entities = data.map((json) {
        // Parse farm name - API uses 'farm_name' (primary), fallback to 'name'
        final farmName = _asString(json, 'farm_name');
        final fallbackName = _asString(json, 'name');
        final finalName = farmName.isNotEmpty
            ? farmName
            : (fallbackName.isNotEmpty ? fallbackName : 'Unknown Farm');

        // Parse farm code - API uses 'farm_code' (primary), fallback to 'code'
        final farmCode =
            _asNullableString(json, 'farm_code') ??
            _asNullableString(json, 'code') ??
            _asNullableString(json, 'farmCode');

        // Parse farm location/address - API uses 'farm_location' (primary), fallback to 'address'
        final farmLocation =
            _asNullableString(json, 'farm_location') ??
            _asNullableString(json, 'address') ??
            _asNullableString(json, 'location');

        // Parse latitude and longitude
        final latitude = _asNullableDouble(json, 'latitude');
        final longitude = _asNullableDouble(json, 'longitude');

        // Parse is_active
        final isActive =
            _asBool(json, 'is_active', fallback: true) ||
            _asBool(json, 'isActive', fallback: true);

        // Log warning if we couldn't find the name field
        if (finalName == 'Unknown Farm') {
          AppLogger.warning(
            'fetchFarms: Could not find name field for farm. '
            'Available keys: ${json.keys.toList()}, '
            'JSON: $json',
          );
        }

        return FarmSummary(
          id: _asInt(json, 'id'),
          name: finalName,
          code: farmCode,
          address: farmLocation,
          latitude: latitude,
          longitude: longitude,
          isActive: isActive,
        );
      }).toList();

      AppLogger.debug(
        'fetchFarms: Successfully parsed ${entities.length} farms',
      );

      return ReferenceDataRemoteResponse<FarmSummary>(
        data: entities,
        etag: response.headers.value('etag'),
        version: response.headers.value('x-version'),
      );
    } catch (e, stackTrace) {
      AppLogger.error('fetchFarms: Error fetching farms', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<ReferenceDataRemoteResponse<PondSummary>> fetchPonds(
    String employeeId,
  ) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/api/v1/ponds',
        queryParameters: _buildQuery(employeeId),
      );

      AppLogger.debug('fetchPonds: Response status: ${response.statusCode}');
      AppLogger.debug(
        'fetchPonds: Response data type: ${response.data.runtimeType}',
      );

      final data = _extractList(response.data);

      AppLogger.debug(
        'fetchPonds: Extracted ${data.length} ponds from response',
      );

      if (data.isEmpty) {
        AppLogger.warning('fetchPonds: No ponds found in API response');
      }

      final entities = data.map((json) {
        // Parse pond name - API uses 'pond_name' (primary), fallback to 'name'
        final pondName = _asString(json, 'pond_name');
        final fallbackName = _asString(json, 'name');
        final finalName = pondName.isNotEmpty
            ? pondName
            : (fallbackName.isNotEmpty ? fallbackName : 'Unnamed Pond');

        // Parse pond status - API uses 'pond_status' (primary), fallback to 'status'
        final pondStatus = _asString(json, 'pond_status');
        final fallbackStatus = _asString(json, 'status');
        final finalStatus = pondStatus.isNotEmpty
            ? pondStatus
            : (fallbackStatus.isNotEmpty ? fallbackStatus : 'Available');

        // Parse pond code - API uses 'pond_code' (primary), fallback to 'code'
        final pondCode =
            _asNullableString(json, 'pond_code') ??
            _asNullableString(json, 'code') ??
            _asNullableString(json, 'pondCode');

        // Parse area - API uses 'pond_size_sqm' (primary), fallback to 'area_sqm'
        final areaSqm =
            _asNullableDouble(json, 'pond_size_sqm') ??
            _asNullableDouble(json, 'area_sqm') ??
            _asNullableDouble(json, 'areaSqm') ??
            _asNullableDouble(json, 'pondSizeSqm');

        // Parse farm ID
        final farmId =
            _asNullableInt(json, 'farm_id') ?? _asNullableInt(json, 'farmId');

        // Parse is_active
        final isActive =
            _asBool(json, 'is_active', fallback: true) ||
            _asBool(json, 'isActive', fallback: true);

        // Log warning if we couldn't find the name field
        if (finalName == 'Unnamed Pond') {
          AppLogger.warning(
            'fetchPonds: Could not find name field for pond. '
            'Available keys: ${json.keys.toList()}, '
            'JSON: $json',
          );
        }

        return PondSummary(
          id: _asInt(json, 'id'),
          name: finalName,
          farmId: farmId,
          code: pondCode,
          areaSqm: areaSqm,
          status: finalStatus,
          isActive: isActive,
        );
      }).toList();

      AppLogger.debug(
        'fetchPonds: Successfully parsed ${entities.length} ponds',
      );

      return ReferenceDataRemoteResponse<PondSummary>(
        data: entities,
        etag: response.headers.value('etag'),
        version: response.headers.value('x-version'),
      );
    } catch (e, stackTrace) {
      AppLogger.error('fetchPonds: Error fetching ponds', e, stackTrace);
      rethrow;
    }
  }

  List<Map<String, dynamic>> _extractList(dynamic body) {
    if (body is Map<String, dynamic>) {
      final data = body['data'];
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
    } else if (body is List) {
      return body.cast<Map<String, dynamic>>();
    }
    return const [];
  }

  String _asString(
    Map<String, dynamic> json,
    String key, {
    String fallback = '',
  }) {
    final value = json[key];
    if (value == null) return fallback;
    return value.toString();
  }

  String? _asNullableString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;
    final str = value.toString();
    return str.isEmpty ? null : str;
  }

  int _asInt(Map<String, dynamic> json, String key, {int fallback = 0}) {
    final value = json[key];
    if (value == null) return fallback;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? fallback;
  }

  int? _asNullableInt(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  double? _asNullableDouble(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  bool _asBool(Map<String, dynamic> json, String key, {bool fallback = false}) {
    final value = json[key];
    if (value == null) return fallback;
    if (value is bool) return value;
    final normalized = value.toString().toLowerCase();
    return normalized == 'true' ||
        normalized == '1' ||
        normalized == 'yes' ||
        normalized == 'active';
  }

  Map<String, dynamic> _buildQuery(String employeeId) => {
    'employee_id': employeeId,
    'employeeId': employeeId,
  };
}
