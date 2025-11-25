import 'package:app_mobile_afms/design_system/components/navigation/stp_app_bar.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_simulation.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/filter_simulation_modal.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/select_simulation_type_modal.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/sort_simulation_modal.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/harvest_simulation_summary.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/providers/mock_simulations_provider.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/shared/simulations_content.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/states/empty_simulations_content.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/states/error_simulations_content.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/states/loading_simulations_content.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// List screen for Harvest Calculator feature.
///
/// Displays a list of saved simulations with search, filter, and sort capabilities.
/// Allows users to create new simulations and view existing ones.
class SimulationListScreen extends ConsumerStatefulWidget {
  /// Creates a new instance of [SimulationListScreen].
  const SimulationListScreen({super.key});

  @override
  ConsumerState<SimulationListScreen> createState() =>
      _SimulationListScreenState();
}

class _SimulationListScreenState extends ConsumerState<SimulationListScreen> {
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

  /// Refreshes the simulations data.
  Future<void> _onRefresh() async {
    // Invalidate the mock data provider to simulate refresh
    ref.invalidate(mockSimulationsDataProvider);
  }

  /// Converts domain entities to presentation models and filters/sorts them.
  List<HarvestSimulationSummary> _filterAndSortSimulations(
    List<HarvestSimulation> simulations,
  ) {
    // Convert domain entities to presentation models
    final summaries = simulations.map((sim) => sim.toSummary()).toList();
    var filtered = summaries;

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
        // Map simulation cycle type to filter options
        // Since HarvestSimulationSummary doesn't have cycleType field,
        // we can match against cultivationSystem or skip filtering for now
        // TODO: Add cycleType to HarvestSimulationSummary when available
        return true; // Skip cycle type filtering for now
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
        final commodity = s.commodity;
        if (commodity.isEmpty) return false;

        return _filterOptions.commodities.any(
          (c) =>
              commodity.contains(c) ||
              (c.contains('Udang') && commodity == 'Udang'),
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
          final aName = a.name;
          final bName = b.name;
          return aName.compareTo(bName);
        case HarvestCalculatorConstants.sortNameZA:
          final aName = a.name;
          final bName = b.name;
          return bName.compareTo(aName);
        default:
          return 0;
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    // Watch the mock simulations data provider for testing
    final savedSimulationsAsync = ref.watch(mockSimulationsDataProvider);

    return Scaffold(
      backgroundColor: HarvestCalculatorDesignConstants.white,
      appBar: STPAppBar(
        title: HarvestCalculatorConstants.titleHarvestCalculator,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => const SelectSimulationTypeModal(),
              );
            },
            tooltip: 'Create new simulation',
          ),
        ],
      ),
      body: SafeArea(
        child: savedSimulationsAsync.when(
          loading: () => const LoadingSimulationsContent(),
          error: (error, stackTrace) => ErrorSimulationsContent(
            error: error.toString(),
            onRetry: _onRefresh,
          ),
          data: (simulations) {
            if (simulations.isEmpty) {
              return const EmptySimulationsContent();
            }

            final filteredSummaries = _filterAndSortSimulations(simulations);

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
