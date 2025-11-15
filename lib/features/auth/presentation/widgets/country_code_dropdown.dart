import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/auth/domain/entities/country_code.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Country code dropdown widget for phone login.
///
/// Displays country flag, dial code, and name in a dropdown format.
class CountryCodeDropdown extends StatelessWidget {
  /// Creates a new instance of [CountryCodeDropdown].
  const CountryCodeDropdown({
    required this.countryCodes,
    required this.selectedCountryCode,
    required this.onChanged,
    this.enabled = true,
    super.key,
  });

  /// List of available country codes
  final List<CountryCode> countryCodes;

  /// Currently selected country code
  final CountryCode? selectedCountryCode;

  /// Callback when selection changes
  final ValueChanged<CountryCode> onChanged;

  /// Whether the dropdown is enabled
  final bool enabled;

  // Design tokens
  static const double _borderRadius = 8;
  static const double _padding = 12;
  static const double _chevronSize = 20;
  static const double _fontSize = 14;
  static const double _lineHeight = 1.4;
  static const double _maxMenuHeight =
      300; // Maximum height for scrollable menu

  @override
  Widget build(BuildContext context) {
    final selected =
        selectedCountryCode ??
        (countryCodes.isNotEmpty ? countryCodes.first : null);

    return GestureDetector(
      onTap: enabled ? () => _showDropdown(context) : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.6,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: _padding,
            vertical: _padding,
          ),
          decoration: BoxDecoration(
            color: AppColors.gray05,
            border: Border.all(color: AppColors.gray20),
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Flag emoji or placeholder
              if (selected?.flag != null)
                Text(selected!.flag!, style: const TextStyle(fontSize: 20))
              else
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.gray20,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              const SizedBox(width: 8),
              // Dial code
              Text(
                selected?.dialCode ?? '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: _fontSize,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray100,
                  fontFamily: AppConstants.fontFamily,
                  height: _lineHeight,
                ),
              ),
              const SizedBox(width: 4),
              // Chevron down icon
              ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  AppColors.gray100,
                  BlendMode.srcIn,
                ),
                child: SvgPicture.asset(
                  Assets.icons.outline.chevronDown,
                  width: _chevronSize,
                  height: _chevronSize,
                  placeholderBuilder: (context) => const Icon(
                    Icons.keyboard_arrow_down,
                    size: _chevronSize,
                    color: AppColors.gray100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Shows the dropdown menu.
  void _showDropdown(BuildContext context) {
    showModalBottomSheet<CountryCode>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: const BoxConstraints(maxHeight: _maxMenuHeight),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(_borderRadius),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.gray20,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // List of countries
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: countryCodes.length,
                itemBuilder: (context, index) {
                  final countryCode = countryCodes[index];
                  final isSelected = countryCode == selectedCountryCode;

                  return InkWell(
                    onTap: () {
                      Navigator.pop(context, countryCode);
                      onChanged(countryCode);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: _padding,
                        vertical: _padding,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary20
                            : AppColors.white,
                        border: const Border(
                          bottom: BorderSide(color: AppColors.gray20),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Flag
                          if (countryCode.flag != null)
                            Text(
                              countryCode.flag!,
                              style: const TextStyle(fontSize: 20),
                            )
                          else
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.gray20,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          const SizedBox(width: 8),
                          // Dial code
                          Text(
                            countryCode.dialCode,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontSize: _fontSize,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.gray100,
                                  fontFamily: AppConstants.fontFamily,
                                  height: _lineHeight,
                                ),
                          ),
                          const SizedBox(width: 8),
                          // Country name
                          Expanded(
                            child: Text(
                              countryCode.name,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontSize: _fontSize,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.gray100,
                                    fontFamily: AppConstants.fontFamily,
                                    height: _lineHeight,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
