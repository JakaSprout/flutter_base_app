import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Action chip button widget for filter and sort actions in lab request.
class LabRequestActionChipButton extends StatelessWidget {
  /// Creates a new instance of [LabRequestActionChipButton].
  const LabRequestActionChipButton({
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
          color: isActive ? LabRequestDesignConstants.gray05 : null,
          border: Border.all(
            color: isActive
                ? LabRequestDesignConstants.primary
                : LabRequestDesignConstants.gray20,
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
                  ? LabRequestDesignConstants.primary
                  : LabRequestDesignConstants.gray60,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: LabRequestDesignConstants.gray100,
              ),
            ),
            if (showChevronDown) ...[
              const SizedBox(width: 6),
              SvgPicture.asset(
                Assets.icons.outline.chevronDown,
                width: 18,
                height: 18,
                color: isActive
                    ? LabRequestDesignConstants.primary
                    : LabRequestDesignConstants.gray60,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Action chips for filtering and sorting lab requests.
class LabRequestActionChips extends StatelessWidget {
  /// Creates a new instance of [LabRequestActionChips].
  const LabRequestActionChips({
    super.key,
    this.onFilterTap,
    this.onSortTap,
    this.onResetFilterTap,
    this.filterCount = 0,
    this.sortLabel,
  });

  /// Callback when filter chip is tapped.
  final VoidCallback? onFilterTap;

  /// Callback when sort chip is tapped.
  final VoidCallback? onSortTap;

  /// Callback when reset filter button is tapped.
  final VoidCallback? onResetFilterTap;

  /// Number of active filters.
  final int filterCount;

  /// Label for active sort (optional).
  final String? sortLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LabRequestDesignConstants.screenHorizontalPadding,
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (filterCount > 0)
            InkWell(
              onTap: onResetFilterTap,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: LabRequestDesignConstants.gray20,
                  ),
                ),
                child: const Icon(
                  Icons.close,
                  size: 20,
                  color: LabRequestDesignConstants.gray60,
                ),
              ),
            ),
          LabRequestActionChipButton(
            iconAsset: Assets.icons.outline.filter,
            label: filterCount > 0
                ? '${LabRequestConstants.buttonFilter}: $filterCount'
                : LabRequestConstants.buttonFilter,
            onTap: onFilterTap ?? () {},
            showChevronDown: true,
            isActive: filterCount > 0,
          ),
          LabRequestActionChipButton(
            iconAsset: Assets.icons.outline.sort,
            label: sortLabel ?? LabRequestConstants.buttonSort,
            onTap: onSortTap ?? () {},
            showChevronDown: true,
          ),
        ],
      ),
    );
  }
}





