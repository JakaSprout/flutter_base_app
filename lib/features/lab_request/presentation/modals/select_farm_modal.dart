import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:flutter/material.dart';

/// Modal bottom sheet for selecting a farm.
///
/// Pattern follows harvest_calculator's select_registered_pond_modal.dart
class SelectFarmModal extends StatefulWidget {
  /// Creates a new instance of [SelectFarmModal].
  const SelectFarmModal({required this.onSave, this.initialValue, super.key});

  /// Currently selected farm.
  final String? initialValue;

  /// Callback when save button is pressed.
  final ValueChanged<String> onSave;

  @override
  State<SelectFarmModal> createState() => _SelectFarmModalState();
}

class _SelectFarmModalState extends State<SelectFarmModal> {
  late String? _selectedFarm;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  // TODO(lab): Replace with actual farm data from provider
  final List<Map<String, String>> _mockFarms = [
    {'name': 'Farm A', 'id': '123123'},
    {'name': 'Farm B', 'id': '456456'},
    {'name': 'Farm C', 'id': '456456'},
    {'name': 'Farm D', 'id': '456456'},
    {'name': 'Farm E', 'id': '456456'},
    {'name': 'Farm F', 'id': '456456'},
    {'name': 'Farm G', 'id': '456456'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedFarm = widget.initialValue;
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
    final selected = _selectedFarm;
    if (selected == null) return;

    widget.onSave(selected);
    Navigator.pop(context);
  }

  void _onSelect(String farmName) {
    setState(() {
      _selectedFarm = farmName;
    });
  }

  List<Map<String, String>> _filteredFarms() {
    if (_query.isEmpty) return _mockFarms;
    final lowerQuery = _query.toLowerCase();
    return _mockFarms
        .where(
          (farm) =>
              farm['name']!.toLowerCase().contains(lowerQuery) ||
              farm['id']!.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredFarms = _filteredFarms();

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
                          'Pilih Farm',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: LabRequestDesignConstants.gray100,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Tentukan Farm Terdaftar pilihanmu.',
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
                    hintText: 'Cari Nama Farm Terdaftar atau ID',
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
            // Farm count
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                '${filteredFarms.length} Farm',
                style: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: LabRequestDesignConstants.gray100,
                ),
              ),
            ),
            // Farm list
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: filteredFarms.isEmpty
                    ? const _EmptyState()
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 16),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final farm = filteredFarms[index];
                          final isSelected = farm['name'] == _selectedFarm;

                          return _FarmTile(
                            farmName: farm['name']!,
                            farmId: farm['id']!,
                            isSelected: isSelected,
                            onTap: () => _onSelect(farm['name']!),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemCount: filteredFarms.length,
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
                    onPressed: _selectedFarm == null ? null : _handleSave,
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

class _FarmTile extends StatelessWidget {
  const _FarmTile({
    required this.farmName,
    required this.farmId,
    required this.isSelected,
    required this.onTap,
  });

  final String farmName;
  final String farmId;
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
                      farmName,
                      style: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: LabRequestDesignConstants.gray100,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: $farmId',
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
          Text('Belum ada farm terdaftar.'),
        ],
      ),
    );
  }
}
