import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:intl/intl.dart';

/// Summary card widget displaying simulation metadata.
class SummaryCard extends StatelessWidget {
  /// Creates a new instance of [SummaryCard].
  const SummaryCard({
    required this.simulation,
    required this.dateFormatter,
    super.key,
  });

  /// Simulation data.
  final SimulationResultsScreenArgs simulation;

  /// Date formatter for displaying creation date.
  final DateFormat dateFormatter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
      decoration: BoxDecoration(
        color: HarvestCalculatorDesignConstants.lightBackgroundGrayAlt,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateFormatter.format(simulation.createdAt),
                style: HarvestCalculatorDesignConstants.smallTextSecondaryStyle.copyWith(
                  height: 18 / 12,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                simulation.simulationName,
                style: HarvestCalculatorDesignConstants.bodyTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 20 / 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${simulation.commodity} • ${simulation.cultivationSystem}',
                style: HarvestCalculatorDesignConstants.smallTextSecondaryStyle.copyWith(
                  height: 18 / 12,
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: const BoxDecoration(
                color: HarvestCalculatorDesignConstants.blueBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(200),
                  bottomLeft: Radius.circular(200),
                ),
              ),
              child: Text(
                'DOC: ${simulation.doc}D',
                textAlign: TextAlign.center,
                style: HarvestCalculatorDesignConstants.smallTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 18 / 12,
                  color: HarvestCalculatorDesignConstants.primaryBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


