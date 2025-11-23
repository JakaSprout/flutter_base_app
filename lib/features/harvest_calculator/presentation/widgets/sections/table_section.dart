import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/screens/feed_vs_revenue_detail_screen.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/buttons/see_more_button.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/lists/feed_table.dart';
import 'package:flutter/material.dart';

/// Section containing data table and see more button.
class TableSection extends StatelessWidget {
  /// Creates a new instance of [TableSection].
  const TableSection({
    required this.sortedTableRows,
    required this.isDocAscending,
    required this.onSort,
    required this.simulation,
    super.key,
  });

  /// Sorted table rows data.
  final List<SimulationTableRowData> sortedTableRows;

  /// Whether DOC is sorted ascending.
  final bool isDocAscending;

  /// Callback when sort button is pressed.
  final VoidCallback onSort;

  /// Simulation data for navigation.
  final SimulationResultsScreenArgs simulation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SectionFieldPadding.horizontal,
          ),
          child: FeedTable(
            rows: sortedTableRows,
            isAscending: isDocAscending,
            onSort: onSort,
            showExtendedColumns: false, // Don't show extended columns in preview
          ),
        ),
        const SizedBox(
          height: HarvestCalculatorDesignConstants.spacingMedium,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SectionFieldPadding.horizontal,
          ),
          child: SeeMoreButton(
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => FeedVsRevenueDetailScreen(
                    simulation: simulation,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
