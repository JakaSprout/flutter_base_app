import 'package:app_mobile_afms/design_system/components/navigation/stp_app_bar.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/utils/chart_builder.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/cards/chart_stat_card.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/segmented_toggle.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/lists/feed_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

/// Screen for detailed feed expenditure vs revenue analysis.
class FeedVsRevenueDetailScreen extends StatefulWidget {
  /// Creates a new instance of [FeedVsRevenueDetailScreen].
  const FeedVsRevenueDetailScreen({required this.simulation, super.key});

  /// Simulation data.
  final SimulationResultsScreenArgs simulation;

  @override
  State<FeedVsRevenueDetailScreen> createState() =>
      _FeedVsRevenueDetailScreenState();
}

class _FeedVsRevenueDetailScreenState extends State<FeedVsRevenueDetailScreen> {
  /// Whether chart view is selected (true) or table view (false).
  bool _isChartSelected = true;

  /// Whether DOC column is sorted ascending.
  bool _isDocAscending = true;

  FeedChartPoint? get _latestPoint =>
      widget.simulation.feedVsRevenuePoints.isNotEmpty
      ? widget.simulation.feedVsRevenuePoints.last
      : null;

  /// Get sorted table rows based on DOC column.
  List<SimulationTableRowData> get _sortedTableRows {
    final tableRows =
        List<SimulationTableRowData>.from(widget.simulation.tableRows)..sort(
          (a, b) =>
              _isDocAscending ? a.doc.compareTo(b.doc) : b.doc.compareTo(a.doc),
        );
    return tableRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HarvestCalculatorDesignConstants.white,
      appBar: const STPAppBar(title: 'Pengeluaran vs Pendapatan'),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(
            top: HarvestCalculatorDesignConstants.screenPaddingVertical,
            left: HarvestCalculatorDesignConstants.screenPaddingVertical,
            right: HarvestCalculatorDesignConstants.screenPaddingVertical,
            bottom:
                HarvestCalculatorDesignConstants.screenPaddingVertical +
                MediaQuery.of(context).viewInsets.bottom +
                120, // Extra padding for keyboard + safe area
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SegmentedToggle(
                isChartSelected: _isChartSelected,
                onChanged: (value) {
                  setState(() {
                    _isChartSelected = value;
                  });
                },
              ),
              const SizedBox(
                height: HarvestCalculatorDesignConstants.spacingMedium,
              ),
              if (_isChartSelected) ...[
                SizedBox(
                  height: HarvestCalculatorDesignConstants.chartHeight,
                  child: Echarts(
                    option: ChartBuilder.buildFeedChartOption(
                      widget.simulation.feedVsRevenuePoints,
                    ),
                    reloadAfterInit: true,
                  ),
                ),
                const SizedBox(
                  height: HarvestCalculatorDesignConstants.spacingMedium,
                ),
                ChartStatCard(
                  doc: _latestPoint?.doc ?? 0,
                  stats: [
                    ChartStatValue(
                      label: 'Potensi Pendapatan',
                      value: '',
                      color: HarvestCalculatorDesignConstants.blueAccent,
                    ),
                    ChartStatValue(
                      label: 'Pengeluaran Pakan Kumulatif',
                      value: '',
                      color: HarvestCalculatorDesignConstants.warningColor,
                    ),
                  ],
                ),
              ] else ...[
                // Table takes remaining space with calculated height
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height -
                      HarvestCalculatorDesignConstants.screenPaddingVertical *
                          2 -
                      kToolbarHeight - // App bar height
                      MediaQuery.of(context).padding.top - // Status bar
                      120, // Segmented toggle + spacing + bottom padding
                  child: FeedTable(
                    rows: _sortedTableRows,
                    isAscending: _isDocAscending,
                    onSort: () {
                      setState(() {
                        _isDocAscending = !_isDocAscending;
                      });
                    },
                    showExtendedColumns:
                        true, // Show extended columns in detail screen
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
