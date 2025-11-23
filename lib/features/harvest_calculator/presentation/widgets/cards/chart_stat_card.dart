import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter/material.dart';

/// Chart statistics card displaying DOC and related metrics.
class ChartStatCard extends StatelessWidget {
  /// Creates a new instance of [ChartStatCard].
  const ChartStatCard({required this.doc, required this.stats, super.key});

  /// Day of culture value.
  final int doc;

  /// List of statistics to display.
  final List<ChartStatValue> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: HarvestCalculatorDesignConstants.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: HarvestCalculatorDesignConstants.gray20,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...stats.asMap().entries.map((entry) {
            final index = entry.key;
            final stat = entry.value;
            final isLast = index == stats.length - 1;
            return ChartStatItem(stat: stat, isLast: isLast);
          }),
        ],
      ),
    );
  }
}

/// Individual chart statistic item.
class ChartStatItem extends StatelessWidget {
  /// Creates a new instance of [ChartStatItem].
  const ChartStatItem({required this.stat, this.isLast = false, super.key});

  /// Statistic data.
  final ChartStatValue stat;

  /// Whether this is the last item (no bottom padding).
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: stat.color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                stat.label,
                style: HarvestCalculatorDesignConstants.smallTextStyle.copyWith(
                  height: 18 / 12,
                ),
              ),
            ],
          ),
          Text(
            stat.value,
            style: HarvestCalculatorDesignConstants.smallTextStyle.copyWith(
              height: 18 / 12,
            ),
          ),
        ],
      ),
    );
  }
}

/// Data model for chart statistic value.
class ChartStatValue {
  /// Creates a new instance of [ChartStatValue].
  ChartStatValue({
    required this.label,
    required this.value,
    required this.color,
  });

  /// Statistic label.
  final String label;

  /// Statistic value.
  final String value;

  /// Color indicator for this statistic.
  final Color color;
}
