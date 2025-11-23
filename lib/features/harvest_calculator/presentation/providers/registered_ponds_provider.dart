import 'package:app_mobile_afms/core/reference_data/providers/reference_data_providers.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/pond_option.dart';
import 'package:app_mobile_afms/features/home/presentation/providers/home_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'registered_ponds_provider.g.dart';

/// Loads pond options from the reference data repository for the active user.
/// Optionally filters by selected farm ID from home screen.
@riverpod
Future<List<PondOption>> registeredPondOptions(Ref ref) async {
  final authService = ref.watch(authServiceProvider);
  final employeeId = await authService.getStoredEmployeeId();
  if (employeeId == null || employeeId.isEmpty) {
    throw StateError(
      'Employee ID tidak tersedia. Login ulang untuk menyegarkan sesi.',
    );
  }

  // Get selected farm ID from home screen (if available)
  int? selectedFarmId;
  try {
    final companyListData = await ref.watch(companyListDataProvider.future);
    selectedFarmId = companyListData.selectedFarmId;
  } catch (_) {
    // If home provider is not available, continue without filtering
  }

  final repository = ref.watch(referenceDataRepositoryProvider);
  final ponds = await repository.getPonds(employeeId);

  if (ponds.isEmpty) return const [];

  // Filter ponds by selected farm ID if available
  final filteredPonds = selectedFarmId != null
      ? ponds.where((pond) => pond.farmId == selectedFarmId).toList()
      : ponds;

  final options = filteredPonds
      .map(
        (pond) => PondOption(
          id: pond.id.toString(),
          name: pond.name,
          code: pond.code,
          farmId: pond.farmId?.toString(),
          areaSqm: pond.areaSqm,
          status: pond.status,
        ),
      )
      .toList()
    ..sort((a, b) => a.name.compareTo(b.name));

  return options;
}
