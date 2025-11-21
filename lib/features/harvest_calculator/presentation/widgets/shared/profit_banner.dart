import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:intl/intl.dart';

/// Banner displaying potential profit information.
class ProfitBanner extends StatelessWidget {
  /// Creates a new instance of [ProfitBanner].
  const ProfitBanner({
    super.key,
    required this.potentialProfit,
    required this.adg,
    required this.currencyFormat,
    required this.adgFormat,
  });

  /// Potential profit value.
  final double potentialProfit;

  /// Average daily gain value.
  final double adg;

  /// Currency formatter.
  final NumberFormat currencyFormat;

  /// ADG formatter.
  final NumberFormat adgFormat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SectionFieldPadding.horizontal,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: HarvestCalculatorDesignConstants.successBannerBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: RichText(
          text: TextSpan(
            style: HarvestCalculatorDesignConstants.smallTextStyle.copyWith(
              height: 18 / 12,
              color: HarvestCalculatorDesignConstants.successColor,
            ),
            children: [
              const TextSpan(text: 'Dengan estimasi '),
              TextSpan(
                text: 'ADG ${adgFormat.format(adg)}g ',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: HarvestCalculatorDesignConstants.successColor,
                ),
              ),
              const TextSpan(text: 'potensi pendapatan bersih: '),
              TextSpan(
                text: currencyFormat.format(potentialProfit),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: HarvestCalculatorDesignConstants.successColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
