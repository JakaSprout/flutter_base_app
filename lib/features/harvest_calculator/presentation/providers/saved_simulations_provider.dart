import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_simulation.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/providers/harvest_simulation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_simulations_provider.g.dart';

/// State provider for managing saved harvest simulations.
@riverpod
class SavedSimulations extends _$SavedSimulations {
  @override
  FutureOr<List<HarvestSimulation>> build() async {
    final useCase = ref.watch(getSavedSimulationsUseCaseProvider);
    final result = await useCase();

    return result.fold((failure) {
      // Throw exception to trigger AsyncError state in Riverpod
      // This allows UI to properly handle and display error states
      throw Exception('Failed to load saved simulations: ${failure.message}');
    }, (simulations) => simulations);
  }

  /// Refreshes the saved simulations list.
  Future<void> refresh() async {
    ref.invalidateSelf();
  }

  /// Adds a new simulation to the saved list.
  ///
  /// Throws an exception if the save operation fails, allowing
  /// callers to handle the error appropriately (e.g., show snackbar).
  Future<void> addSimulation(HarvestSimulation simulation) async {
    final useCase = ref.read(saveSimulationUseCaseProvider);
    final result = await useCase(simulation);

    result.fold(
      (failure) {
        // Throw exception to allow proper error handling by callers
        throw Exception('Failed to save simulation: ${failure.message}');
      },
      (savedSimulation) {
        // Refresh the list to include the new simulation
        ref.invalidateSelf();
      },
    );
  }
}
