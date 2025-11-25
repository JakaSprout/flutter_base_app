import 'package:app_mobile_afms/core/utils/status_bar_config.dart';
import 'package:app_mobile_afms/design_system/components/buttons/stp_bottom_action_button.dart';
import 'package:app_mobile_afms/design_system/components/buttons/stp_choice_chip_button.dart';
import 'package:app_mobile_afms/design_system/components/navigation/stp_app_bar.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/modals/select_pond_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddSampleScreen extends HookWidget {
  const AddSampleScreen({super.key, this.initialValue});

  final Map<String, dynamic>? initialValue;

  static const List<String> _anamnesaOptions = ['Diagnostik', 'Screening'];
  static const List<String> _jenisTesOptions = [
    'PCR Konvensional',
    'PCR Pockit',
    'PCR Realtime',
    'Kualitas Air',
  ];
  static const List<String> _jenisSampelOptions = [
    'Air',
    'Lumpur',
    'Udang',
    'Ikan',
    'Pakan',
    'Biota Liar',
    'Pakan Alami',
    'Benur',
  ];
  static const List<String> _jenisDataOptions = [
    'Salinitas',
    'pH',
    'NO2',
    'NH4+',
    'PO4',
    'Fe',
    'N/P',
    'ORP',
    'Alkanitas CO',
    'Alkanitas HCO',
    'Hardness Ca',
    'Hardness Mg',
    'TOM',
    'TVC',
    'TBC',
    '%TVC',
    'Jum. Plankton',
  ];

  @override
  Widget build(BuildContext context) {
    StatusBarConfig.setDarkStatusBar();

    // Form definition
    final form = useMemoized(() {
      final group = FormGroup({
        'pond': FormControl<String>(
          value: initialValue?['pond'] as String?,
          validators: [Validators.required],
        ),
        'doc': FormControl<String>(
          value: initialValue?['doc'] as String?,
          validators: [Validators.required],
        ),
        'anamnesa': FormControl<String>(
          value: initialValue?['anamnesa'] as String?,
          validators: [Validators.required],
        ),
        'testType': FormControl<String>(
          value: initialValue?['testType'] as String?,
          validators: [Validators.required],
        ),
        'sampleType': FormControl<String>(
          value: initialValue?['sampleType'] as String?,
          validators: [Validators.required],
        ),
        'dataTypes': FormArray<String>(
          (initialValue?['dataTypes'] as List<dynamic>?)
                  ?.map((e) => FormControl<String>(value: e as String))
                  .toList() ??
              [],
          validators: [Validators.minLength(1)],
        ),
        'notes': FormControl<String>(value: initialValue?['notes'] as String?),
      });
      return group;
    }, [initialValue]);

    useEffect(() {
      return form.dispose;
    }, [form]);

    // Handle pond selection tap
    void handlePondTap() {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SelectPondModal(
            initialValue: form.control('pond').value as String?,
            onSave: (pondName) {
              form.control('pond').value = pondName;
            },
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: LabRequestDesignConstants.white,
      appBar: const STPAppBar(title: 'Tambah Sampel'),
      body: SafeArea(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: ReactiveFormConsumer(
                    builder: (context, form, child) {
                      // Check if required fields are filled
                      final pond = form.control('pond').value;
                      final doc = form.control('doc').value;
                      final anamnesa = form.control('anamnesa').value;
                      final testType = form.control('testType').value;

                      final isBasicInfoFilled =
                          pond != null &&
                          doc != null &&
                          anamnesa != null &&
                          testType != null;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader('Informasi'),
                          const SizedBox(height: 16),

                          // Kolam/Petak Custom Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    '*',
                                    style: TextStyle(
                                      color: Color(0xFFD84639),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    'Kolam/Petak',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: LabRequestDesignConstants.gray100,
                                      fontFamily: 'Open Sans',
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: handlePondTap,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: LabRequestDesignConstants.gray20,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        form.control('pond').value as String? ??
                                            'Pilih Kolam/Petak',
                                        style: TextStyle(
                                          fontFamily: 'Open Sans',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              form.control('pond').value != null
                                              ? LabRequestDesignConstants
                                                    .gray100
                                              : LabRequestDesignConstants
                                                    .gray60,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: LabRequestDesignConstants.gray60,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Error message if touched and invalid
                              StreamBuilder<ControlStatus>(
                                stream: form.control('pond').statusChanged,
                                builder: (context, snapshot) {
                                  final control = form.control('pond');
                                  if (control.touched && control.invalid) {
                                    return const Padding(
                                      padding: EdgeInsets.only(top: 4, left: 4),
                                      child: Text(
                                        'Kolam/Petak wajib diisi',
                                        style: TextStyle(
                                          color: Color(0xFFD84639),
                                          fontSize: 12,
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // DOC
                          _buildTextField(
                            context,
                            formControlName: 'doc',
                            label: 'DOC',
                            hint: 'DOC',
                            isRequired: true,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),

                          // Anamnesa
                          _buildSelectionGroup(
                            context,
                            label: 'Anamnesa',
                            options: _anamnesaOptions,
                            formControlName: 'anamnesa',
                            isRequired: true,
                            hasInfoIcon: true,
                          ),
                          const SizedBox(height: 16),

                          // Jenis Tes
                          _buildSelectionGroup(
                            context,
                            label: 'Jenis Tes',
                            options: _jenisTesOptions,
                            formControlName: 'testType',
                            isRequired: true,
                            hasInfoIcon: true,
                          ),

                          // Disabled Section (Opacity + AbsorbPointer)
                          Opacity(
                            opacity: isBasicInfoFilled ? 1.0 : 0.5,
                            child: AbsorbPointer(
                              absorbing: !isBasicInfoFilled,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 24),
                                  const Divider(
                                    height: 1,
                                    color: LabRequestDesignConstants.gray20,
                                  ),
                                  const SizedBox(height: 24),

                                  // Jenis Sampel
                                  _buildSectionHeader('Jenis Sampel'),
                                  const SizedBox(height: 16),
                                  _buildSelectionGroup(
                                    context,
                                    options: _jenisSampelOptions,
                                    formControlName: 'sampleType',
                                  ),
                                  const SizedBox(height: 24),

                                  // Jenis Data
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildSectionHeader('Jenis Data'),
                                      // Checkbox placeholder (if needed)
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: LabRequestDesignConstants
                                                .gray20,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  _buildMultiSelectionGroup(
                                    context,
                                    options: _jenisDataOptions,
                                    formArrayName: 'dataTypes',
                                  ),
                                  const SizedBox(height: 24),

                                  // Catatan
                                  _buildSectionHeader('Catatan'),
                                  const SizedBox(height: 16),
                                  _buildTextArea(
                                    context,
                                    formControlName: 'notes',
                                    hint: 'Cth: Sampel dibungkus plastik.',
                                  ),
                                  const SizedBox(height: 8),
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '22/200', // TODO: Implement char count
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: LabRequestDesignConstants.gray60,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              // Bottom Action - Always show but disabled if not valid/filled
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  final pond = form.control('pond').value;
                  final doc = form.control('doc').value;
                  final anamnesa = form.control('anamnesa').value;
                  final testType = form.control('testType').value;

                  final isBasicInfoFilled =
                      pond != null &&
                      doc != null &&
                      anamnesa != null &&
                      testType != null;

                  final dataTypes =
                      form.control('dataTypes') as FormArray<String>;
                  final count = dataTypes.value?.length ?? 0;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            '$count Jenis Data terpilih',
                            style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: LabRequestDesignConstants.gray100,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        STPBottomActionButton(
                          text: 'Tambah',
                          // Button enabled only if basic info filled AND form valid
                          enabled: isBasicInfoFilled && form.valid,
                          backgroundColor: LabRequestDesignConstants.primary,
                          height: LabRequestDesignConstants.buttonHeight,
                          borderRadius:
                              LabRequestDesignConstants.buttonBorderRadius,
                          fontSize: LabRequestDesignConstants.buttonFontSize,
                          onPressed: () {
                            // Return form value
                            Navigator.pop(context, form.value);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Open Sans',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: LabRequestDesignConstants.gray100,
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String formControlName,
    required String label,
    required String hint,
    bool isRequired = false,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isRequired) ...[
              const Text(
                '*',
                style: TextStyle(
                  color: Color(0xFFD84639),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 2),
            ],
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: LabRequestDesignConstants.gray100,
                fontFamily: 'Open Sans',
                height: 1.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ReactiveTextField<String>(
          formControlName: formControlName,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: LabRequestDesignConstants.gray60,
              fontSize: 14,
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextArea(
    BuildContext context, {
    required String formControlName,
    required String hint,
  }) {
    return ReactiveTextField<String>(
      formControlName: formControlName,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: LabRequestDesignConstants.gray60,
          fontSize: 14,
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 12, right: 8, top: 12),
          child: Align(
            alignment: Alignment.topLeft,
            widthFactor: 1,
            heightFactor: 1,
            child: Icon(
              Icons.description_outlined,
              size: 20,
              color: LabRequestDesignConstants.gray60,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: LabRequestDesignConstants.gray20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: LabRequestDesignConstants.gray20),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildSelectionGroup(
    BuildContext context, {
    required List<String> options,
    required String formControlName,
    String? label,
    bool isRequired = false,
    bool hasInfoIcon = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            children: [
              if (isRequired) ...[
                const Text(
                  '*',
                  style: TextStyle(
                    color: Color(0xFFD84639),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 2),
              ],
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: LabRequestDesignConstants.gray100,
                  fontFamily: 'Open Sans',
                  height: 1.4,
                ),
              ),
              if (hasInfoIcon) ...[
                const SizedBox(width: 4),
                const Icon(
                  Icons.info_outline,
                  size: 14,
                  color: Color(0xFFFF6B18), // Orange info icon
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
        ],
        ReactiveValueListenableBuilder<String>(
          formControlName: formControlName,
          builder: (context, control, child) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: options.map((option) {
                return STPChoiceChipButton(
                  label: option,
                  isSelected: control.value == option,
                  onTap: () {
                    control.value = option;
                  },
                  borderRadius: 20,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMultiSelectionGroup(
    BuildContext context, {
    required List<String> options,
    required String formArrayName,
  }) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final formArray = form.control(formArrayName) as FormArray<String>;
        final selectedValues =
            formArray.value?.whereType<String>().toList() ?? [];

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selectedValues.contains(option);
            return STPChoiceChipButton(
              label: option,
              isSelected: isSelected,
              onTap: () {
                if (isSelected) {
                  formArray.remove(FormControl<String>(value: option));
                } else {
                  formArray.add(FormControl<String>(value: option));
                }
              },
              borderRadius: 20,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          }).toList(),
        );
      },
    );
  }
}
