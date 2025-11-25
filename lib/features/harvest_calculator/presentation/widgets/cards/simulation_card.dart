import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/harvest_simulation_summary.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/shared/info_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

/// Simulation card widget for displaying simulation summary information.
class SimulationCard extends StatelessWidget {
  const SimulationCard({
    required this.summary,
    required this.currencyFormat,
    super.key,
  });

  final HarvestSimulationSummary summary;
  final NumberFormat currencyFormat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HarvestCalculatorDesignConstants.actionChipBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: summary.iconBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    summary.iconAsset,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      summary.name,
                      style: HarvestCalculatorDesignConstants.cardTitleTextStyle
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('dd MMM yyyy').format(summary.date),
                      style: HarvestCalculatorDesignConstants
                          .smallTextSecondaryStyle
                          .copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: HarvestCalculatorDesignConstants.gray60,
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: HarvestCalculatorDesignConstants.backgroundWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InfoColumn(
                        label: 'Komoditas',
                        value: summary.commodity,
                      ),
                    ),
                    Expanded(
                      child: InfoColumn(
                        label: 'Total Potensi Panen (MT)',
                        value:
                            '${summary.totalHarvestMt.toStringAsFixed(3)} MT',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: InfoColumn(
                        label: 'Pengeluaran Pakan (Rp)',
                        value: currencyFormat.format(summary.feedCost),
                      ),
                    ),
                    Expanded(
                      child: InfoColumn(
                        label: 'Total Potensi Panen (Rp)',
                        value: currencyFormat.format(summary.potentialRevenue),
                      ),
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
