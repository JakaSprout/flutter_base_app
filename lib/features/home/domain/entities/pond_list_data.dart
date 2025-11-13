import 'package:flutter_base_app/features/home/domain/entities/pond_entity.dart';

/// Pond list data entity (domain layer).
class PondListData {
  /// Creates a new instance of [PondListData].
  const PondListData({
    required this.ponds,
  });

  /// List of ponds
  final List<PondEntity> ponds;
}

