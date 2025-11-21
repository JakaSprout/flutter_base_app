import 'package:flutter/material.dart';
import 'package:app_mobile_afms/design_system/theme/app_colors.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';

/// Shared choice chip button widget.
///
/// A reusable button component for selection states, typically used in
/// segmented toggles or option groups.
class STPChoiceChipButton extends StatelessWidget {
  /// Creates a new instance of [STPChoiceChipButton].
  const STPChoiceChipButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.width,
    this.height = 36,
    this.borderRadius = 200,
    this.padding,
    super.key,
  });

  /// Button label text.
  final String label;

  /// Whether this button is selected.
  final bool isSelected;

  /// Callback when button is tapped.
  final VoidCallback onTap;

  /// Optional width. If not provided, button will size to content.
  final double? width;

  /// Height of the button. Defaults to 36.
  final double height;

  /// Border radius of the button. Defaults to 200 (pill shape).
  final double borderRadius;

  /// Padding of the button. Defaults to EdgeInsets.symmetric(horizontal: 12, vertical: 8).
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE7ECFA) : AppColors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.gray20,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? HarvestCalculatorDesignConstants.primaryBlue
                  : HarvestCalculatorDesignConstants.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
