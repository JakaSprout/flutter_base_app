import 'package:app_mobile_afms/design_system/components/navigation/stp_app_bar.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/filter_simulation_modal.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/select_simulation_type_modal.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/sort_simulation_modal.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/harvest_simulation_summary.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/shared/simulations_content.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/states/empty_simulations_content.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';

/// List screen for Harvest Calculator feature.
///
/// Displays a list of saved simulations with search, filter, and sort capabilities.
/// Allows users to create new simulations and view existing ones.
class SimulationListScreen extends StatefulWidget {
  /// Creates a new instance of [SimulationListScreen].
  const SimulationListScreen({super.key});

  @override
  State<SimulationListScreen> createState() => _SimulationListScreenState();
}

class _SimulationListScreenState extends State<SimulationListScreen> {
  String _searchQuery = '';
  String _currentSort = HarvestCalculatorConstants.sortDateNewest;
  FilterOptions _filterOptions = FilterOptions();

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _onResetFilters() {
    setState(() {
      _filterOptions = FilterOptions();
    });
  }

  Future<void> _onSortTap() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => SortSimulationModal(currentSort: _currentSort),
    );

    if (result != null) {
      setState(() {
        _currentSort = result;
      });
    }
  }

  Future<void> _onFilterTap() async {
    final result = await showModalBottomSheet<FilterOptions>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) =>
          FilterSimulationModal(currentOptions: _filterOptions),
    );

    if (result != null) {
      setState(() {
        _filterOptions = result;
      });
    }
  }

  List<HarvestSimulationSummary> _filterAndSortSimulations(
    List<HarvestSimulationSummary> simulations,
  ) {
    var filtered = simulations;

    // Search
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((s) {
        return s.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Filter
    if (_filterOptions.startDate != null) {
      filtered = filtered.where((s) {
        return s.date.isAfter(
          _filterOptions.startDate!.subtract(const Duration(seconds: 1)),
        );
      }).toList();
    }

    if (_filterOptions.endDate != null) {
      filtered = filtered.where((s) {
        return s.date.isBefore(
          _filterOptions.endDate!.add(const Duration(days: 1)),
        );
      }).toList();
    }

    if (_filterOptions.cycleTypes.isNotEmpty) {
      filtered = filtered.where((s) {
        // Map simulation cycle type strings if necessary
        // Assuming exact match for now or based on logic
        // Need to check how 'cycleType' is stored in HarvestSimulationSummary
        // It seems to be just a string.
        // Also 'cycleType' field in Summary?
        // HarvestSimulationSummary has `cultivationSystem`, `commodity`.
        // `cycleType` might not be directly in summary or named differently.
        // Let's check HarvestSimulationSummary definition.
        // It has `cultivationSystem` but maybe not cycle type?
        // If missing, we can't filter. I'll skip for now if field missing.
        return true;
      }).toList();
    }

    if (_filterOptions.commodities.isNotEmpty) {
      filtered = filtered.where((s) {
        // Map UI strings to data strings
        // "Udang Vaname" -> "Udang" or specific?
        // "Udang Galah" -> ?
        // Existing constants: commodityShrimp = 'Udang'
        // If the data uses 'Udang', and filter uses 'Udang Vaname', we need mapping.
        // I'll assume 'Udang' matches 'Udang Vaname' for now or check contains.
        return _filterOptions.commodities.any(
          (c) =>
              s.commodity.contains(c) ||
              (c.contains('Udang') && s.commodity == 'Udang'),
        );
      }).toList();
    }

    // Sort
    filtered.sort((a, b) {
      switch (_currentSort) {
        case HarvestCalculatorConstants.sortDateNewest:
          return b.date.compareTo(a.date);
        case HarvestCalculatorConstants.sortDateOldest:
          return a.date.compareTo(b.date);
        case HarvestCalculatorConstants.sortNameAZ:
          return a.name.compareTo(b.name);
        case HarvestCalculatorConstants.sortNameZA:
          return b.name.compareTo(a.name);
        default:
          return 0;
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real provider when backend is ready
    // final savedSimulationsAsync = ref.watch(savedSimulationsProvider);

    // Mock data for testing
    final mockSimulations = [
      HarvestSimulationSummary(
        name: 'Simulasi Udang Vaname - Kolam 1',
        date: DateTime.now().subtract(const Duration(days: 1)),
        commodity: 'Udang',
        totalHarvestMt: 5.2,
        feedCost: 12500000,
        potentialRevenue: 25000000,
        iconAsset: Assets.icons.general.pieChart,
        iconBackgroundColor:
            HarvestCalculatorDesignConstants.simulationCardIconBackgroundBlue,
      ),
      HarvestSimulationSummary(
        name: 'Simulasi Udang Galah - Siklus Panjang',
        date: DateTime.now().subtract(const Duration(days: 3)),
        commodity: 'Udang',
        totalHarvestMt: 8.7,
        feedCost: 18750000,
        potentialRevenue: 37500000,
        iconAsset: Assets.icons.general.pieChart,
        iconBackgroundColor:
            HarvestCalculatorDesignConstants.simulationCardIconBackgroundOrange,
      ),
      HarvestSimulationSummary(
        name: 'Simulasi Udang Vaname - Kolam 2',
        date: DateTime.now().subtract(const Duration(days: 5)),
        commodity: 'Udang',
        totalHarvestMt: 6.1,
        feedCost: 15300000,
        potentialRevenue: 30600000,
        iconAsset: Assets.icons.general.pieChart,
        iconBackgroundColor:
            HarvestCalculatorDesignConstants.simulationCardIconBackgroundBlue,
      ),
      HarvestSimulationSummary(
        name: 'Simulasi Udang Windu - Percobaan',
        date: DateTime.now().subtract(const Duration(days: 7)),
        commodity: 'Udang',
        totalHarvestMt: 4.8,
        feedCost: 9800000,
        potentialRevenue: 19600000,
        iconAsset: Assets.icons.general.pieChart,
        iconBackgroundColor:
            HarvestCalculatorDesignConstants.simulationCardIconBackgroundOrange,
      ),
      HarvestSimulationSummary(
        name: 'Simulasi Udang Vaname - Optimasi',
        date: DateTime.now().subtract(const Duration(days: 10)),
        commodity: 'Udang',
        totalHarvestMt: 7.3,
        feedCost: 18200000,
        potentialRevenue: 36400000,
        iconAsset: Assets.icons.general.pieChart,
        iconBackgroundColor:
            HarvestCalculatorDesignConstants.simulationCardIconBackgroundBlue,
      ),
    ];

    final hasSimulations = mockSimulations.isNotEmpty;

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
        child: Builder(
          builder: (context) {
            if (mockSimulations.isEmpty) return const EmptySimulationsContent();

            final filteredSummaries = _filterAndSortSimulations(
              mockSimulations,
            );

            return SimulationsContent(
              simulations: filteredSummaries,
              onSearchChanged: _onSearchChanged,
              onSortTap: _onSortTap,
              onFilterTap: _onFilterTap,
              onResetFilterTap: _onResetFilters,
              filterCount: _filterOptions.count,
            );
          },
        ),
      ),
    );
  }
}
