import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:flutter/material.dart';

/// Widget to display a list of test types.
///
/// This widget renders a simple list of test type names with consistent
/// styling and spacing.
class TestTypeListWidget extends StatelessWidget {
  /// Creates a new instance of [TestTypeListWidget].
  const TestTypeListWidget({required this.testTypes, super.key});

  /// List of test type names to display
  final List<String> testTypes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: testTypes.asMap().entries.map((entry) {
        final isLast = entry.key == testTypes.length - 1;
        return Padding(
          padding: EdgeInsets.only(
            bottom: isLast ? 0 : LabRequestDesignConstants.spacingXSmall,
          ),
          child: Text(
            entry.value,
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: LabRequestDesignConstants.gray70,
            ),
          ),
        );
      }).toList(),
    );
  }
}
