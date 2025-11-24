import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Action chip button widget for filter and sort actions.
class ActionChipButton extends StatelessWidget {
  const ActionChipButton({
    required this.iconAsset,
    required this.label,
    required this.onTap,
    this.showChevronDown = false,
    this.isActive = false,
    super.key,
  });

  final String iconAsset;
  final String label;
  final VoidCallback onTap;
  final bool showChevronDown;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? HarvestCalculatorDesignConstants.lightBlueBackground
              : null,
          border: Border.all(
            color: isActive
                ? HarvestCalculatorDesignConstants.primary
                : HarvestCalculatorDesignConstants.borderGray,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconAsset,
              width: 18,
              height: 18,
              color: isActive
                  ? HarvestCalculatorDesignConstants.primary
                  : HarvestCalculatorDesignConstants.placeholderColor,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: HarvestCalculatorDesignConstants.buttonTextStyle.copyWith(
                color: isActive
                    ? HarvestCalculatorDesignConstants.primary
                    : HarvestCalculatorDesignConstants.textPrimary,
              ),
            ),
            if (showChevronDown) ...[
              const SizedBox(width: 6),
              SvgPicture.asset(
                Assets.icons.outline.chevronDown,
                width: 18,
                height: 18,
                color: isActive
                    ? HarvestCalculatorDesignConstants.primary
                    : HarvestCalculatorDesignConstants.placeholderColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
