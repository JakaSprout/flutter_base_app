import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/pond_option.dart';

/// Modal bottom sheet for selecting a registered pond.
class SelectRegisteredPondModal extends StatefulWidget {
  /// Creates a new instance of [SelectRegisteredPondModal].
  const SelectRegisteredPondModal({
    required this.onSave,
    this.initialValue,
    super.key,
  });

  /// Currently selected pond.
  final PondOption? initialValue;

  /// Callback when save button is pressed.
  final ValueChanged<PondOption> onSave;

  @override
  State<SelectRegisteredPondModal> createState() =>
      _SelectRegisteredPondModalState();
}

class _SelectRegisteredPondModalState extends State<SelectRegisteredPondModal> {
  late PondOption? _selectedPond;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  static const List<PondOption> _ponds = [
    PondOption(name: 'Kolam A', id: '123123'),
    PondOption(name: 'Kolam B', id: '456456'),
    PondOption(name: 'Kolam C', id: '789789'),
    PondOption(name: 'Kolam D', id: '987654'),
    PondOption(name: 'Kolam E', id: '654321'),
    PondOption(name: 'Kolam F', id: '111222'),
    PondOption(name: 'Kolam G', id: '333444'),
  ];

  List<PondOption> get _filteredPonds {
    if (_query.isEmpty) {
      return _ponds;
    }

    final lowerQuery = _query.toLowerCase();
    return _ponds
        .where(
          (pond) =>
              pond.name.toLowerCase().contains(lowerQuery) ||
              pond.id.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _selectedPond = widget.initialValue;
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSave() {
    final selected = _selectedPond;
    if (selected == null) return;

    widget.onSave(selected);
    Navigator.pop(context);
  }

  void _onSelect(PondOption pond) {
    setState(() {
      _selectedPond = pond;
    });
  }

  @override
  Widget build(BuildContext context) {
    const searchHint =
        HarvestCalculatorConstants.searchRegisteredPondPlaceholder;
    final ponds = _filteredPonds;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: const BoxDecoration(
        color: HarvestCalculatorDesignConstants.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle bar
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: HarvestCalculatorDesignConstants.gray20,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          HarvestCalculatorConstants.titleSelectRegisteredPond,
                          style: HarvestCalculatorDesignConstants
                              .cardTitleTextStyle,
                        ),
                        SizedBox(height: 4),
                        Text(
                          HarvestCalculatorConstants
                              .subtitleSelectRegisteredPond,
                          style: HarvestCalculatorDesignConstants.bodyTextStyle,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: HarvestCalculatorDesignConstants.gray60,
                    ),
                  ),
                ],
              ),
            ),
            // Search field
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: searchHint,
                    hintStyle: HarvestCalculatorDesignConstants
                        .formFieldPlaceholderTextStyle,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 12, right: 8),
                      child: Icon(
                        Icons.search,
                        size: 20,
                        color: HarvestCalculatorDesignConstants.gray60,
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minHeight: 20,
                      minWidth: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: HarvestCalculatorDesignConstants.gray20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: HarvestCalculatorDesignConstants.gray20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: HarvestCalculatorDesignConstants.gray20),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: HarvestCalculatorDesignConstants.gray20),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ),
            // Pond count
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                '${ponds.length} kolam',
                style: HarvestCalculatorDesignConstants.bodyTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Pond list
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 16),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final pond = ponds[index];
                    final isSelected = pond == _selectedPond;

                    return _RegisteredPondTile(
                      pond: pond,
                      isSelected: isSelected,
                      onTap: () => _onSelect(pond),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: ponds.length,
                ),
              ),
            ),
            const Divider(height: 1, thickness: 1, color: HarvestCalculatorDesignConstants.gray20),
            // Save button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _selectedPond == null ? null : _handleSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          HarvestCalculatorDesignConstants.primaryBlue,
                      foregroundColor: HarvestCalculatorDesignConstants.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: const Text(
                      HarvestCalculatorConstants.buttonSave,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegisteredPondTile extends StatelessWidget {
  const _RegisteredPondTile({
    required this.pond,
    required this.isSelected,
    required this.onTap,
  });

  final PondOption pond;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? HarvestCalculatorDesignConstants
                      .simulationCardIconBackgroundBlue
                : HarvestCalculatorDesignConstants.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? HarvestCalculatorDesignConstants.primaryBlue
                  : HarvestCalculatorDesignConstants.gray20,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pond.name,
                      style: HarvestCalculatorDesignConstants
                          .sectionTitleTextStyle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${pond.id}',
                      style: HarvestCalculatorDesignConstants
                          .smallTextSecondaryStyle,
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected
                    ? HarvestCalculatorDesignConstants.primaryBlue
                    : HarvestCalculatorDesignConstants.gray40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
