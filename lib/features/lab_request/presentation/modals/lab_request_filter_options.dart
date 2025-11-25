import 'package:app_mobile_afms/features/lab_request/domain/entities/lab_request_status.dart';

/// Filter options for lab requests.
class LabRequestFilterOptions {
  /// Creates a new instance of [LabRequestFilterOptions].
  LabRequestFilterOptions({
    this.startDate,
    this.endDate,
    this.statuses = const [],
  });

  /// Start date filter
  final DateTime? startDate;

  /// End date filter
  final DateTime? endDate;

  /// Status filters
  final List<LabRequestStatus> statuses;

  /// Number of active filters
  int get count {
    int itemCount = 0;
    if (startDate != null || endDate != null) itemCount++;
    itemCount += statuses.length;
    return itemCount;
  }

  /// Creates a copy with updated values
  LabRequestFilterOptions copyWith({
    DateTime? startDate,
    DateTime? endDate,
    List<LabRequestStatus>? statuses,
  }) {
    return LabRequestFilterOptions(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      statuses: statuses ?? this.statuses,
    );
  }
}





