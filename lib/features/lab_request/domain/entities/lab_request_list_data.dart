import 'package:app_mobile_afms/features/lab_request/domain/entities/lab_request.dart';

/// Lab request list data entity (domain layer).
class LabRequestListData {
  /// Creates a new instance of [LabRequestListData].
  const LabRequestListData({required this.requests});

  /// List of lab requests
  final List<LabRequest> requests;
}

