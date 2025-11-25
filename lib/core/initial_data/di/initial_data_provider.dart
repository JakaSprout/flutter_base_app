import 'package:app_mobile_afms/core/di/providers/database_provider.dart';
import 'package:app_mobile_afms/core/di/providers/dio_provider.dart';
import 'package:app_mobile_afms/core/initial_data/services/initial_data_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'initial_data_provider.g.dart';

/// Provider for InitialDataService
@riverpod
InitialDataService initialDataService(InitialDataServiceRef ref) {
  final database = ref.watch(databaseProvider);
  final dio = ref.watch(dioProvider);

  return InitialDataService(database, dio);
}
