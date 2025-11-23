import 'package:app_mobile_afms/core/utils/status_bar_config.dart';
import 'package:app_mobile_afms/core/utils/validators/input_validators.dart';
import 'package:app_mobile_afms/design_system/components/buttons/stp_bottom_action_button.dart';
import 'package:app_mobile_afms/design_system/components/forms/stp_dropdown_form_field.dart';
import 'package:app_mobile_afms/design_system/components/forms/stp_info_banner.dart';
import 'package:app_mobile_afms/design_system/components/navigation/stp_app_bar.dart';
import 'package:app_mobile_afms/features/lab_request/domain/entities/anamnesa_type.dart';
import 'package:app_mobile_afms/features/lab_request/domain/entities/lab_request.dart';
import 'package:app_mobile_afms/features/lab_request/domain/entities/testing_type.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/providers/lab_request_provider.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/date_picker_form_field.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/radio_button_group.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/text_area_form_field.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

/// Lab request form screen.
///
/// Allows users to create a new lab request by filling in required information.
class LabRequestFormScreen extends HookConsumerWidget {
  /// Creates a new instance of [LabRequestFormScreen].
  const LabRequestFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Form controllers
    final noTelpController = useTextEditingController();
    final emailController = useTextEditingController();
    final keteranganSampelController = useTextEditingController();

    // Form state
    final selectedNamaPengirim = useState<String?>(null);
    final selectedTambakAsal = useState<String?>(null);
    final selectedCustomer = useState<String?>(null);
    final selectedAnamnesa = useState<AnamnesaType?>(null);
    final selectedTestingType = useState<TestingType?>(null);
    final selectedTanggalPengiriman = useState<DateTime?>(null);
    final isLoading = useState(false);

    // Mock data for dropdowns (TODO: Replace with actual API data)
    final namaPengirimOptions = [
      'John Doe',
      'Jane Smith',
      'Bob Johnson',
      'Alice Williams',
    ];
    final tambakAsalOptions = [
      'Tambak A1',
      'Tambak A2',
      'Tambak B1',
      'Tambak B2',
      'Tambak C1',
    ];
    final customerOptions = [
      'Customer A',
      'Customer B',
      'Customer C',
      'Customer D',
    ];

    // Form validation
    final formKey = useMemoized(GlobalKey<FormState>.new);

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
      if (!formKey.currentState!.validate()) {
        return;
      }

      if (selectedNamaPengirim.value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pilih Nama Pengirim terlebih dahulu')),
        );
        return;
      }

      if (selectedTambakAsal.value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pilih Tambak Asal terlebih dahulu')),
        );
        return;
      }

      if (selectedCustomer.value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pilih Customer terlebih dahulu')),
        );
        return;
      }

      if (selectedAnamnesa.value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pilih Anamnesa terlebih dahulu')),
        );
        return;
      }

      if (selectedTestingType.value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pilih Jenis Testing terlebih dahulu')),
        );
        return;
      }

      if (selectedTanggalPengiriman.value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pilih Tanggal Pengiriman terlebih dahulu'),
          ),
        );
        return;
      }

      isLoading.value = true;

      try {
        final request = LabRequest(
          id: const Uuid().v4(),
          namaPengirim: selectedNamaPengirim.value!,
          noTelp: noTelpController.text.trim(),
          email: emailController.text.trim(),
          tambakAsal: selectedTambakAsal.value!,
          customer: selectedCustomer.value!,
          tanggalPengiriman: selectedTanggalPengiriman.value!,
          anamnesa: selectedAnamnesa.value!,
          keteranganSampel: keteranganSampelController.text.trim(),
          jenisTesting: selectedTestingType.value!,
        );

        await ref.read(submitLabRequestProvider(request).future);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Request berhasil dibuat'),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
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

    return Scaffold(
      backgroundColor: LabRequestDesignConstants.backgroundColor,
      appBar: const STPAppBar(title: LabRequestConstants.formTitle),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(
                    LabRequestDesignConstants.screenHorizontalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Sender Details Section
                      STPDropdownFormField<String>(
                        label: LabRequestConstants.fieldNamaPengirim,
                        items: namaPengirimOptions,
                        selectedValue: selectedNamaPengirim.value,
                        onChanged: (value) {
                          selectedNamaPengirim.value = value;
                        },
                        isRequired: true,
                        hint: LabRequestConstants.hintNamaPengirim,
                      ),
                      const SizedBox(
                        height: LabRequestDesignConstants.spacingMedium,
                      ),
                      LabRequestTextFormField(
                        controller: noTelpController,
                        label: LabRequestConstants.fieldNoTelp,
                        hint: LabRequestConstants.hintNoTelp,
                        keyboardType: TextInputType.phone,
                        validator: InputValidators.phone,
                      ),
                      const SizedBox(
                        height: LabRequestDesignConstants.spacingMedium,
                      ),
                      LabRequestTextFormField(
                        controller: emailController,
                        label: LabRequestConstants.fieldEmail,
                        hint: LabRequestConstants.hintEmail,
                        keyboardType: TextInputType.emailAddress,
                        validator: InputValidators.email,
                      ),
                      const SizedBox(
                        height: LabRequestDesignConstants.spacingMedium,
                      ),
                      STPDropdownFormField<String>(
                        label: LabRequestConstants.fieldTambakAsal,
                        items: tambakAsalOptions,
                        selectedValue: selectedTambakAsal.value,
                        onChanged: (value) {
                          selectedTambakAsal.value = value;
                        },
                        isRequired: true,
                        hint: LabRequestConstants.hintTambakAsal,
                      ),
                      const SizedBox(
                        height: LabRequestDesignConstants.spacingMedium,
                      ),
                      STPDropdownFormField<String>(
                        label: LabRequestConstants.fieldCustomer,
                        items: customerOptions,
                        selectedValue: selectedCustomer.value,
                        onChanged: (value) {
                          selectedCustomer.value = value;
                        },
                        isRequired: true,
                        hint: LabRequestConstants.hintCustomer,
                      ),
                      const SizedBox(
                        height: LabRequestDesignConstants.spacingMedium,
                      ),
                      // Date and Time in Row
                      Row(
                        children: [
                          Expanded(
                            child: LabRequestDatePickerFormField(
                              key: const ValueKey('tanggal_picker'),
                              label: 'Tanggal',
                              selectedDate: selectedTanggalPengiriman.value,
                              onDateSelected: (date) {
                                if (date != null) {
                                  final existingTime =
                                      selectedTanggalPengiriman.value;
                                  selectedTanggalPengiriman.value = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    existingTime?.hour ?? 0,
                                    existingTime?.minute ?? 0,
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: LabRequestDesignConstants.spacingMedium,
                          ),
                          Expanded(
                            child: LabRequestDatePickerFormField(
                              key: const ValueKey('waktu_picker'),
                              label: 'Waktu',
                              selectedDate: selectedTanggalPengiriman.value,
                              onDateSelected: (date) {
                                selectedTanggalPengiriman.value = date;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: LabRequestDesignConstants.spacingLarge,
                      ),
                      // Anamnesa Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          LabRequestRadioButtonGroup<AnamnesaType>(
                            label: LabRequestConstants.fieldAnamnesa,
                            options: AnamnesaType.values,
                            selectedValue: selectedAnamnesa.value,
                            onChanged: (value) {
                              selectedAnamnesa.value = value;
                            },
                            displayText: (value) => value.displayName,
                          ),
                          const SizedBox(
                            height: LabRequestDesignConstants.spacingLarge,
                          ),
                          LabRequestTextAreaFormField(
                            controller: keteranganSampelController,
                            label: LabRequestConstants.fieldKeteranganSampel,
                            hint: LabRequestConstants.hintKeteranganSampel,
                          ),
                          const SizedBox(
                            height: LabRequestDesignConstants.spacingLarge,
                          ),
                          LabRequestRadioButtonGroup<TestingType>(
                            label: LabRequestConstants.fieldJenisTesting,
                            options: TestingType.values,
                            selectedValue: selectedTestingType.value,
                            onChanged: (value) {
                              selectedTestingType.value = value;
                            },
                            displayText: (value) => value.displayName,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: LabRequestDesignConstants.spacingMedium,
                      ),
                      // Information Banner
                      const STPInfoBanner(
                        message:
                            'Pastikan semua informasi yang diisi sudah benar sebelum submit',
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
                text: LabRequestConstants.buttonSubmit,
                isLoading: isLoading.value,
                enabled: !isLoading.value,
                onPressed: handleSubmit,
                child: isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: LabRequestDesignConstants.white,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
