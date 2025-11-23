import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/harvest_simulation_summary.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/cards/simulation_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// List view for displaying simulations.
class SimulationListView extends StatelessWidget {
  /// Creates a new instance of [SimulationListView].
  const SimulationListView({
    required this.simulations, super.key,
  });

  /// List of simulations to display.
  final List<HarvestSimulationSummary> simulations;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: HarvestCalculatorDesignConstants.screenPaddingHorizontal,
          vertical: HarvestCalculatorDesignConstants.spacingMedium,
        ),
        itemBuilder: (context, index) {
          final simulation = simulations[index];
          return SimulationCard(
            summary: simulation,
            currencyFormat: currencyFormat,
          );
        },
        separatorBuilder: (_, __) => const SizedBox(
          height: HarvestCalculatorDesignConstants.spacingMedium,
        ),
        itemCount: simulations.length,
      ),
    );
  }
}
