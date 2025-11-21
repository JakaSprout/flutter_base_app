import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';

/// Padding utilities for form section fields.
///
/// Provides consistent padding for fields within sections.
class SectionFieldPadding {
  const SectionFieldPadding._();

  /// Standard horizontal padding for section fields (20px).
  static const double horizontal =
      HarvestCalculatorDesignConstants.screenPaddingHorizontal;

  /// Standard spacing between fields (8px).
  static const double fieldSpacing = 8;

  /// Wraps a field with standard left padding.
  ///
  /// Example:
  /// ```dart
  /// SectionFieldPadding.wrap(
  ///   child: ReactiveTextFieldWidget(...),
  /// )
  /// ```
  static Widget wrap({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(left: horizontal),
      child: child,
    );
  }

  /// Wraps a section with standard right padding.
  ///
  /// Example:
  /// ```dart
  /// SectionFieldPadding.wrapSection(
  ///   child: FormSection(...),
  /// )
  /// ```
  static Widget wrapSection({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(right: horizontal),
      child: child,
    );
  }
}






