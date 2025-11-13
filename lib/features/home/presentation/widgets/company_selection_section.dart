import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/components/inputs/stp_dropdown.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_constants.dart';

/// Company Selection section for Home screen.
///
/// Displays a label "Nama PT" with a dropdown for company selection.
class CompanySelectionSection extends StatefulWidget {
  /// Creates a new instance of [CompanySelectionSection].
  const CompanySelectionSection({
    super.key,
    this.selectedCompany,
    this.companies,
    this.onCompanyChanged,
  });

  /// Currently selected company name.
  final String? selectedCompany;

  /// List of available companies for dropdown.
  /// If null, defaults to [HomeConstants.defaultCompanyName]
  final List<String>? companies;

  /// Callback when company selection is changed.
  /// Receives the selected company name.
  final ValueChanged<String>? onCompanyChanged;

  @override
  State<CompanySelectionSection> createState() =>
      _CompanySelectionSectionState();
}

class _CompanySelectionSectionState extends State<CompanySelectionSection> {
  String? _selectedCompany;

  // Design tokens - exact Figma specs
  static const double _labelSpacing =
      8; // Figma: gap 8px between label and dropdown
  static const double _fontSizeLabel =
      12; // Figma: Label/Medium/Regular - fontSize 12
  static const double _lineHeight = 1.5; // Figma: lineHeight 1.5em

  @override
  void initState() {
    super.initState();
    _selectedCompany =
        widget.selectedCompany ??
        widget.companies?.firstOrNull ??
        HomeConstants.defaultCompanyName;
  }

  @override
  void didUpdateWidget(CompanySelectionSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCompany != oldWidget.selectedCompany) {
      _selectedCompany =
          widget.selectedCompany ??
          widget.companies?.firstOrNull ??
          HomeConstants.defaultCompanyName;
    }
  }

  @override
  Widget build(BuildContext context) {
    final companies =
        widget.companies ??
        [HomeConstants.defaultCompanyName]; // Default list if not provided

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label "Nama PT"
        Text(
          HomeConstants.companySelectionLabel,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontSize: _fontSizeLabel,
            fontWeight: FontWeight.w400, // Regular
            color: AppColors.gray100,
            fontFamily: AppConstants.fontFamily,
            height: _lineHeight,
          ),
        ),
        const SizedBox(height: _labelSpacing),
        // Dropdown
        STPDropdown<String>(
          items: companies,
          selectedValue: _selectedCompany,
          onChanged: (String selectedCompany) {
            setState(() {
              _selectedCompany = selectedCompany;
            });
            widget.onCompanyChanged?.call(selectedCompany);
          },
          colors: const STPDropdownColors.gray(),
          hint: HomeConstants.defaultCompanyName,
        ),
      ],
    );
  }
}
