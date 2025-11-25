import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:flutter/material.dart';

/// Reusable widget for displaying information sections.
///
/// This widget provides a consistent layout for information sections with:
/// - Optional icon before the title
/// - Section title with proper spacing
/// - Body text supporting multiple paragraphs
/// - Consistent typography using LabRequestDesignConstants
class InfoSectionWidget extends StatelessWidget {
  /// Creates a new instance of [InfoSectionWidget].
  const InfoSectionWidget({
    required this.title,
    required this.bodyParagraphs,
    this.icon,
    super.key,
  });

  /// Section title text
  final String title;

  /// List of body paragraphs to display
  final List<String> bodyParagraphs;

  /// Optional icon to display before the title
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with optional icon
        Row(
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: LabRequestDesignConstants.spacingSmall),
            ],
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: LabRequestDesignConstants.gray100,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: LabRequestDesignConstants.spacingSmall),
        // Body paragraphs
        ...bodyParagraphs.asMap().entries.map((entry) {
          final isLast = entry.key == bodyParagraphs.length - 1;
          return Padding(
            padding: EdgeInsets.only(
              bottom: isLast ? 0 : LabRequestDesignConstants.spacingSmall,
            ),
            child: Text(
              entry.value,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: LabRequestDesignConstants.gray70,
                height: 1.5,
              ),
            ),
          );
        }),
      ],
    );
  }
}
