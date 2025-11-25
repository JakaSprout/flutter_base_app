import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_form_controls.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/forms/reactive_lab_dropdown_field.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Farm Information Section Widget (Reactive Form Version).
///
/// Displays the farm information section with:
/// - Section header with orange indicator (SVG)
/// - Reactive farm dropdown field
/// - Reactive date picker field
class FarmInfoSection extends StatelessWidget {
  /// Creates a new instance of [FarmInfoSection].
  const FarmInfoSection({
    required this.sectionTitle,
    required this.farmLabel,
    required this.dateLabel,
    required this.onFarmTap,
    required this.onDateTap,
    this.isActive = true,
    super.key,
  });

  /// Section title text
  final String sectionTitle;

  /// Farm field label
  final String farmLabel;

  /// Date field label
  final String dateLabel;

  /// Callback when farm field is tapped
  final VoidCallback onFarmTap;

  /// Callback when date field is tapped
  final VoidCallback onDateTap;

  /// Whether section is active (affects header styling)
  final bool isActive;

  // Design tokens to match harvest calculator pattern
  static const double _indicatorWidth = 8;
  static const double _indicatorHeight = 14;
  static const double _gap = 12;
  static const double _screenHorizontalPadding = 20;

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final dateControl =
            form.control(LabRequestFormControls.sendDate)
                as FormControl<DateTime>;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header with SVG indicator
            Row(
              children: [
                Opacity(
                  opacity: isActive ? 1.0 : 0.2,
                  child: SvgPicture.asset(
                    Assets.icons.general.sectionIndicator,
                    width: _indicatorWidth,
                    height: _indicatorHeight,
                  ),
                ),
                const SizedBox(width: _gap),
                Text(
                  sectionTitle,
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 16,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isActive
                        ? const Color(0xFF1A1A1A)
                        : const Color(0xFF8A8A8A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (isActive) ...[
              // Farm field - with horizontal padding
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: _screenHorizontalPadding,
                ),
                child: ReactiveLabDropdownField<String>(
                  formControlName: LabRequestFormControls.selectedFarm,
                  label: farmLabel,
                  isRequired: true,
                  items: const [], // Populated from provider/state
                  hint: 'Pilih Farm',
                  onTap: onFarmTap,
                  validationMessages: {'required': (_) => 'Farm harus dipilih'},
                ),
              ),
              const SizedBox(height: 16),
              // Date field - with horizontal padding (non-reactive display)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: _screenHorizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Label with required indicator
                    Row(
                      children: [
                        const Text(
                          '*',
                          style: TextStyle(
                            color: Color(0xFFD84639),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          dateLabel,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF1A1A1A),
                            fontFamily: 'Open Sans',
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Date display field
                    GestureDetector(
                      onTap: onDateTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            // Calendar icon on left
                            const Icon(
                              Icons.calendar_today,
                              size: 20,
                              color: Color(0xFF8A8A8A),
                            ),
                            const SizedBox(width: 8),
                            // Date text
                            Expanded(
                              child: Text(
                                dateControl.value != null
                                    ? DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(dateControl.value!)
                                    : 'Pilih Tanggal Kirim',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: dateControl.value != null
                                      ? const Color(0xFF1A1A1A)
                                      : const Color(0xFF8A8A8A),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Chevron down icon on right
                            const Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                              color: Color(0xFF8A8A8A),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
