import 'package:flutter/material.dart';
import 'package:app_mobile_afms/core/utils/status_bar_config.dart';
import 'package:app_mobile_afms/design_system/components/buttons/stp_bottom_action_button.dart';
import 'package:app_mobile_afms/design_system/components/navigation/stp_app_bar.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/providers/lab_request_provider.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/date_picker_field.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/lab_request_list_item.dart';
import 'package:app_mobile_afms/router/routes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Lab request list screen.
///
/// Displays a list of submitted lab requests with filter functionality.
class LabRequestListScreen extends HookConsumerWidget {
  /// Creates a new instance of [LabRequestListScreen].
  const LabRequestListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Filter state
    final startDate = useState<DateTime?>(null);
    final endDate = useState<DateTime?>(null);
    final showFilter = useState(false);

    // Watch lab request list provider
    final labRequestListAsync = ref.watch(
      labRequestListDataProvider(
        startDate: startDate.value,
        endDate: endDate.value,
      ),
    );

    // Set status bar for light background
    useEffect(() {
      StatusBarConfig.setLightStatusBar();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        StatusBarConfig.setLightStatusBar();
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: LabRequestDesignConstants.white,
      appBar: STPAppBar(
        title: LabRequestConstants.screenTitle,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => showFilter.value = !showFilter.value,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Filter section
            if (showFilter.value)
              Container(
                padding: const EdgeInsets.all(
                  LabRequestDesignConstants.screenHorizontalPadding,
                ),
                color: LabRequestDesignConstants.gray05,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LabRequestConstants.filterLabel,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: LabRequestDesignConstants.spacingSmall,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: LabRequestDatePickerField(
                            label: LabRequestConstants.filterTanggalRequest,
                            selectedDate: startDate.value,
                            onDateSelected: (date) {
                              startDate.value = date;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: LabRequestDesignConstants.spacingSmall,
                        ),
                        const Text(LabRequestConstants.filterTo),
                        const SizedBox(
                          width: LabRequestDesignConstants.spacingSmall,
                        ),
                        Expanded(
                          child: LabRequestDatePickerField(
                            label: '',
                            selectedDate: endDate.value,
                            onDateSelected: (date) {
                              endDate.value = date;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: LabRequestDesignConstants.spacingSmall,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Refresh the list with new filters
                          ref.invalidate(
                            labRequestListDataProvider(
                              startDate: startDate.value,
                              endDate: endDate.value,
                            ),
                          );
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            // List content
            Expanded(
              child: labRequestListAsync.when(
                data: (data) {
                  if (data.requests.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.inbox_outlined,
                            size: 64,
                            color: LabRequestDesignConstants.gray70,
                          ),
                          const SizedBox(
                            height: LabRequestDesignConstants.spacingMedium,
                          ),
                          Text(
                            LabRequestConstants.emptyStateMessage,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: LabRequestDesignConstants.gray70),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(
                      LabRequestDesignConstants.screenHorizontalPadding,
                    ),
                    itemCount: data.requests.length,
                    itemBuilder: (context, index) {
                      final request = data.requests[index];
                      return LabRequestListItem(request: request);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: LabRequestDesignConstants.gray70,
                      ),
                      const SizedBox(
                        height: LabRequestDesignConstants.spacingMedium,
                      ),
                      Text(
                        'Error: $error',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: LabRequestDesignConstants.gray70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom Button - Request Baru
            STPBottomActionButton(
              onPressed: () {
                context.push(Routes.labRequestForm);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 20),
                  SizedBox(width: 8),
                  Text(
                    LabRequestConstants.buttonNewRequest,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
