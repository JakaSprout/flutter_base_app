import 'package:app_mobile_afms/design_system/components/navigation/stp_app_bar.dart';
import 'package:app_mobile_afms/features/lab_request/domain/entities/lab_request.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/modals/lab_request_filter_modal.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/modals/lab_request_filter_options.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/modals/lab_request_sort_modal.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/providers/lab_request_provider.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/shared/lab_request_content.dart';
import 'package:app_mobile_afms/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Lab request list screen.
///
/// Displays a list of submitted lab requests with search, filter, and sort functionality.
class LabRequestListScreen extends ConsumerStatefulWidget {
  /// Creates a new instance of [LabRequestListScreen].
  const LabRequestListScreen({super.key});

  @override
  ConsumerState<LabRequestListScreen> createState() =>
      _LabRequestListScreenState();
}

class _LabRequestListScreenState extends ConsumerState<LabRequestListScreen> {
  String _searchQuery = '';
  String _currentSort = LabRequestConstants.sortDateNewest;
  LabRequestFilterOptions _filterOptions = LabRequestFilterOptions();

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _onResetFilters() {
    setState(() {
      _filterOptions = LabRequestFilterOptions();
    });
  }

  Future<void> _onSortTap() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => LabRequestSortModal(currentSort: _currentSort),
    );

    if (result != null) {
      setState(() {
        _currentSort = result;
      });
    }
  }

  Future<void> _onFilterTap() async {
    final result = await showModalBottomSheet<LabRequestFilterOptions>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) =>
          LabRequestFilterModal(currentOptions: _filterOptions),
    );

    if (result != null) {
      setState(() {
        _filterOptions = result;
      });
    }
  }

  /// Converts domain entities and filters/sorts them.
  List<LabRequest> _filterAndSortRequests(List<LabRequest> requests) {
    var filtered = requests;

    // Search
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((request) {
        final searchTerm = _searchQuery.toLowerCase();
        return request.namaPengirim.toLowerCase().contains(searchTerm) ||
            request.customer.toLowerCase().contains(searchTerm) ||
            request.tambakAsal.toLowerCase().contains(searchTerm) ||
            request.id.toLowerCase().contains(searchTerm);
      }).toList();
    }

    // Filter by date
    if (_filterOptions.startDate != null) {
      filtered = filtered.where((request) {
        final requestDate = request.tanggalRequest ?? request.tanggalPengiriman;
        return requestDate.isAfter(
          _filterOptions.startDate!.subtract(const Duration(seconds: 1)),
        );
      }).toList();
    }

    if (_filterOptions.endDate != null) {
      filtered = filtered.where((request) {
        final requestDate = request.tanggalRequest ?? request.tanggalPengiriman;
        return requestDate.isBefore(
          _filterOptions.endDate!.add(const Duration(days: 1)),
        );
      }).toList();
    }

    // Filter by status
    if (_filterOptions.statuses.isNotEmpty) {
      filtered = filtered.where((request) {
        return request.status != null &&
            _filterOptions.statuses.contains(request.status);
      }).toList();
    }

    // Sort
    filtered.sort((a, b) {
      switch (_currentSort) {
        case LabRequestConstants.sortDateNewest:
          final aDate = a.tanggalRequest ?? a.tanggalPengiriman;
          final bDate = b.tanggalRequest ?? b.tanggalPengiriman;
          return bDate.compareTo(aDate);
        case LabRequestConstants.sortDateOldest:
          final aDate = a.tanggalRequest ?? a.tanggalPengiriman;
          final bDate = b.tanggalRequest ?? b.tanggalPengiriman;
          return aDate.compareTo(bDate);
        case LabRequestConstants.sortStatus:
          // Sort by status enum order (dikirim, diproses, selesai, ditolak)
          final aStatus = a.status;
          final bStatus = b.status;
          if (aStatus == null && bStatus == null) return 0;
          if (aStatus == null) return 1;
          if (bStatus == null) return -1;
          return aStatus.index.compareTo(bStatus.index);
        case LabRequestConstants.sortCustomerAZ:
          return a.customer.compareTo(b.customer);
        case LabRequestConstants.sortCustomerZA:
          return b.customer.compareTo(a.customer);
        default:
          return 0;
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    // Watch lab request list provider
    final labRequestListAsync = ref.watch(labRequestListDataProvider());

    return Scaffold(
      backgroundColor: LabRequestDesignConstants.white,
      appBar: STPAppBar(
        title: LabRequestConstants.screenTitle,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.help_outline,
              color: LabRequestDesignConstants.gray100,
            ),
            onPressed: () {
              // TODO: Show help
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: LabRequestDesignConstants.gray100,
            ),
            onPressed: () {
              context.push(Routes.labRequestForm);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: labRequestListAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
          data: (data) {
            final filteredRequests = _filterAndSortRequests(data.requests);

            return LabRequestContent(
              requests: filteredRequests,
              onSearchChanged: _onSearchChanged,
              onSortTap: _onSortTap,
              onFilterTap: _onFilterTap,
              onResetFilterTap: _onResetFilters,
              filterCount: _filterOptions.count,
            );
          },
        ),
      ),
    );
  }
}
