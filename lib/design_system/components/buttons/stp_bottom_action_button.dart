import 'package:app_mobile_afms/design_system/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Shared bottom action button widget.
///
/// A full-width elevated button typically used at the bottom of screens.
/// Includes a container with shadow and safe area handling.
class STPBottomActionButton extends StatelessWidget {
  /// Creates a new instance of [STPBottomActionButton].
  const STPBottomActionButton({
    required this.onPressed,
    this.text,
    this.child,
    this.enabled = true,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.height,
    this.fontSize,
    this.fontWeight,
    super.key,
  }) : assert(
         text != null || child != null,
         'Either text or child must be provided',
       );

  /// The text to display on the button. Mutually exclusive with [child].
  final String? text;

  /// Custom child widget to display instead of text. Mutually exclusive with [text].
  final Widget? child;

  /// Callback when button is pressed.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Defaults to true.
  final bool enabled;

  /// Whether the button is in loading state. Defaults to false.
  final bool isLoading;

  /// Background color of the button. Defaults to primary color.
  final Color? backgroundColor;

  /// Foreground (text) color of the button. Defaults to white.
  final Color? foregroundColor;

  /// Border radius of the button. Defaults to 12.
  final double? borderRadius;

  /// Height of the button. Defaults to 56.
  final double? height;

  /// Font size of the button text. Defaults to 16.
  final double? fontSize;

  /// Font weight of the button text. Defaults to w600.
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    // Remove both view insets and padding to prevent button from moving up when keyboard appears
    return MediaQuery.removeViewInsets(
      context: context,
      removeBottom: true,
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          decoration: const BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.gray20,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              width: double.infinity,
              height: height ?? 56,
              child: ElevatedButton(
                onPressed: (enabled && !isLoading) ? onPressed : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: enabled && !isLoading
                      ? (backgroundColor ?? AppColors.primary)
                      : AppColors.gray20,
                  foregroundColor: foregroundColor ?? AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 12),
                  ),
                  elevation: 0,
                  minimumSize: Size(double.infinity, height ?? 56),
                ),
                child: isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            foregroundColor ?? AppColors.white,
                          ),
                        ),
                      )
                    : child ??
                    Text(
                      text!,
                      style: TextStyle(
                        fontSize: fontSize ?? 16,
                        fontWeight: fontWeight ?? FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
