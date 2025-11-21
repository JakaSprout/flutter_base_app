import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/components/navigation/stp_app_bar.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/modals/download_simulation_modal.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/buttons/action_buttons.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/cards/summary_card.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/sections/agent_metrics_section.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/sections/charts_section.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/sections/loan_analysis_section.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/sections/ltv_risk_section.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/sections/metrics_section.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/sections/table_section.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/shared/preview_status_banner.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/shared/profit_banner.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';
import 'package:flutter_base_app/router/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Screen displaying simulation results with charts and data table.
///
/// Shows:
/// - Summary card with ADG and DOC
/// - Biomass and Partial Harvest chart
/// - Feed Expenditure vs Revenue chart
/// - Detailed data table
/// - Save button
class SimulationResultsScreen extends StatefulWidget {
  /// Creates a new instance of [SimulationResultsScreen].
  const SimulationResultsScreen({super.key, this.args});

  /// Arguments passed from previous screen.
  final SimulationResultsScreenArgs? args;

  @override
  State<SimulationResultsScreen> createState() =>
      _SimulationResultsScreenState();
}

class _SimulationResultsScreenState extends State<SimulationResultsScreen> {
  bool _isFeedChartSelected = true;
  bool _isDocAscending = true;

  SimulationResultsScreenArgs get simulation =>
      widget.args ?? SimulationResultsScreenArgs.preview();

  SimulationTableRowData? get _latestRow =>
      simulation.tableRows.isNotEmpty ? simulation.tableRows.last : null;

  FeedChartPoint? get _latestFeedPoint =>
      simulation.feedVsRevenuePoints.isNotEmpty
      ? simulation.feedVsRevenuePoints.last
      : null;

  BiomassChartPoint? get _latestBiomassPoint =>
      simulation.biomassPoints.isNotEmpty
      ? simulation.biomassPoints.last
      : null;

  List<SimulationTableRowData> get _sortedTableRows {
    final tableRows = List<SimulationTableRowData>.from(simulation.tableRows);
    tableRows.sort(
      (a, b) =>
          _isDocAscending ? a.doc.compareTo(b.doc) : b.doc.compareTo(a.doc),
    );
    return tableRows;
  }

  double get _potentialRevenue => _latestRow?.revenue ?? 0;

  double get _potentialFeedCost => _latestRow?.feedCost ?? 0;

  double get _potentialProfit => (_latestRow?.profit != 0)
      ? (_latestRow?.profit ?? (_potentialRevenue - _potentialFeedCost))
      : (_potentialRevenue - _potentialFeedCost);

  double get _biomassKg => _latestRow?.biomass ?? 0;

  double get _feedKg =>
      _latestFeedPoint?.feed ?? _latestRow?.feedCost ?? 0; // placeholder

  bool get _isAgentMode =>
      simulation.simulationType ==
      HarvestCalculatorConstants.simulationTypeAgent;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd MMM yyyy');
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final weightFormat = NumberFormat('0.0');
    final adgFormat = NumberFormat('0.00', 'id_ID');

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: STPAppBar(
        title: HarvestCalculatorConstants.titlePreview,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: SvgPicture.asset(
                Assets.icons.general.arrowDownload,
                width: 24,
                height: 24,
                color: AppColors.gray70,
              ),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => DownloadSimulationModal(
                    simulationName: simulation.simulationName,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: HarvestCalculatorDesignConstants.screenPaddingVertical,
                  bottom:
                      HarvestCalculatorDesignConstants.screenPaddingVertical,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (simulation.isPreview) ...[
                      const PreviewStatusBanner(),
                      const SizedBox(
                        height: HarvestCalculatorDesignConstants.spacingMedium,
                      ),
                    ],
                    // Different sections for Agent vs Cycle mode
                    if (_isAgentMode) ...[
                      // Agent Mode Sections
                      // Summary Card with DOC
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SectionFieldPadding.horizontal,
                        ),
                        child: SummaryCard(
                          simulation: simulation,
                          dateFormatter: dateFormatter,
                        ),
                      ),
                      const SizedBox(
                        height: HarvestCalculatorDesignConstants.spacingMedium,
                      ),
                      const Divider(
                        height: HarvestCalculatorDesignConstants.spacingXSmall,
                        thickness:
                            HarvestCalculatorDesignConstants.spacingXSmall,
                        color: HarvestCalculatorDesignConstants.dividerColor,
                      ),
                      const SizedBox(
                        height: HarvestCalculatorDesignConstants.spacingMedium,
                      ),
                      // Resiko Pinjaman (LTV) Section
                      if (simulation.ltvPercentage != null)
                        LTVRiskSection(
                          ltvPercentage: simulation.ltvPercentage!,
                        ),
                      const SizedBox(
                        height: HarvestCalculatorDesignConstants.spacingMedium,
                      ),
                      // Hasil Simulasi Section
                      AgentMetricsSection(
                        simulation: simulation,
                        dateFormatter: dateFormatter,
                        currencyFormat: currencyFormat,
                        weightFormat: weightFormat,
                      ),
                      const SizedBox(
                        height: HarvestCalculatorDesignConstants.spacingMedium,
                      ),
                      LoanAnalysisSection(
                        simulation: simulation,
                        currencyFormat: currencyFormat,
                      ),
                    ] else ...[
                      // Cycle Mode Sections
                      MetricsSection(
                        simulation: simulation,
                        potentialRevenue: _potentialRevenue,
                        potentialFeedCost: _potentialFeedCost,
                        biomassKg: _biomassKg,
                        feedKg: _feedKg,
                        dateFormatter: dateFormatter,
                        currencyFormat: currencyFormat,
                        weightFormat: weightFormat,
                      ),
                      const SizedBox(
                        height: HarvestCalculatorDesignConstants.spacingMedium,
                      ),
                      ProfitBanner(
                        potentialProfit: _potentialProfit,
                        adg: simulation.adg,
                        currencyFormat: currencyFormat,
                        adgFormat: adgFormat,
                      ),
                      const SizedBox(
                        height: HarvestCalculatorDesignConstants.spacingMedium,
                      ),
                      const Divider(
                        height: HarvestCalculatorDesignConstants.spacingXSmall,
                        thickness:
                            HarvestCalculatorDesignConstants.spacingXSmall,
                        color: HarvestCalculatorDesignConstants.dividerColor,
                      ),
                      const SizedBox(
                        height: HarvestCalculatorDesignConstants.spacingMedium,
                      ),
                      ChartsSection(
                        simulation: simulation,
                        latestBiomassPoint: _latestBiomassPoint,
                        isFeedChartSelected: _isFeedChartSelected,
                        onFeedToggle: (isChart) {
                          setState(() {
                            _isFeedChartSelected = isChart;
                          });
                        },
                      ),
                      if (!_isFeedChartSelected) ...[
                        TableSection(
                          sortedTableRows: _sortedTableRows,
                          isDocAscending: _isDocAscending,
                          onSort: () {
                            setState(() {
                              _isDocAscending = !_isDocAscending;
                            });
                          },
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
            ActionButtons(
              onCancel: () => Navigator.pop(context),
              onSave: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Simulasi berhasil disimpan (mock).'),
                  ),
                );
                context.push(Routes.harvestCalculatorSaved);
              },
            ),
          ],
        ),
      ),
    );
  }
}
