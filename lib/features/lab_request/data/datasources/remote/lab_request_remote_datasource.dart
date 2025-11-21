import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/config/app_config.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/lab_request/data/models/lab_request_model.dart';

/// Remote data source interface for Lab Request feature.
abstract class LabRequestRemoteDataSource {
  /// Create a new lab request.
  Future<Either<Failure, LabRequestModel>> createLabRequest(
    LabRequestModel request,
  );

  /// Get list of submitted lab requests.
  Future<Either<Failure, List<LabRequestModel>>> getLabRequestList({
    DateTime? startDate,
    DateTime? endDate,
  });
}

/// Mock implementation of [LabRequestRemoteDataSource].
///
/// This provides fake/mock data for development and testing.
/// In production, this should be replaced with actual API calls.
class LabRequestRemoteDataSourceMock
    implements LabRequestRemoteDataSource {
  /// Creates a new instance of [LabRequestRemoteDataSourceMock].
  LabRequestRemoteDataSourceMock({required AppConfig config})
      : _config = config;

  final AppConfig _config;

  /// Simulate network delay.
  Future<void> _simulateDelay() async {
    final delay = _config.mockApiDelayMs;
    if (delay > 0) {
      await Future<void>.delayed(Duration(milliseconds: delay));
    }
  }

  @override
  Future<Either<Failure, LabRequestModel>> createLabRequest(
    LabRequestModel request,
  ) async {
    // Simulate network delay
    await _simulateDelay();

    // Mock data - simulating API response
    try {
      // Generate a mock ID for the created request
      final createdRequest = request.copyWith(
        id: 'req_${DateTime.now().millisecondsSinceEpoch}',
        status: 'Request sedang dikerjakan',
        tanggalRequest: DateTime.now(),
      );

      return Right(createdRequest);
    } catch (e) {
      return Left(
        NetworkFailure.serverError('Failed to create lab request: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<LabRequestModel>>> getLabRequestList({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // Simulate network delay
    await _simulateDelay();

    // Mock data - simulating API response
    try {
      final mockData = [
        LabRequestModel(
          id: 'req_1',
          namaPengirim: 'SUMBER HASIL',
          noTelp: '-',
          email: '-',
          tambakAsal: '1412',
          customer: 'SUMBER HASIL',
          tanggalPengiriman: DateTime(2025, 11, 4),
          anamnesa: 'screening',
          keteranganSampel: '-',
          jenisTesting: 'PCR Konvensional',
          status: 'Report sedang dikerjakan',
          tanggalRequest: DateTime(2025, 11, 5),
          jumlahSampel: 5,
        ),
        LabRequestModel(
          id: 'req_2',
          namaPengirim: 'BAROKAH WONGSOREJO',
          noTelp: '-',
          email: '-',
          tambakAsal: '1386',
          customer: 'BAROKAH WONGSOREJO',
          tanggalPengiriman: DateTime(2025, 11, 4),
          anamnesa: 'screening',
          keteranganSampel: '-',
          jenisTesting: 'PCR Realtime',
          status: 'Report sedang dikerjakan',
          tanggalRequest: DateTime(2025, 11, 5),
          jumlahSampel: 16,
        ),
        LabRequestModel(
          id: 'req_3',
          namaPengirim: 'Tambak Jayasena',
          noTelp: '-',
          email: '-',
          tambakAsal: '2048',
          customer: 'Tambak Jayasena',
          tanggalPengiriman: DateTime(2025, 11, 4),
          anamnesa: 'screening',
          keteranganSampel: '-',
          jenisTesting: 'Water Quality',
          status: 'Report sedang dikerjakan',
          tanggalRequest: DateTime(2025, 11, 5),
          jumlahSampel: 4,
        ),
      ];

      // Filter by date range if provided
      var filteredData = mockData;
      if (startDate != null || endDate != null) {
        filteredData = mockData.where((request) {
          final requestDate = request.tanggalRequest;
          if (requestDate == null) return false;

          if (startDate != null && requestDate.isBefore(startDate)) {
            return false;
          }
          if (endDate != null && requestDate.isAfter(endDate)) {
            return false;
          }
          return true;
        }).toList();
      }

      return Right(filteredData);
    } catch (e) {
      return Left(
        NetworkFailure.serverError('Failed to fetch lab request list: $e'),
      );
    }
  }
}


