// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/README.md
  String get readme => 'assets/icons/README.md';

  /// File path: assets/icons/app_icon.png
  AssetGenImage get appIcon => const AssetGenImage('assets/icons/app_icon.png');

  /// Directory path: assets/icons/general
  $AssetsIconsGeneralGen get general => const $AssetsIconsGeneralGen();

  /// Directory path: assets/icons/outline
  $AssetsIconsOutlineGen get outline => const $AssetsIconsOutlineGen();

  /// Directory path: assets/icons/solid
  $AssetsIconsSolidGen get solid => const $AssetsIconsSolidGen();

  /// List of all assets
  List<dynamic> get values => [readme, appIcon];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/analisis_lab.jpg
  AssetGenImage get analisisLab =>
      const AssetGenImage('assets/images/analisis_lab.jpg');

  /// File path: assets/images/kalkulator_panen.jpg
  AssetGenImage get kalkulatorPanen =>
      const AssetGenImage('assets/images/kalkulator_panen.jpg');

  /// File path: assets/images/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/images/splash.png');

  /// List of all assets
  List<AssetGenImage> get values => [analisisLab, kalkulatorPanen, splash];
}

class $AssetsIconsGeneralGen {
  const $AssetsIconsGeneralGen();

  /// File path: assets/icons/general/chemistry.svg
  String get chemistry => 'assets/icons/general/chemistry.svg';

  /// File path: assets/icons/general/disease.svg
  String get disease => 'assets/icons/general/disease.svg';

  /// File path: assets/icons/general/earnings_color.svg
  String get earningsColor => 'assets/icons/general/earnings_color.svg';

  /// File path: assets/icons/general/feed.svg
  String get feed => 'assets/icons/general/feed.svg';

  /// File path: assets/icons/general/growth.svg
  String get growth => 'assets/icons/general/growth.svg';

  /// File path: assets/icons/general/logo.svg
  String get logo => 'assets/icons/general/logo.svg';

  /// File path: assets/icons/general/microbiology.svg
  String get microbiology => 'assets/icons/general/microbiology.svg';

  /// File path: assets/icons/general/microscope.svg
  String get microscope => 'assets/icons/general/microscope.svg';

  /// File path: assets/icons/general/mortality.svg
  String get mortality => 'assets/icons/general/mortality.svg';

  /// File path: assets/icons/general/package_color.svg
  String get packageColor => 'assets/icons/general/package_color.svg';

  /// File path: assets/icons/general/payment_color.svg
  String get paymentColor => 'assets/icons/general/payment_color.svg';

  /// File path: assets/icons/general/water_quality.svg
  String get waterQuality => 'assets/icons/general/water_quality.svg';

  /// File path: assets/icons/general/weight_color.svg
  String get weightColor => 'assets/icons/general/weight_color.svg';

  /// List of all assets
  List<String> get values => [
    chemistry,
    disease,
    earningsColor,
    feed,
    growth,
    logo,
    microbiology,
    microscope,
    mortality,
    packageColor,
    paymentColor,
    waterQuality,
    weightColor,
  ];
}

class $AssetsIconsOutlineGen {
  const $AssetsIconsOutlineGen();

  /// File path: assets/icons/outline/chart.svg
  String get chart => 'assets/icons/outline/chart.svg';

  /// File path: assets/icons/outline/chevron_down.svg
  String get chevronDown => 'assets/icons/outline/chevron_down.svg';

  /// File path: assets/icons/outline/grid.svg
  String get grid => 'assets/icons/outline/grid.svg';

  /// File path: assets/icons/outline/home.svg
  String get home => 'assets/icons/outline/home.svg';

  /// File path: assets/icons/outline/notification.svg
  String get notification => 'assets/icons/outline/notification.svg';

  /// File path: assets/icons/outline/profile.svg
  String get profile => 'assets/icons/outline/profile.svg';

  /// File path: assets/icons/outline/refresh.svg
  String get refresh => 'assets/icons/outline/refresh.svg';

  /// List of all assets
  List<String> get values => [
    chart,
    chevronDown,
    grid,
    home,
    notification,
    profile,
    refresh,
  ];
}

class $AssetsIconsSolidGen {
  const $AssetsIconsSolidGen();

  /// File path: assets/icons/solid/chart.svg
  String get chart => 'assets/icons/solid/chart.svg';

  /// File path: assets/icons/solid/grid.svg
  String get grid => 'assets/icons/solid/grid.svg';

  /// File path: assets/icons/solid/home.svg
  String get home => 'assets/icons/solid/home.svg';

  /// File path: assets/icons/solid/profile.svg
  String get profile => 'assets/icons/solid/profile.svg';

  /// List of all assets
  List<String> get values => [chart, grid, home, profile];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
