import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_form_controls.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Sample Section Widget (Reactive Form Version).
///
/// Displays the sample section with:
/// - Section header with orange indicator (SVG) and count badge
/// - List of added samples (editable, duplicatable, deletable)
/// - Add sample button
class SampleSection extends StatelessWidget {
  /// Creates a new instance of [SampleSection].
  const SampleSection({
    required this.sectionTitle,
    required this.buttonText,
    required this.onAddSampleTap,
    this.onEditSample,
    this.onDuplicateSample,
    this.onDeleteSample,
    this.isActive = true,
    super.key,
  });

  /// Section title text
  final String sectionTitle;

  /// Add sample button text
  final String buttonText;

  /// Callback when add sample button is tapped
  final VoidCallback onAddSampleTap;

  /// Callback when edit sample is tapped
  final void Function(int index, Map<String, dynamic> data)? onEditSample;

  /// Callback when duplicate sample is tapped
  final void Function(int index, Map<String, dynamic> data)? onDuplicateSample;

  /// Callback when delete sample is tapped
  final void Function(int index)? onDeleteSample;

  /// Whether section is active
  final bool isActive;

  // Design tokens
  static const double _indicatorWidth = 8;
  static const double _indicatorHeight = 14;
  static const double _gap = 12;
  static const double _screenHorizontalPadding = 20;

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final samplesArray =
            form.control(LabRequestFormControls.samples)
                as FormArray<Map<String, dynamic>>;
        final samples = samplesArray.value ?? [];
        final hasSamples = samples.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Opacity(
                    opacity: isActive ? 1.0 : 0.2,
                    child: SvgPicture.asset(
                      Assets.icons.general.sectionIndicator,
                      width: _indicatorWidth,
                      height: _indicatorHeight,
                    ),
                  ),
                  const SizedBox(width: _gap),
                  Text(
                    sectionTitle,
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      color: isActive
                          ? LabRequestDesignConstants.gray100
                          : LabRequestDesignConstants.gray60,
                    ),
                  ),
                  if (hasSamples && isActive) ...[
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: LabRequestDesignConstants.gray05,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        samples.length.toString(),
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: LabRequestDesignConstants.gray100,
                        ),
                      ),
                    ),
                    const SizedBox(width: _screenHorizontalPadding),
                  ],
                ],
              ),
            ),

            if (isActive) ...[
              if (hasSamples) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _screenHorizontalPadding,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: LabRequestDesignConstants.gray20,
                      ),
                    ),
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: samples.length,
                          separatorBuilder: (context, index) => const Divider(
                            height: 1,
                            color: LabRequestDesignConstants.gray20,
                          ),
                          itemBuilder: (context, index) {
                            final sample = samples[index];
                            if (sample == null) return const SizedBox.shrink();

                            // Generate ID: SPC-001, SPC-002, etc.
                            final sampleId =
                                'SPC-${(index + 1).toString().padLeft(3, '0')}';

                            return _SampleItem(
                              index: index,
                              sampleId: sampleId,
                              data: sample,
                              onEdit: () => onEditSample?.call(index, sample),
                              onDuplicate: () =>
                                  onDuplicateSample?.call(index, sample),
                              onDelete: () => onDeleteSample?.call(index),
                            );
                          },
                        ),
                        const Divider(
                          height: 1,
                          color: LabRequestDesignConstants.gray20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mau tambah sampel lagi?',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: LabRequestDesignConstants.gray100,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Klik tombol di samping.',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: LabRequestDesignConstants.gray70,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              OutlinedButton(
                                onPressed: onAddSampleTap,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  side: const BorderSide(
                                    color: Color(0xFF122E7A),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size(0, 36),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Color(0xFF122E7A),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      buttonText,
                                      style: const TextStyle(
                                        fontFamily: 'Open Sans',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF122E7A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ] else ...[
                // Add sample button (Standalone when no samples)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _screenHorizontalPadding,
                  ),
                  child: OutlinedButton(
                    onPressed: onAddSampleTap,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      side: const BorderSide(color: Color(0xFF122E7A)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(0, 32),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.add,
                          size: 20,
                          color: Color(0xFF122E7A),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          buttonText,
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF122E7A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ],
        );
      },
    );
  }
}

class _SampleItem extends StatelessWidget {
  const _SampleItem({
    required this.index,
    required this.sampleId,
    required this.data,
    required this.onEdit,
    required this.onDuplicate,
    required this.onDelete,
  });

  final int index;
  final String sampleId;
  final Map<String, dynamic> data;
  final VoidCallback onEdit;
  final VoidCallback onDuplicate;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final testType = data['testType'] as String? ?? '-';
    final dataTypes = (data['dataTypes'] as List<dynamic>?)?.join(',') ?? '-';
    final notes = data['notes'] as String?;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 14,
                      color: LabRequestDesignConstants.gray100,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sampel ${index + 1} ',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: '(ID: $sampleId)',
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              // Actions
              InkWell(
                onTap: onDuplicate,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.copy_outlined,
                    size: 20,
                    color: LabRequestDesignConstants.gray60,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: onDelete,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: LabRequestDesignConstants.gray60,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Details
          _buildDetailRow('Tes', testType),
          const SizedBox(height: 4),
          _buildDetailRow('Jenis Data', dataTypes),

          if (notes != null && notes.isNotEmpty) ...[
            const SizedBox(height: 4),
            const Text(
              'Catatan:',
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: LabRequestDesignConstants.gray100,
              ),
            ),
            Text(
              notes,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: LabRequestDesignConstants.gray70,
              ),
            ),
          ],

          const SizedBox(height: 12),

          // Edit Button
          InkWell(
            onTap: onEdit,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.edit_outlined,
                  size: 16,
                  color: Color(0xFFFF6B18), // Orange
                ),
                SizedBox(width: 4),
                Text(
                  'Edit',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF6B18), // Orange
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontFamily: 'Open Sans',
          fontSize: 13,
          color: LabRequestDesignConstants.gray100,
        ),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
