import 'package:app_mobile_afms/design_system/components/navigation/stp_app_bar.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_parameters.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/usecases/run_simulation_usecase.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/download_simulation_modal.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/partial_harvest_modal.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/buttons/action_buttons.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/cards/summary_card.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/agent_metrics_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/charts_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/loan_analysis_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/ltv_risk_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/metrics_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/table_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/shared/preview_status_banner.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/shared/profit_banner.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
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

  // Store current simulation args (will be updated when harvest events change)
  late SimulationResultsScreenArgs _currentSimulation;
  late List<HarvestEvent> _customHarvestEvents = [];

  @override
  void initState() {
    super.initState();
    _currentSimulation = widget.args ?? SimulationResultsScreenArgs.preview();
    // Inisialisasi customHarvestEvents dari parameters jika ada, atau kosong
    if (_currentSimulation.parameters != null &&
        _currentSimulation.parameters!.harvestEvents.isNotEmpty) {
      _customHarvestEvents = List.from(
        _currentSimulation.parameters!.harvestEvents,
      );
    } else {
      _customHarvestEvents = [];
    }
    debugPrint('🎯 [SimulationResultsScreen] initState - Initial simulation:');
    debugPrint(
      '   - Harvest summaries: ${_currentSimulation.simulationResult?.harvestSummaries.length}',
    );
    debugPrint(
      '   - Biomass points: ${_currentSimulation.biomassPoints.length}',
    );
    debugPrint('   - Table rows: ${_currentSimulation.tableRows.length}');
  }

  SimulationResultsScreenArgs get simulation => _currentSimulation;

  SimulationTableRowData? get _latestRow =>
      simulation.tableRows.isNotEmpty ? simulation.tableRows.last : null;

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

  double get _potentialRevenue {
    // For cycle mode: use total harvest value from harvest summaries
    // For agent mode: use legacy calculation
    if (simulation.simulationType == 'cycle') {
      return simulation.simulationResult?.harvestSummaries.fold<double>(
            0,
            (sum, harvest) => sum + (harvest.harvestValueRp ?? 0),
          ) ??
          0;
    } else {
      // Legacy calculation for agent mode
      final totalHarvestKg =
          simulation.simulationResult?.harvestSummaries.fold<double>(
            0,
            (sum, harvest) => sum + harvest.weight,
          ) ??
          0;
      final sellingPrice = simulation.parameters?.sellingPricePerKg ?? 0;
      return totalHarvestKg * sellingPrice;
    }
  }

  double get _potentialFeedCost {
    // For cycle mode: use total feed consumption cost from harvest summaries
    // For agent mode: use cumulative feed cost from the last day
    if (simulation.simulationType == 'cycle') {
      return simulation.simulationResult?.harvestSummaries.fold<double>(
            0,
            (sum, harvest) => sum + (harvest.feedConsumptionRp ?? 0),
          ) ??
          0;
    } else {
      // Legacy calculation for agent mode
      return _latestRow?.feedCost ?? 0;
    }
  }

  double get _potentialProfit => _potentialRevenue - _potentialFeedCost;

  double get _biomassKg {
    // For cycle mode: use total harvest kg from harvest summaries
    // For agent mode: use legacy calculation
    if (simulation.simulationType == 'cycle') {
      return simulation.simulationResult?.harvestSummaries.fold<double>(
            0,
            (sum, harvest) => sum + (harvest.harvestKg ?? 0),
          ) ??
          0;
    } else {
      // Legacy calculation for agent mode
      return simulation.simulationResult?.harvestSummaries.fold<double>(
            0,
            (sum, harvest) => sum + harvest.weight,
          ) ??
          0;
    }
  }

  double get _feedKg {
    // For cycle mode: use total feed consumption kg from harvest summaries
    // For agent mode: use cumulative feed consumption from the last day
    if (simulation.simulationType == 'cycle') {
      return simulation.simulationResult?.harvestSummaries.fold<double>(
            0,
            (sum, harvest) => sum + (harvest.feedConsumptionKg ?? 0),
          ) ??
          0;
    } else {
      // Legacy calculation for agent mode
      return _latestRow?.cumulativeFeedConsumption ?? 0;
    }
  }

  bool get _isAgentMode =>
      simulation.simulationType ==
      HarvestCalculatorConstants.simulationTypeAgent;

  /// Re-runs simulation with updated harvest events
  Future<void> _rerunSimulationWithCustomHarvests(
    List<HarvestEvent> customHarvestEvents, {
    int? targetDOCOverride,
  }) async {
    debugPrint(
      '🔄 [SimulationResultsScreen] Re-running simulation with ${customHarvestEvents.length} custom events',
    );

    // Only re-run if we have parameters (preview mode)
    if (simulation.parameters == null) {
      debugPrint('❌ [SimulationResultsScreen] No parameters available');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Tidak dapat menjalankan ulang simulasi: Data parameters tidak tersedia',
          ),
          backgroundColor: HarvestCalculatorDesignConstants.errorColor,
        ),
      );
      return;
    }

    debugPrint('📋 [SimulationResultsScreen] Current parameters:');
    debugPrint('   - targetDOC: ${simulation.parameters!.targetDOC}');
    debugPrint('   - pondArea: ${simulation.parameters!.pondArea}');
    debugPrint(
      '   - Current harvest events: ${simulation.parameters!.harvestEvents.length}',
    );

    // Show loading indicator
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Memperbarui simulasi...'),
          duration: Duration(seconds: 1),
        ),
      );
    }

    // Create new parameters with custom harvest events
    var updatedParameters = simulation.parameters!.copyWith(
      harvestEvents: customHarvestEvents,
    );
    if (targetDOCOverride != null &&
        targetDOCOverride > 0 &&
        targetDOCOverride != updatedParameters.targetDOC) {
      updatedParameters = updatedParameters.copyWith(
        targetDOC: targetDOCOverride,
      );
      debugPrint('⚡ Overriding targetDOC to $targetDOCOverride');
    }

    debugPrint(
      '🔄 [SimulationResultsScreen] Updated parameters with ${updatedParameters.harvestEvents.length} events',
    );

    // Run simulation
    const useCase = RunSimulationUseCase();
    final result = await useCase.execute(updatedParameters);

    result.fold(
      (failure) {
        // Show error
        debugPrint(
          '❌ [SimulationResultsScreen] Simulation failed: ${failure.message}',
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Gagal menjalankan ulang simulasi: ${failure.message}',
              ),
              backgroundColor: HarvestCalculatorDesignConstants.errorColor,
            ),
          );
        }
      },
      (simulationResult) {
        // Update state with new simulation result
        debugPrint('✅ [SimulationResultsScreen] Simulation success!');
        debugPrint(
          '   - Daily results: ${simulationResult.dailyResults.length}',
        );
        debugPrint(
          '   - Harvest summaries: ${simulationResult.harvestSummaries.length}',
        );

        if (mounted) {
          setState(() {
            _currentSimulation =
                SimulationResultsScreenArgs.fromSimulationResult(
                  simulationResult,
                  updatedParameters,
                  simulationName: simulation.simulationName,
                  commodity: simulation.commodity,
                  cultivationSystem: simulation.cultivationSystem,
                  simulationType: simulation.simulationType,
                  createdAt: simulation.createdAt,
                  isPreview: simulation.isPreview, // Preserve preview status
                );
          });

          debugPrint(
            '🎨 [SimulationResultsScreen] State updated, UI will rebuild',
          );

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Simulasi berhasil diperbarui!'),
              backgroundColor: HarvestCalculatorDesignConstants.successColor,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
    );
  }

  /// Opens partial harvest modal and handles result
  Future<void> _openPartialHarvestModal() async {
    debugPrint('🎯 [SimulationResultsScreen] Opening partial harvest modal');

    // Buka modal dan dapatkan result + targetDOC baru
    final result = await showModalBottomSheet<Map<String, dynamic>?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PartialHarvestModal(
        automaticHarvestDoc: simulation.automaticHarvestDoc,
        harvestSummaries: simulation.simulationResult?.harvestSummaries,
        targetDOC: simulation.doc,
        initialCustomHarvestEvents: _customHarvestEvents,
      ),
    );

    // Map result
    final harvestEvents = result?['harvestEvents'] as List<HarvestEvent>?;
    final newTargetDoc = result?['targetDOC'] as int?;
    debugPrint(
      '🎯 [SimulationResultsScreen] Modal result: ${harvestEvents?.length} events, new targetDOC: $newTargetDoc',
    );
    if (harvestEvents != null) {
      debugPrint(
        '🔄 [SimulationResultsScreen] Re-running simulation with custom events',
      );
      _customHarvestEvents = List.from(harvestEvents);
      await _rerunSimulationWithCustomHarvests(
        harvestEvents,
        targetDOCOverride: newTargetDoc,
      );
    } else {
      debugPrint('❌ [SimulationResultsScreen] Modal dismissed without changes');
    }
  }

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
      backgroundColor: HarvestCalculatorDesignConstants.white,
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
                color: HarvestCalculatorDesignConstants.gray70,
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
                      // Hasil Simulasi Section (Agent mode only)
                      if (simulation.simulationType == 'agent')
                        AgentMetricsSection(
                          simulation: simulation,
                          dateFormatter: dateFormatter,
                          currencyFormat: currencyFormat,
                          weightFormat: weightFormat,
                        ),
                      if (simulation.simulationType == 'agent')
                        const SizedBox(
                          height:
                              HarvestCalculatorDesignConstants.spacingMedium,
                        ),
                      LoanAnalysisSection(
                        simulation: simulation,
                        currencyFormat: currencyFormat,
                      ),
                    ] else ...[
                      // Cycle Mode Sections
                      MetricsSection(
                        key: ValueKey(
                          'metrics_${simulation.simulationResult?.harvestSummaries.length}_${_potentialRevenue}_$_potentialFeedCost',
                        ),
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
                        key: ValueKey(
                          'profit_${_potentialProfit}_${simulation.adg}',
                        ),
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
                        key: ValueKey(
                          'charts_${simulation.biomassPoints.length}_${simulation.feedVsRevenuePoints.length}',
                        ),
                        simulation: simulation,
                        latestBiomassPoint: _latestBiomassPoint,
                        isFeedChartSelected: _isFeedChartSelected,
                        onFeedToggle: (isChart) {
                          setState(() {
                            _isFeedChartSelected = isChart;
                          });
                        },
                        onPartialHarvestAdjust: _openPartialHarvestModal,
                      ),
                      // Show table only when table is selected in feed chart toggle
                      if (!_isFeedChartSelected)
                        TableSection(
                          key: ValueKey(
                            'table_${simulation.tableRows.length}_$_isDocAscending',
                          ),
                          sortedTableRows: _sortedTableRows,
                          isDocAscending: _isDocAscending,
                          onSort: () {
                            setState(() {
                              _isDocAscending = !_isDocAscending;
                            });
                          },
                          simulation: simulation,
                        ),
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
                // Pop back to simulation list without deleting home history
                // Using Go Router extension for clean navigation
                context.pop(); // Remove preview
                context.pop(); // Remove create
                // Now we're back at the original simulation list with home history preserved
              },
            ),
          ],
        ),
      ),
    );
  }
}
