import 'package:flutter/material.dart';
import 'package:app_mobile_afms/design_system/theme/app_colors.dart';

/// A custom switch widget that provides a toggle control with smooth animations.
///
/// This widget implements a Material Design-inspired switch component with
/// custom styling that follows the app's design system. It features:
/// - Animated transitions when toggling between on/off states
/// - Customizable colors based on the current state
/// - Touch-friendly size and interaction
///
/// Example usage:
/// ```dart
/// STPSwitch(
///   value: isEnabled,
///   onChanged: (newValue) {
///     setState(() {
///       isEnabled = newValue;
///     });
///   },
/// )
/// ```
class STPSwitch extends StatelessWidget {
  /// Creates a custom switch widget.
  ///
  /// The [value] parameter determines whether the switch is currently on (true)
  /// or off (false).
  ///
  /// The [onChanged] callback is called when the user taps the switch to toggle
  /// its state. If null, the switch will be disabled.
  const STPSwitch({required this.value, required this.onChanged, super.key});

  /// The current state of the switch.
  ///
  /// When `true`, the switch is in the "on" position. When `false`, it's in
  /// the "off" position.
  final bool value;

  /// Callback function that is called when the switch is toggled.
  ///
  /// The callback receives the new boolean value that the switch should have.
  final ValueChanged<bool> onChanged;

  // Layout constants
  /// Width of the switch track in logical pixels.
  static const double _trackWidth = 44;

  /// Height of the switch track in logical pixels.
  static const double _trackHeight = 24;

  /// Size (width and height) of the switch thumb in logical pixels.
  static const double _thumbSize = 20;

  /// Border radius of the switch track in logical pixels.
  static const double _borderRadius = 12;

  /// Horizontal padding inside the track for the thumb positioning.
  static const double _thumbPaddingHorizontal = 2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Toggle the switch value when tapped
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        // Animation duration for smooth state transitions
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: _trackWidth,
        height: _trackHeight,
        decoration: BoxDecoration(
          // Track color: primary when on, white when off
          color: value ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(
            // Border color matches track color for seamless appearance
            color: value ? AppColors.primary : AppColors.gray20,
          ),
        ),
        child: Padding(
          // Horizontal padding to position thumb with proper spacing
          padding: const EdgeInsets.symmetric(
            horizontal: _thumbPaddingHorizontal,
          ),
          child: AnimatedAlign(
            // Animation duration matches container animation for synchronized effect
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            // Thumb position: right when on, left when off
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: _thumbSize,
              height: _thumbSize,
              decoration: BoxDecoration(
                // Thumb color: white when on (for contrast), gray when off
                color: value ? AppColors.white : AppColors.gray70,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
