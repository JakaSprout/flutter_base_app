import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/utils/chart_builder.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/cards/chart_stat_card.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/segmented_toggle.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:intl/intl.dart';

/// Section widget for feed expenditure vs revenue chart and table.
class FeedSection extends StatelessWidget {
  /// Creates a new instance of [FeedSection].
  const FeedSection({
    required this.simulation,
    required this.isChartSelected,
    required this.onToggle,
    super.key,
  });

  /// Simulation data.
  final SimulationResultsScreenArgs simulation;

  /// Whether chart view is selected.
  final bool isChartSelected;

  /// Callback when toggle changes.
  final ValueChanged<bool> onToggle;

  FeedChartPoint? get _latestPoint =>
      simulation.feedVsRevenuePoints.isNotEmpty
          ? simulation.feedVsRevenuePoints.last
          : null;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return SectionFieldPadding.wrapSection(
      child: FormSection(
        title: HarvestCalculatorConstants.chartFeedExpenditureVsRevenue,
        children: [
          SectionFieldPadding.wrap(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SegmentedToggle(
                  isChartSelected: isChartSelected,
                  onChanged: onToggle,
                ),
                const SizedBox(
                  height: HarvestCalculatorDesignConstants.spacingMedium,
                ),
                if (isChartSelected)
                  SizedBox(
                    height: HarvestCalculatorDesignConstants.chartHeight,
                    child: Echarts(
                      option: ChartBuilder.buildFeedChartOption(
                        simulation.feedVsRevenuePoints,
                      ),
                      reloadAfterInit: true,
                    ),
                  ),
                if (isChartSelected)
                  const SizedBox(
                    height: HarvestCalculatorDesignConstants.spacingMedium,
                  ),
                if (isChartSelected)
                  ChartStatCard(
                    doc: _latestPoint?.doc ?? 0,
                    stats: [
                      ChartStatValue(
                        label: 'Potensi Pendapatan',
                        value: currencyFormat.format(
                          _latestPoint?.revenue ?? 0,
                        ),
                        color: HarvestCalculatorDesignConstants.blueAccent,
                      ),
                      ChartStatValue(
                        label: 'Pengeluaran Pakan Kumulatif',
                        value: currencyFormat.format(_latestPoint?.feed ?? 0),
                        color: HarvestCalculatorDesignConstants.warningColor,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


