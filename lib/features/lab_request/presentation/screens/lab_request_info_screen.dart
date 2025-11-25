import 'package:app_mobile_afms/design_system/components/buttons/stp_bottom_action_button.dart';
import 'package:app_mobile_afms/design_system/components/navigation/stp_app_bar.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_info_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/screens/lab_request_form_screen.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/shared/info_section_widget.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/shared/test_type_list_widget.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Lab Request Information Screen.
///
/// This screen displays information about the lab request procedure and
/// available testing types. It's the entry point for users who want to
/// submit a lab request.
///
/// The screen includes:
/// - Microscope illustration
/// - Procedure information section
/// - List of available test types (4 types)
/// - Bottom action button to start the request process
class LabRequestInfoScreen extends StatelessWidget {
  /// Creates a new instance of [LabRequestInfoScreen].
  const LabRequestInfoScreen({super.key});

  /// Route name for navigation
  static const String routeName = '/lab-request-info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LabRequestDesignConstants.backgroundColor,
      appBar: const STPAppBar(title: LabRequestInfoConstants.screenTitle),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: LabRequestDesignConstants.spacingMedium,
                    ),
                    // Microscope illustration
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal:
                            LabRequestDesignConstants.screenHorizontalPadding,
                      ),
                      child: SvgPicture.asset(
                        Assets.icons.general.microscope,
                        width: 75,
                        height: 75,
                        // ignore: deprecated_member_use
                        color: LabRequestDesignConstants.primary.withOpacity(
                          0.8,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: LabRequestDesignConstants.spacingLarge,
                    ),
                    // Procedure information section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal:
                            LabRequestDesignConstants.screenHorizontalPadding,
                      ),
                      child: InfoSectionWidget(
                        title: LabRequestInfoConstants.sectionTitleProcedure,
                        icon: SvgPicture.asset(
                          Assets.icons.general.signHelp,
                          width: 20,
                          height: 20,
                          // ignore: deprecated_member_use
                          color: LabRequestDesignConstants.gray70,
                        ),
                        bodyParagraphs: const [
                          LabRequestInfoConstants.procedureDescriptionPara1,
                          LabRequestInfoConstants.procedureDescriptionPara2,
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: LabRequestDesignConstants.spacingMedium,
                    ),
                    const Divider(
                      color: LabRequestDesignConstants.gray10,
                      thickness: 4,
                    ),
                    const SizedBox(
                      height: LabRequestDesignConstants.spacingMedium,
                    ),
                    // Test types section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal:
                            LabRequestDesignConstants.screenHorizontalPadding,
                      ),
                      child: InfoSectionWidget(
                        title: LabRequestInfoConstants.sectionTitleTestTypes,
                        icon: SvgPicture.asset(
                          Assets.icons.general.list,
                          width: 20,
                          height: 20,
                          // ignore: deprecated_member_use
                          color: LabRequestDesignConstants.gray70,
                        ),
                        bodyParagraphs: const [],
                      ),
                    ),
                    const SizedBox(
                      height: LabRequestDesignConstants.spacingSmall,
                    ),
                    // Test types list
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            LabRequestDesignConstants.screenHorizontalPadding,
                      ),
                      child: TestTypeListWidget(
                        testTypes: [
                          LabRequestInfoConstants.testTypePcrKonvensional,
                          LabRequestInfoConstants.testTypePcrRealtime,
                          LabRequestInfoConstants.testTypePcrPockit,
                          LabRequestInfoConstants.testTypeKualitasAir,
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: LabRequestDesignConstants.spacingLarge,
                    ),
                  ],
                ),
              ),
            ),
            // Bottom action button
            STPBottomActionButton(
              text: LabRequestInfoConstants.buttonStart,
              backgroundColor: LabRequestDesignConstants.primary,
              height: LabRequestDesignConstants.buttonHeight,
              borderRadius: LabRequestDesignConstants.buttonBorderRadius,
              fontSize: LabRequestDesignConstants.buttonFontSize,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const LabRequestFormScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
