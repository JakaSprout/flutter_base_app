import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:flutter/material.dart';

/// Modal bottom sheet for selecting a pond.
///
/// Pattern follows select_farm_modal.dart
class SelectPondModal extends StatefulWidget {
  /// Creates a new instance of [SelectPondModal].
  const SelectPondModal({required this.onSave, this.initialValue, super.key});

  /// Currently selected pond.
  final String? initialValue;

  /// Callback when save button is pressed.
  final ValueChanged<String> onSave;

  @override
  State<SelectPondModal> createState() => _SelectPondModalState();
}

class _SelectPondModalState extends State<SelectPondModal> {
  late String? _selectedPond;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  // TODO(lab): Replace with actual pond data from provider
  final List<Map<String, String>> _mockPonds = [
    {'name': '001 - Kolam A', 'id': 'P001'},
    {'name': '002 - Kolam A', 'id': 'P002'},
    {'name': '003 - Kolam B', 'id': 'P003'},
    {'name': '004 - Kolam B', 'id': 'P004'},
    {'name': '005 - Kolam C', 'id': 'P005'},
  ];

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

  void _onSelect(String pondName) {
    setState(() {
      _selectedPond = pondName;
    });
  }

  List<Map<String, String>> _filteredPonds() {
    if (_query.isEmpty) return _mockPonds;
    final lowerQuery = _query.toLowerCase();
    return _mockPonds
        .where(
          (pond) =>
              pond['name']!.toLowerCase().contains(lowerQuery) ||
              pond['id']!.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPonds = _filteredPonds();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: const BoxDecoration(
        color: LabRequestDesignConstants.white,
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
                  color: LabRequestDesignConstants.gray20,
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
                          'Pilih Kolam/Petak',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: LabRequestDesignConstants.gray100,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Tentukan Kolam/Petak pilihanmu.',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: LabRequestDesignConstants.gray70,
                          ),
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
                      color: LabRequestDesignConstants.gray60,
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
                    hintText: 'Cari Nama Kolam atau ID',
                    hintStyle: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: LabRequestDesignConstants.gray60,
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 12, right: 8),
                      child: Icon(
                        Icons.search,
                        size: 20,
                        color: LabRequestDesignConstants.gray70,
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minHeight: 20,
                      minWidth: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: LabRequestDesignConstants.gray20,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: LabRequestDesignConstants.gray20,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: LabRequestDesignConstants.gray20,
                      ),
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
                '${filteredPonds.length} Kolam',
                style: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: LabRequestDesignConstants.gray100,
                ),
              ),
            ),
            // Pond list
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: filteredPonds.isEmpty
                    ? const _EmptyState()
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 16),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final pond = filteredPonds[index];
                          final isSelected = pond['name'] == _selectedPond;

                          return _PondTile(
                            pondName: pond['name']!,
                            pondId: pond['id']!,
                            isSelected: isSelected,
                            onTap: () => _onSelect(pond['name']!),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemCount: filteredPonds.length,
                      ),
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: LabRequestDesignConstants.gray20,
            ),
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
                      backgroundColor: const Color(0xFF122E7A),
                      foregroundColor: LabRequestDesignConstants.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 56),
                      disabledBackgroundColor: LabRequestDesignConstants.gray20,
                      disabledForegroundColor: LabRequestDesignConstants.gray60,
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
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

class _PondTile extends StatelessWidget {
  const _PondTile({
    required this.pondName,
    required this.pondId,
    required this.isSelected,
    required this.onTap,
  });

  final String pondName;
  final String pondId;
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
                ? const Color(0xFFE8EDF7) // Light blue background
                : LabRequestDesignConstants.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF122E7A)
                  : LabRequestDesignConstants.gray20,
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
                      pondName,
                      style: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: LabRequestDesignConstants.gray100,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: $pondId',
                      style: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: LabRequestDesignConstants.gray70,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected
                    ? const Color(0xFF122E7A)
                    : LabRequestDesignConstants.gray20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(Icons.inbox_outlined, size: 36, color: Colors.grey),
          SizedBox(height: 8),
          Text('Belum ada kolam terdaftar.'),
        ],
      ),
    );
  }
}
