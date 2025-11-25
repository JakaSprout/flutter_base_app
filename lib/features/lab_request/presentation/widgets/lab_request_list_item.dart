import 'package:app_mobile_afms/features/lab_request/domain/entities/lab_request.dart';
import 'package:app_mobile_afms/features/lab_request/domain/entities/lab_request_status.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Lab request list item widget.
class LabRequestListItem extends StatelessWidget {
  /// Creates a new instance of [LabRequestListItem].
  const LabRequestListItem({required this.request, super.key});

  /// Lab request data
  final LabRequest request;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LabRequestDesignConstants.gray05,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE8D1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.science_outlined, // Fallback icon
                  color: Color(0xFFFF6B18),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              // ID and Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.id,
                      style: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: LabRequestDesignConstants.gray100,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      request.tanggalRequest != null
                          ? DateFormat(
                              'dd MMM yyyy',
                            ).format(request.tanggalRequest!)
                          : '-',
                      style: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: LabRequestDesignConstants.gray70,
                      ),
                    ),
                  ],
                ),
              ),
              // Status Badge
              if (request.status != null) ...[
                _buildStatusBadge(request.status!),
                const SizedBox(width: 8),
              ],
              // Menu Icon
              const Icon(
                Icons.more_vert,
                color: LabRequestDesignConstants.gray60,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Content Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row 1: Farm & Date
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildInfoColumn(
                        label: 'Farm',
                        value: request
                            .namaPengirim, // Using namaPengirim as Farm name based on context
                      ),
                    ),
                    Expanded(
                      child: _buildInfoColumn(
                        label: 'Tanggal Kirim',
                        value: request.tanggalRequest != null
                            ? DateFormat(
                                'dd/MM/yyyy',
                              ).format(request.tanggalRequest!)
                            : '-',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Row 2: Test Type & Sample Count
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildInfoColumn(
                        label: 'Jenis Tes',
                        value: request.jenisTesting.displayName,
                        // TODO: Handle multiple tests and truncation if needed
                      ),
                    ),
                    Expanded(
                      child: _buildInfoColumn(
                        label: 'Jumlah Sampel',
                        value: (request.jumlahSampel ?? 0).toString(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(LabRequestStatus status) {
    Color color;
    Color backgroundColor;
    Color borderColor;

    switch (status) {
      case LabRequestStatus.dikirim:
        color = const Color(0xFF007AFF); // Blue
        backgroundColor = const Color(0xFFE3F2FD); // Light blue background
        borderColor = const Color(0xFF007AFF);
        break;
      case LabRequestStatus.diproses:
        color = const Color(0xFFFF9500); // Orange
        backgroundColor = const Color(0xFFFFF3E0); // Light orange background
        borderColor = const Color(0xFFFF9500);
        break;
      case LabRequestStatus.selesai:
        color = const Color(0xFF34C759); // Green
        backgroundColor = const Color(0xFFE8F5E8); // Light green background
        borderColor = const Color(0xFF34C759);
        break;
      case LabRequestStatus.ditolak:
        color = const Color(0xFFFF3B30); // Red
        backgroundColor = const Color(0xFFFFEBEE); // Light red background
        borderColor = const Color(0xFFFF3B30);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        color: backgroundColor,
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          fontFamily: 'Open Sans',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildInfoColumn({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: LabRequestDesignConstants.gray70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: LabRequestDesignConstants.gray100,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
