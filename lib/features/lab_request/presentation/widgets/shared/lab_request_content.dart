import 'package:app_mobile_afms/features/lab_request/domain/entities/lab_request.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/buttons/lab_request_action_chips.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/forms/lab_request_search_field.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/lab_request_list_item.dart';
import 'package:flutter/material.dart';

/// Content widget for displaying lab requests with search, filter, and list.
class LabRequestContent extends StatelessWidget {
  /// Creates a new instance of [LabRequestContent].
  const LabRequestContent({
    required this.requests,
    super.key,
    this.onSearchChanged,
    this.searchController,
    this.onFilterTap,
    this.onResetFilterTap,
    this.onSortTap,
    this.filterCount = 0,
  });

  /// List of lab requests to display.
  final List<LabRequest> requests;

  /// Callback when search text changes.
  final ValueChanged<String>? onSearchChanged;

  /// Controller for search field.
  final TextEditingController? searchController;

  /// Callback when filter is tapped.
  final VoidCallback? onFilterTap;

  /// Callback when reset filter is tapped.
  final VoidCallback? onResetFilterTap;

  /// Callback when sort is tapped.
  final VoidCallback? onSortTap;

  /// Number of active filters.
  final int filterCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LabRequestSearchField(
          onChanged: onSearchChanged,
          controller: searchController,
        ),
        LabRequestActionChips(
          onFilterTap: onFilterTap,
          onSortTap: onSortTap,
          onResetFilterTap: onResetFilterTap,
          filterCount: filterCount,
        ),
        Expanded(
          child: requests.isEmpty
              ? const Center(
                  child: Text('Belum ada request yang dikirim'),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: requests.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return LabRequestListItem(request: request);
                  },
                ),
        ),
      ],
    );
  }
}
