import 'package:app_mobile_afms/features/home/domain/entities/input_data_item_entity.dart';

/// Input data list entity.
class InputDataListData {
  /// Creates a new instance of [InputDataListData].
  const InputDataListData({required this.items});

  /// List of input data items (sorted by order)
  final List<InputDataItemEntity> items;
}

