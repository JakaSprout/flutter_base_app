import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart' as reactive_forms;

/// Number text input formatter with thousand separators.
/// Uses pattern_formatter library for robust number formatting.
/// Automatically adds thousand separators (,) and handles decimals.
/// Example: 1000 becomes 1,000, 1500.25 becomes 1,500.25
class NumberTextInputFormatter extends TextInputFormatter {
  const NumberTextInputFormatter({this.allowDecimal = false});

  /// Whether to allow decimal points (for fields like FCR: 1.2, 1.5, etc.)
  final bool allowDecimal;
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Only process if the new value is different
    if (oldValue.text == newValue.text) {
      return newValue;
    }

    final text = newValue.text;

    // Allow digits, commas, and optionally decimal point
    final allowedChars = allowDecimal
        ? RegExp(r'^[\d,.]*$')
        : RegExp(r'^[\d,]*$');
    if (!allowedChars.hasMatch(text)) {
      return oldValue;
    }

    // Don't allow multiple decimal points
    if (allowDecimal && '.'.allMatches(text).length > 1) {
      return oldValue;
    }

    // For integer fields, don't allow leading zeros except for "0" itself
    if (!allowDecimal && text.length > 1 && text.startsWith('0')) {
      return oldValue;
    }

    // Format with thousand separators
    final formattedText = _formatWithThousandSeparators(text);

    // Calculate cursor position (keep it at the end for simplicity)
    final cursorPosition = formattedText.length;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }

  String _formatWithThousandSeparators(String text) {
    if (text.isEmpty) return text;

    // Remove existing commas first
    final cleanText = text.replaceAll(',', '');

    // If no decimal point, format the whole number
    if (!cleanText.contains('.')) {
      return _addThousandSeparators(cleanText);
    }

    // Split into integer and decimal parts
    final parts = cleanText.split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];

    // Format integer part with thousand separators
    final formattedInteger = _addThousandSeparators(integerPart);

    return '$formattedInteger.$decimalPart';
  }

  String _addThousandSeparators(String numberString) {
    if (numberString.length <= 3) return numberString;

    final buffer = StringBuffer();
    final length = numberString.length;

    for (var i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(numberString[i]);
    }

    return buffer.toString();
  }

  /// Convert formatted number string back to clean number string
  /// Example: "1,000,000" becomes "1000000"
  static String cleanNumberString(String formattedString) {
    return formattedString.replaceAll(',', '');
  }
}

/// Reactive text field widget with label and required indicator.
///
/// Uses reactive_forms for form management.
/// Figma: Label with required indicator (*), gap 8px, field with padding 8px 16px,
/// height fixed, border radius 8px, border Gray/20
class ReactiveTextFieldWidget extends StatefulWidget {
  /// Creates a new instance of [ReactiveTextFieldWidget].
  const ReactiveTextFieldWidget({
    required this.formControlName,
    required this.label,
    this.isRequired = false,
    this.hint,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.inputFormatters,
    this.validationMessages,
    this.readOnly = false,
    super.key,
  });

  /// Form control name
  final String formControlName;

  /// Field label
  final String label;

  /// Whether the field is required (shows red asterisk)
  final bool isRequired;

  /// Optional hint text
  final String? hint;

  /// Optional prefix widget (e.g., currency label)
  final Widget? prefix;

  /// Optional suffix widget (e.g., unit label)
  final Widget? suffix;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Input formatters for text input
  final List<TextInputFormatter>? inputFormatters;

  /// Validation messages
  final Map<String, reactive_forms.ValidationMessageFunction>?
  validationMessages;

  /// Whether the field is read-only (disabled)
  final bool readOnly;

  @override
  State<ReactiveTextFieldWidget> createState() =>
      _ReactiveTextFieldWidgetState();
}

class _ReactiveTextFieldWidgetState extends State<ReactiveTextFieldWidget> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      // Scroll to make field visible when focused
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          Scrollable.ensureVisible(
            context,
            alignment: 0.3, // Position field at 30% from top
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  // Design tokens from Figma
  static const double _gap = 8;
  static const double _fieldPaddingHorizontal = 16;
  static const double _fieldPaddingVertical = 8;
  static const double _fieldHeight = 40; // Calculated from padding

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Container with required indicator
        Row(
          children: [
            if (widget.isRequired) ...[
              Text(
                '*',
                style: HarvestCalculatorDesignConstants.smallTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: HarvestCalculatorDesignConstants.errorColor,
                ),
              ),
              const SizedBox(width: 2), // Gap 2px
            ],
            Text(
              widget.label,
              style: HarvestCalculatorDesignConstants.formLabelTextStyle,
            ),
          ],
        ),
        const SizedBox(height: _gap), // Gap 8px
        // Field
        Container(
          height: _fieldHeight,
          decoration: BoxDecoration(
            color: widget.readOnly
                ? HarvestCalculatorDesignConstants.disabledFieldBackgroundColor
                : null,
            border: Border.all(
              color: HarvestCalculatorDesignConstants.borderGray, // Gray/20
            ),
            borderRadius: BorderRadius.circular(
              HarvestCalculatorDesignConstants.inputBorderRadius, // 8px
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              HarvestCalculatorDesignConstants.inputBorderRadius, // 8px
            ),
            child: Row(
              children: [
                if (widget.prefix != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: _fieldPaddingHorizontal,
                      right: 8,
                    ),
                    child: widget.prefix,
                  ),
                ],
                Expanded(
                  child: reactive_forms.ReactiveTextField<String>(
                    key: ValueKey(
                      'reactive_text_field_${widget.formControlName}',
                    ),
                    formControlName: widget.formControlName,
                    focusNode: _focusNode,
                    keyboardType: widget.keyboardType,
                    inputFormatters: _getInputFormatters(),
                    validationMessages: widget.validationMessages,
                    readOnly: widget.readOnly,
                    showErrors: (control) => false,
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: HarvestCalculatorDesignConstants
                          .formFieldPlaceholderTextStyle,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        left: widget.prefix == null
                            ? _fieldPaddingHorizontal
                            : 0,
                        right: _fieldPaddingHorizontal,
                        top: _fieldPaddingVertical,
                        bottom: _fieldPaddingVertical,
                      ),
                      isDense: true,
                      filled: false,
                    ),
                    style: HarvestCalculatorDesignConstants.formFieldTextStyle
                        .copyWith(
                          color: widget.readOnly
                              ? HarvestCalculatorDesignConstants
                                    .disabledTextColor
                              : HarvestCalculatorDesignConstants.textPrimary,
                        ),
                  ),
                ),
                if (widget.suffix != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(
                      right: _fieldPaddingHorizontal,
                    ),
                    child: widget.suffix,
                  ),
                ],
              ],
            ),
          ),
        ),
        reactive_forms.ReactiveValueListenableBuilder<String>(
          formControlName: widget.formControlName,
          builder: (context, control, child) {
            final errorText = _resolveErrorText(control);
            if (errorText == null) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                errorText,
                style: HarvestCalculatorDesignConstants.formErrorTextStyle,
              ),
            );
          },
        ),
      ],
    );
  }

  String? _resolveErrorText(reactive_forms.AbstractControl<dynamic> control) {
    if (!_shouldShowError(control)) return null;
    final errors = control.errors;
    if (errors.isEmpty) return null;

    if (widget.validationMessages != null) {
      for (final entry in errors.entries) {
        final messageBuilder = widget.validationMessages![entry.key];
        if (messageBuilder != null) {
          return messageBuilder(entry.value);
        }
      }
    }

    final firstError = errors.entries.first;
    final dynamic value = firstError.value;
    if (value == null) return 'Field tidak valid';
    return value.toString();
  }

  List<TextInputFormatter>? _getInputFormatters() {
    final formatters = <TextInputFormatter>[];

    // Default number formatter for number fields
    if (widget.keyboardType == TextInputType.number) {
      formatters.add(FilteringTextInputFormatter.allow(RegExp('[0-9.]')));
    }

    // Add custom formatters
    if (widget.inputFormatters != null) {
      formatters.addAll(widget.inputFormatters!);
    }

    return formatters.isEmpty ? null : formatters;
  }

  bool _shouldShowError(reactive_forms.AbstractControl<dynamic> control) {
    return control.invalid && (control.dirty || control.touched);
  }
}
