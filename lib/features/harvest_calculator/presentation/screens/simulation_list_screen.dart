import 'package:app_mobile_afms/design_system/components/navigation/stp_app_bar.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/select_simulation_type_modal.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/harvest_simulation_summary.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/providers/saved_simulations_provider.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/shared/simulations_content.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/states/empty_simulations_content.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// List screen for Harvest Calculator feature.
///
/// Displays a list of saved simulations with search, filter, and sort capabilities.
/// Allows users to create new simulations and view existing ones.
class SimulationListScreen extends ConsumerWidget {
  /// Creates a new instance of [SimulationListScreen].
  const SimulationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedSimulationsAsync = ref.watch(savedSimulationsProvider);
    final hasSimulations = savedSimulationsAsync.maybeWhen(
      data: (simulations) => simulations.isNotEmpty,
      orElse: () => false,
    );

    return Scaffold(
      backgroundColor: HarvestCalculatorDesignConstants.white,
      appBar: STPAppBar(
        title: HarvestCalculatorConstants.titleHarvestCalculator,
        actions: hasSimulations
            ? [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const SelectSimulationTypeModal(),
                    );
                  },
                ),
              ]
            : null,
      ),
      body: SafeArea(
        child: savedSimulationsAsync.when(
          data: (simulations) => simulations.isNotEmpty
              ? SimulationsContent(
                  simulations: simulations.map((s) => s.toSummary()).toList(),
                )
              : const EmptySimulationsContent(),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) =>
              Center(child: Text('Error loading simulations: $error')),
        ),
      ),
    );
  }
}
