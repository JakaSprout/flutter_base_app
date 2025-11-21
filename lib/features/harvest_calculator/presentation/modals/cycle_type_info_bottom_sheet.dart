import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';

/// Bottom sheet displaying information about cycle types.
class CycleTypeInfoBottomSheet extends StatelessWidget {
  /// Creates a new instance of [CycleTypeInfoBottomSheet].
  const CycleTypeInfoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.gray20,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      HarvestCalculatorConstants.titleCycleTypeInfo,
                      style:
                          HarvestCalculatorDesignConstants.cardTitleTextStyle,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: HarvestCalculatorDesignConstants.textSecondary,
                    ),
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const _InfoParagraph(
                title: HarvestCalculatorConstants.cycleTypeFull,
                description:
                    HarvestCalculatorConstants.descriptionCycleTypeFull,
              ),
              const SizedBox(height: 16),
              const _InfoParagraph(
                title: HarvestCalculatorConstants.cycleTypeMid,
                description: HarvestCalculatorConstants.descriptionCycleTypeMid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoParagraph extends StatelessWidget {
  const _InfoParagraph({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title ',
            style: HarvestCalculatorDesignConstants.bodyTextStyle.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: description,
            style: HarvestCalculatorDesignConstants.bodyTextSecondaryStyle,
          ),
        ],
      ),
    );
  }
}
