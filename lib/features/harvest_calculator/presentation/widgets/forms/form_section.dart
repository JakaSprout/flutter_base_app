import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_header.dart';

/// Section widget for organizing form fields.
///
/// Figma: Section Container with gap 12px, Section Header Container with gap 12px
/// Each section has its own padding/margin to allow dot to extend to screen edge
class FormSection extends StatelessWidget {
  /// Creates a new instance of [FormSection].
  const FormSection({
    required this.title,
    required this.children,
    this.isActive = true,
    super.key,
  });

  /// Section title.
  final String title;

  /// Child widgets.
  final List<Widget> children;

  /// Whether the section is active (affects header styling)
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Container - gap 12px
        // Header has no padding, indicator at position 0 (section's left edge)
        SectionHeader(title: title, isActive: isActive),
        const SizedBox(height: 12), // Gap 12px between header and fields
        // Fields Container - gap 8px between fields (handled by children)
        // Fields have their own padding
        ...children,
      ],
    );
  }
}
