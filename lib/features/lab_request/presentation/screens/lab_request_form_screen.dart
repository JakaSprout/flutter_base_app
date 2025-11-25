import 'package:app_mobile_afms/core/utils/status_bar_config.dart';
import 'package:app_mobile_afms/design_system/components/buttons/stp_bottom_action_button.dart';
import 'package:app_mobile_afms/design_system/components/forms/stp_date_picker.dart';
import 'package:app_mobile_afms/design_system/components/navigation/stp_app_bar.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_form_controls.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/hooks/use_lab_request_form.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/modals/select_farm_modal.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/screens/add_sample_screen.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/sections/farm_info_section.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/sections/sample_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Lab request form screen (redesigned with reactive forms).
///
/// Simplified form with:
/// - Farm success info banner
/// - Farm information section (farm + date)
/// - Sample section (add sample button)
///
/// Uses reactive_forms for state management following harvest_calculator pattern.
class LabRequestFormScreen extends HookConsumerWidget {
  /// Creates a new instance of [LabRequestFormScreen].
  const LabRequestFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use custom form hook (follows harvest_calculator pattern)
    final form = useLabRequestForm();
    final isLoading = useState(false);

    // Set status bar for light background
    useEffect(() {
      StatusBarConfig.setLightStatusBar();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        StatusBarConfig.setLightStatusBar();
      });
      return null;
    }, []);

    // Handle form submission
    Future<void> handleSubmit() async {
      // Mark form as touched to show validation errors
      form.markAllAsTouched();

      if (!form.valid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mohon lengkapi semua field yang required'),
          ),
        );
        return;
      }

      isLoading.value = true;

      try {
        // TODO(lab): Implement lab request submission
        await Future<void>.delayed(const Duration(seconds: 1));

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Request berhasil dibuat'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
          );
        }
      } finally {
        isLoading.value = false;
      }
    }

    // Handle farm selection tap
    void handleFarmTap() {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SelectFarmModal(
            initialValue:
                form.control(LabRequestFormControls.selectedFarm).value
                    as String?,
            onSave: (farmName) {
              // Update form control value
              form.control(LabRequestFormControls.selectedFarm).value =
                  farmName;
            },
          );
        },
      );
    }

    // Handle date selection tap
    void handleDateTap() {
      final currentDate =
          form.control(LabRequestFormControls.sendDate).value as DateTime?;

      showSTPDatePicker(
        context: context,
        initialDate: currentDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      ).then((date) {
        if (date != null) {
          // Update form control value
          form.control(LabRequestFormControls.sendDate).value = date;
        }
      });
    }

    // Handle add sample tap
    Future<void> handleAddSampleTap() async {
      final result = await Navigator.push<Map<String, dynamic>>(
        context,
        MaterialPageRoute(builder: (context) => const AddSampleScreen()),
      );

      if (result != null) {
        final samplesArray =
            form.control(LabRequestFormControls.samples) as FormArray;
        samplesArray.add(FormControl<Map<String, dynamic>>(value: result));
      }
    }

    // Handle edit sample
    Future<void> handleEditSample(int index, Map<String, dynamic> data) async {
      final result = await Navigator.push<Map<String, dynamic>>(
        context,
        MaterialPageRoute(
          builder: (context) => AddSampleScreen(initialValue: data),
        ),
      );

      if (result != null) {
        final samplesArray =
            form.control(LabRequestFormControls.samples) as FormArray;
        samplesArray.control('$index').value = result;
      }
    }

    // Handle duplicate sample
    void handleDuplicateSample(int index, Map<String, dynamic> data) {
      final samplesArray =
          form.control(LabRequestFormControls.samples) as FormArray;
      samplesArray.add(FormControl<Map<String, dynamic>>(value: data));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Duplikat Sampel'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }

    // Handle delete sample
    void handleDeleteSample(int index) {
      final samplesArray =
          form.control(LabRequestFormControls.samples) as FormArray;
      samplesArray.removeAt(index);
    }

    return Scaffold(
      backgroundColor: LabRequestDesignConstants.backgroundColor,
      appBar: const STPAppBar(title: LabRequestConstants.formTitle),
      body: SafeArea(
        child: ReactiveForm(
          formGroup: form,
          child: ReactiveFormConsumer(
            builder: (context, formGroup, child) {
              // Check if farm is selected to enable sample section
              final selectedFarm =
                  formGroup.control(LabRequestFormControls.selectedFarm).value
                      as String?;

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: LabRequestDesignConstants.spacingMedium,
                          ),
                          // Farm Success Info Banner
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: LabRequestDesignConstants
                                  .screenHorizontalPadding,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: LabRequestDesignConstants.gray05,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    LabRequestConstants.farmSuksesBersama,
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: LabRequestDesignConstants.gray100,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    LabRequestConstants.senderNameLabel(
                                      'Danang Winayo',
                                    ),
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
                          ),
                          const SizedBox(
                            height: LabRequestDesignConstants.spacingLarge,
                          ),
                          // Informasi Farm Section
                          FarmInfoSection(
                            sectionTitle:
                                LabRequestConstants.sectionInformasiFarm,
                            farmLabel: LabRequestConstants.labelFarm,
                            dateLabel: LabRequestConstants.labelTanggalKirim,
                            onFarmTap: handleFarmTap,
                            onDateTap: handleDateTap,
                          ),
                          const SizedBox(
                            height: LabRequestDesignConstants.spacingLarge,
                          ),
                          // Sampel Section
                          SampleSection(
                            sectionTitle: LabRequestConstants.sectionSampel,
                            buttonText: LabRequestConstants.buttonAddSampel,
                            onAddSampleTap: handleAddSampleTap,
                            onEditSample: handleEditSample,
                            onDuplicateSample: handleDuplicateSample,
                            onDeleteSample: handleDeleteSample,
                            isActive: selectedFarm != null,
                          ),
                          const SizedBox(
                            height: LabRequestDesignConstants.spacingLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Bottom Button
                  STPBottomActionButton(
                    text: LabRequestConstants.formTitle,
                    isLoading: isLoading.value,
                    enabled: !isLoading.value,
                    backgroundColor: LabRequestDesignConstants.primary,
                    height: LabRequestDesignConstants.buttonHeight,
                    borderRadius: LabRequestDesignConstants.buttonBorderRadius,
                    fontSize: LabRequestDesignConstants.buttonFontSize,
                    onPressed: handleSubmit,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
