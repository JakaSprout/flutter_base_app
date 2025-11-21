import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/components/banners/stp_status_banner.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';

/// Status banner shown when simulation is in preview mode.
class PreviewStatusBanner extends StatelessWidget {
  /// Creates a new instance of [PreviewStatusBanner].
  const PreviewStatusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SectionFieldPadding.horizontal,
      ),
      child: STPStatusBanner(
        type: STPStatusBannerType.info,
        child: Text.rich(
          TextSpan(
            text: 'Simulasi yang tampilkan adalah ',
            style: HarvestCalculatorDesignConstants.smallTextStyle
                .copyWith(height: 18 / 12),
            children: const [
              TextSpan(
                text: HarvestCalculatorConstants.buttonPreview,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(
                text:
                    '. Pilih opsi "${HarvestCalculatorConstants.buttonSave}" untuk menyimpan hasil.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
