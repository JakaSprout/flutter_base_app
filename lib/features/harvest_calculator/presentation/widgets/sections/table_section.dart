import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/buttons/see_more_button.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/lists/feed_table.dart';

/// Section containing data table and see more button.
class TableSection extends StatelessWidget {
  /// Creates a new instance of [TableSection].
  const TableSection({
    super.key,
    required this.sortedTableRows,
    required this.isDocAscending,
    required this.onSort,
  });

  /// Sorted table rows data.
  final List<SimulationTableRowData> sortedTableRows;

  /// Whether DOC is sorted ascending.
  final bool isDocAscending;

  /// Callback when sort button is pressed.
  final VoidCallback onSort;

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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Lihat selengkapnya (coming soon).'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
