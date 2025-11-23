import 'dart:async';

import 'package:app_mobile_afms/core/reference_data/domain/reference_data_type.dart';
import 'package:app_mobile_afms/core/reference_data/domain/repositories/reference_data_repository.dart';

/// Background updater that periodically refreshes stale reference data.
class ReferenceDataUpdater {
  ReferenceDataUpdater(this._repository);

  final ReferenceDataRepository _repository;
  Timer? _timer;

  /// Starts periodic check (default every hour).
  void start({
    required String userId,
    Duration interval = const Duration(hours: 1),
  }) {
    _timer?.cancel();
    _timer = Timer.periodic(interval, (_) {
      refreshAll(userId: userId);
    });
  }

  /// Stops periodic timer.
  void stop() => _timer?.cancel();

  /// Refreshes all types respecting TTL rules.
  Future<void> refreshAll({required String userId}) async {
    for (final type in ReferenceDataType.values) {
      await _repository.refreshType(type, userId: userId, force: false);
    }
  }

  /// Force refresh a specific type immediately (ignoring TTL).
  Future<void> forceRefresh({
    required String userId,
    required ReferenceDataType type,
  }) {
    return _repository.refreshType(type, userId: userId, force: true);
  }
}

