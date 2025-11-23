import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

/// Section displaying agent-specific metrics.
class AgentMetricsSection extends StatelessWidget {
  /// Creates a new instance of [AgentMetricsSection].
  const AgentMetricsSection({
    required this.simulation,
    required this.dateFormatter,
    required this.currencyFormat,
    required this.weightFormat,
    super.key,
  });

  /// Simulation data.
  final SimulationResultsScreenArgs simulation;

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section title without dot indicator
          Text(
            HarvestCalculatorConstants.titleSimulationResults,
            style: HarvestCalculatorDesignConstants.sectionTitleTextStyle
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          // Content with border
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: HarvestCalculatorDesignConstants.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: HarvestCalculatorDesignConstants.gray20,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Metrics list
                _MetricRow(
                  label: HarvestCalculatorConstants
                      .metricHarvestGuaranteePotential,
                  value: currencyFormat.format(
                    simulation.harvestGuaranteePotential ?? 0,
                  ),
                ),
                const SizedBox(height: 12),
                _MetricRow(
                  label: HarvestCalculatorConstants.metricCultivationProgress,
                  value:
                      '${(simulation.cultivationProgress ?? 0).toStringAsFixed(0)}%',
                ),
                const SizedBox(height: 12),
                _MetricRow(
                  label: HarvestCalculatorConstants.metricCurrentABW,
                  value: '${weightFormat.format(simulation.currentABW ?? 0)}g',
                ),
                const SizedBox(height: 12),
                _MetricRow(
                  label: HarvestCalculatorConstants.metricHarvestABW,
                  value: '${weightFormat.format(simulation.harvestABW ?? 0)}g',
                ),
                const SizedBox(height: 12),
                _MetricRow(
                  label: HarvestCalculatorConstants.metricFeedNeeds,
                  value: '${weightFormat.format(simulation.feedNeeds ?? 0)}kg',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: HarvestCalculatorDesignConstants.spacingMedium,
          ),
          // Feed needs card (outside border)
          _InfoCard(
            icon: Assets.icons.general.moneyBag,
            title: HarvestCalculatorConstants.metricFeedNeedsUntilHarvest,
            value: currencyFormat.format(simulation.feedNeedsUntilHarvest ?? 0),
          ),
          const SizedBox(height: HarvestCalculatorDesignConstants.spacingSmall),
          // Max loan ceiling card (outside border)
          _InfoCard(
            icon: Assets.icons.general.paymentPositive,
            title: HarvestCalculatorConstants.metricMaxLoanCeiling,
            value: currencyFormat.format(simulation.maxLoanCeiling ?? 0),
          ),
        ],
      ),
    );
  }
}

/// Metric row widget.
class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: HarvestCalculatorDesignConstants.textPrimary,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: HarvestCalculatorDesignConstants.textPrimary,
          ),
        ),
      ],
    );
  }
}

/// Info card widget.
class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final String icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HarvestCalculatorDesignConstants.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HarvestCalculatorDesignConstants.gray20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with small icon next to it
          Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 16,
                height: 16,
                // No color filter - use original colors
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: HarvestCalculatorDesignConstants.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: HarvestCalculatorDesignConstants.success,
            ),
          ),
        ],
      ),
    );
  }
}
