import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/harvest_simulation_summary.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/buttons/simulation_action_chips.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/simulation_search_field.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/lists/simulation_list_view.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/shared/simulation_count_header.dart';
import 'package:flutter/material.dart';

/// Content widget for displaying simulations with search, filter, and list.
class SimulationsContent extends StatelessWidget {
  /// Creates a new instance of [SimulationsContent].
  const SimulationsContent({
    required this.simulations,
    super.key,
    this.onSearchChanged,
    this.searchController,
    this.onFilterTap,
    this.onResetFilterTap,
    this.onSortTap,
    this.filterCount = 0,
  });

  /// List of simulations to display.
  final List<HarvestSimulationSummary> simulations;

  /// Callback when search text changes.
  final ValueChanged<String>? onSearchChanged;

  /// Controller for search field.
  final TextEditingController? searchController;

  /// Callback when filter is tapped.
  final VoidCallback? onFilterTap;

  /// Callback when reset filter is tapped.
  final VoidCallback? onResetFilterTap;

  /// Callback when sort is tapped.
  final VoidCallback? onSortTap;

  /// Number of active filters.
  final int filterCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SimulationSearchField(
          onChanged: onSearchChanged,
          controller: searchController,
        ),
        SimulationActionChips(
          onFilterTap: onFilterTap,
          onSortTap: onSortTap,
          onResetFilterTap: onResetFilterTap,
          filterCount: filterCount,
        ),
        SimulationCountHeader(count: simulations.length),
        SimulationListView(simulations: simulations),
      ],
    );
  }
}
