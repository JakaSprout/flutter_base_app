import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Modal bottom sheet for download options.
class DownloadSimulationModal extends StatelessWidget {
  /// Creates a new instance of [DownloadSimulationModal].
  const DownloadSimulationModal({required this.simulationName, super.key});

  /// Simulation name to display in heading.
  final String simulationName;

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle bar
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.gray20,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header with title and close button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${HarvestCalculatorConstants.titleDownloadSimulation} $year',
                      style:
                          HarvestCalculatorDesignConstants.cardTitleTextStyle,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.gray60,
                      size: 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            // Subtitle
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                HarvestCalculatorConstants.subtitleChooseFileType,
                style: HarvestCalculatorDesignConstants.bodyTextStyle,
              ),
            ),
            // Download options
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: [
                  DownloadOptionCard(
                    label: HarvestCalculatorConstants.optionPDF,
                    onTap: () {
                      // TODO(user): Implement PDF export
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 12),
                  DownloadOptionCard(
                    label: HarvestCalculatorConstants.optionCSV,
                    onTap: () {
                      // TODO(user): Implement CSV export
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            // Bottom padding consistent with STPBottomActionButton
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/// Card widget for download option (PDF/CSV).
class DownloadOptionCard extends StatelessWidget {
  /// Creates a new instance of [DownloadOptionCard].
  const DownloadOptionCard({
    required this.label,
    required this.onTap,
    super.key,
  });

  /// Label text (PDF or CSV).
  final String label;

  /// Callback when card is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.gray20),
        ),
        child: Row(
          children: [
            // File type badge
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.gray05,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: HarvestCalculatorDesignConstants.smallTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: HarvestCalculatorDesignConstants.placeholderColor,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Label text
            Expanded(
              child: Text(
                label,
                style: HarvestCalculatorDesignConstants.bodyTextStyle,
              ),
            ),
            // Download icon
            SvgPicture.asset(
              Assets.icons.general.arrowDownload,
              width: 20,
              height: 20,
              color: AppColors.gray60,
            ),
          ],
        ),
      ),
    );
  }
}
