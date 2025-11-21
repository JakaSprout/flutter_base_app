import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/cards/metric_tile.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/cards/summary_card.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';
import 'package:intl/intl.dart';

/// Section displaying simulation metrics including summary and performance tiles.
class MetricsSection extends StatelessWidget {
  /// Creates a new instance of [MetricsSection].
  const MetricsSection({
    super.key,
    required this.simulation,
    required this.potentialRevenue,
    required this.potentialFeedCost,
    required this.biomassKg,
    required this.feedKg,
    required this.dateFormatter,
    required this.currencyFormat,
    required this.weightFormat,
  });

  /// Simulation data.
  final SimulationResultsScreenArgs simulation;

  /// Potential revenue value.
  final double potentialRevenue;

  /// Potential feed cost value.
  final double potentialFeedCost;

  /// Biomass weight in kg.
  final double biomassKg;

  /// Feed weight in kg.
  final double feedKg;

  /// Date formatter.
  final DateFormat dateFormatter;

  /// Currency formatter.
  final NumberFormat currencyFormat;

  /// Weight formatter.
  final NumberFormat weightFormat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SectionFieldPadding.horizontal,
      ),
      child: Column(
        children: [
          SummaryCard(
            simulation: simulation,
            dateFormatter: dateFormatter,
          ),
          const SizedBox(
            height: HarvestCalculatorDesignConstants.spacingSmall,
          ),
          MetricTile(
            title: HarvestCalculatorConstants.metricPotentialRevenue,
            value: currencyFormat.format(potentialRevenue),
            subtitle: 'Biomassa: ${weightFormat.format(biomassKg)} kg',
            indicatorColor: AppColors.success,
            iconAsset: Assets.icons.general.paymentPositive,
          ),
          const SizedBox(
            height: HarvestCalculatorDesignConstants.spacingSmall,
          ),
          MetricTile(
            title: HarvestCalculatorConstants.metricPotentialExpenditure,
            value: currencyFormat.format(potentialFeedCost),
            subtitle: 'Pakan: ${weightFormat.format(feedKg)} kg',
            indicatorColor: AppColors.error,
            iconAsset: Assets.icons.general.paymentNegative,
          ),
        ],
      ),
    );
  }
}
