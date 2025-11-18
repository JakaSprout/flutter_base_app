import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/lab_request/presentation/constants/lab_request_design_constants.dart';

/// Form section widget.
///
/// Displays a section with a title and children widgets.
class FormSection extends StatelessWidget {
  /// Creates a new instance of [FormSection].
  const FormSection({required this.title, required this.children, super.key});

  /// Section title
  final String title;

  /// Section children widgets
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: LabRequestDesignConstants.spacingMedium),
        ...children,
      ],
    );
  }
}
