import 'package:app_mobile_afms/core/config/app_config.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/data/models/banner_model.dart';
import 'package:app_mobile_afms/features/home/data/models/home_model.dart';
import 'package:app_mobile_afms/features/home/data/models/input_data_item_model.dart';
import 'package:app_mobile_afms/features/home/data/models/pond_model.dart';
import 'package:dartz/dartz.dart';

/// Remote data source interface for Home feature.
abstract class HomeRemoteDataSource {
  /// Get home data from remote API (all sections).
  Future<Either<Failure, HomeModel>> getHomeData();

  /// Get dashboard summary data from remote API.
  Future<Either<Failure, Map<String, dynamic>>> getDashboardSummaryData();

  /// Get pond list data from remote API.
  Future<Either<Failure, List<PondModel>>> getPondListData();

  /// Get company list data from remote API.
  Future<Either<Failure, Map<String, dynamic>>> getFarmListData();

  /// Get header data from remote API.
  Future<Either<Failure, Map<String, dynamic>>> getHeaderData();

  /// Get banner list data from remote API.
  Future<Either<Failure, List<BannerModel>>> getBannerListData();

  /// Get input data list from remote API.
  Future<Either<Failure, List<InputDataItemModel>>> getInputDataListData();
}

/// Mock implementation of [HomeRemoteDataSource].
///
/// This provides fake/mock data for development and testing.
/// In production, this should be replaced with actual API calls.
class HomeRemoteDataSourceMock implements HomeRemoteDataSource {
  /// Creates a new instance of [HomeRemoteDataSourceMock].
  HomeRemoteDataSourceMock({required AppConfig config}) : _config = config;

  final AppConfig _config;

  /// Simulate network delay.
  Future<void> _simulateDelay() async {
    final delay = _config.mockApiDelayMs;
    if (delay > 0) {
      await Future<void>.delayed(Duration(milliseconds: delay));
    }
  }

  @override
  Future<Either<Failure, HomeModel>> getHomeData() async {
    // Simulate network delay
    await _simulateDelay();

    // Mock data - simulating API response
    try {
      const mockData = HomeModel(
        activePonds: 8,
        estimasiBiomassa: '1250',
        totalPakan: '1.000',
        biayaPakan: '20',
        estimasiSR: '100',
        ponds: [
          PondModel(id: 'TKH00A1', name: 'Kolam A1'),
          PondModel(id: 'TKH00A2', name: 'Kolam A2'),
          PondModel(id: 'TKH00A3', name: 'Kolam A3'),
          PondModel(id: 'TKH00B1', name: 'Kolam B1'),
          PondModel(id: 'TKH00B2', name: 'Kolam B2'),
          PondModel(id: 'TKH00C1', name: 'Kolam C1'),
          PondModel(id: 'TKH00C2', name: 'Kolam C2'),
          PondModel(id: 'TKH00D1', name: 'Kolam D1'),
        ],
        companies: [
          'PT. Tambak Bersama',
          'PT. Company Lain',
          'PT. Company Lain Lagi',
        ],
        selectedCompany: 'PT. Tambak Bersama',
      );

      return const Right(mockData);
    } catch (e) {
      return Left(NetworkFailure.serverError('Failed to fetch home data: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>>
  getDashboardSummaryData() async {
    await _simulateDelay();

    try {
      const mockData = {
        'activePonds': 8,
        'estimasiBiomassa': '1250',
        'totalPakan': '1.000',
        'biayaPakan': '20',
        'estimasiSR': '100',
      };

      return const Right(mockData);
    } catch (e) {
      return Left(
        NetworkFailure.serverError('Failed to fetch dashboard summary: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<PondModel>>> getPondListData() async {
    await _simulateDelay();

    try {
      const mockData = [
        PondModel(id: 'TKH00A1', name: 'Kolam A1'),
        PondModel(id: 'TKH00A2', name: 'Kolam A2'),
        PondModel(id: 'TKH00A3', name: 'Kolam A3'),
        PondModel(id: 'TKH00B1', name: 'Kolam B1'),
        PondModel(id: 'TKH00B2', name: 'Kolam B2'),
        PondModel(id: 'TKH00C1', name: 'Kolam C1'),
        PondModel(id: 'TKH00C2', name: 'Kolam C2'),
        PondModel(id: 'TKH00D1', name: 'Kolam D1'),
      ];

      return const Right(mockData);
    } catch (e) {
      return Left(NetworkFailure.serverError('Failed to fetch pond list: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getFarmListData() async {
    await _simulateDelay();

    try {
      const mockData = {
        'farms': [
          'PT. Tambak Bersama',
          'PT. Company Lain',
          'PT. Company Lain Lagi',
        ],
        'selectedFarm': 'PT. Tambak Bersama',
      };

      return const Right(mockData);
    } catch (e) {
      return Left(
        NetworkFailure.serverError('Failed to fetch company list: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getHeaderData() async {
    await _simulateDelay();

    try {
      const mockData = {
        'notificationCount': 3, // Mock: 3 unread notifications
      };

      return const Right(mockData);
    } catch (e) {
      return Left(
        NetworkFailure.serverError('Failed to fetch header data: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<BannerModel>>> getBannerListData() async {
    await _simulateDelay();

    try {
      const mockData = [
        BannerModel(
          id: 'harvest_calculator',
          title: 'Kalkulator Panen',
          description: 'Hitung potensi hasil panen Kamu.',
          imagePath: 'assets/images/kalkulator-panen.jpg',
          backgroundColor: '#FFFFFF',
        ),
        BannerModel(
          id: 'lab_analysis',
          title: 'Analisis Lab',
          description: 'Lakukan analisis laboratorium untuk kualitas air.',
          imagePath: 'assets/images/analisis-lab.jpg',
          backgroundColor: '#FFFFFF',
        ),
      ];

      return const Right(mockData);
    } catch (e) {
      return Left(
        NetworkFailure.serverError('Failed to fetch banner list: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<InputDataItemModel>>>
  getInputDataListData() async {
    await _simulateDelay();

    try {
      // Mock data with custom order - can be changed via API
      const mockData = [
        InputDataItemModel(
          id: 'pakan',
          label: 'Pakan',
          iconPath: 'assets/icons/general/feed.svg',
          backgroundColor: '#1426C3BB', // rgba(38, 195, 187, 0.08)
          iconColor: '#26C3BB',
          order: 1,
        ),
        InputDataItemModel(
          id: 'kualitas_air',
          label: 'Kualitas Air',
          iconPath: 'assets/icons/general/water-quality.svg',
          backgroundColor: '#14135CED', // rgba(19, 92, 237, 0.08)
          iconColor: '#135CED',
          order: 2,
        ),
        InputDataItemModel(
          id: 'pertumbuhan',
          label: 'Pertumbuhan',
          iconPath: 'assets/icons/general/growth.svg',
          backgroundColor: '#148400FF', // rgba(132, 0, 255, 0.08)
          iconColor: '#8400FF',
          order: 3,
        ),
        InputDataItemModel(
          id: 'kimia',
          label: 'Kimia',
          iconPath: 'assets/icons/general/chemistry.svg',
          backgroundColor: '#14FA6619', // rgba(250, 102, 25, 0.08)
          iconColor: '#FA6619',
          order: 4,
        ),
        InputDataItemModel(
          id: 'plankton',
          label: 'Plankton',
          iconPath: 'assets/icons/general/microscope.svg',
          backgroundColor: '#14137FEC', // rgba(19, 127, 236, 0.08)
          iconColor: '#137FEC',
          order: 5,
        ),
        InputDataItemModel(
          id: 'mikrobiologi',
          label: 'Mikrobiologi',
          iconPath: 'assets/icons/general/microbiology.svg',
          backgroundColor: '#141BAA69', // rgba(27, 170, 105, 0.08)
          iconColor: '#1BAA69',
          order: 6,
        ),
        InputDataItemModel(
          id: 'penyakit',
          label: 'Penyakit',
          iconPath: 'assets/icons/general/disease.svg',
          backgroundColor: '#14BD7F3C', // rgba(189, 127, 60, 0.08)
          iconColor: '#BD7F3C',
          order: 7,
        ),
        InputDataItemModel(
          id: 'kematian',
          label: 'Kematian',
          iconPath: 'assets/icons/general/mortality.svg',
          backgroundColor: '#14D84639', // rgba(216, 70, 57, 0.08)
          iconColor: '#D84639',
          order: 8,
        ),
      ];

      return const Right(mockData);
    } catch (e) {
      return Left(
        NetworkFailure.serverError('Failed to fetch input data list: $e'),
      );
    }
  }
}
