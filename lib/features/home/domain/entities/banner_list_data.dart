import 'package:app_mobile_afms/features/home/domain/entities/banner_entity.dart';

/// Banner list data entity.
class BannerListData {
  /// Creates a new instance of [BannerListData].
  const BannerListData({required this.banners});

  /// List of banners
  final List<BannerEntity> banners;
}

