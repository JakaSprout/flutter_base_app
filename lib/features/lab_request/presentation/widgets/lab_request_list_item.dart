import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/lab_request/domain/entities/lab_request.dart';
import 'package:flutter_base_app/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:intl/intl.dart';

/// Lab request list item widget.
class LabRequestListItem extends StatelessWidget {
  /// Creates a new instance of [LabRequestListItem].
  const LabRequestListItem({
    required this.request,
    super.key,
  });

  /// Lab request data
  final LabRequest request;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: LabRequestDesignConstants.spacingSmall,
      ),
      child: ListTile(
        title: Text(
          request.namaPengirim,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Tambak: ${request.tambakAsal}'),
            if (request.tanggalRequest != null)
              Text(
                'Tanggal Request: '
                '${DateFormat('dd-MMM-yyyy').format(request.tanggalRequest!)}',
              ),
            Text('Anamnesa: ${request.anamnesa.displayName}'),
            Text('Jenis Testing: ${request.jenisTesting.displayName}'),
            if (request.status != null)
              Text(
                'Status: ${request.status}',
                style: TextStyle(
                  color: _getStatusColor(request.status!),
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Color _getStatusColor(String status) {
    if (status.toLowerCase().contains('dikerjakan')) {
      return Colors.orange;
    }
    return AppColors.gray100;
  }
}

