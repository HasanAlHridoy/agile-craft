import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension ImageExtension on String {
  /// Load a PNG, JPG, or other raster image from assets
  Image toImage({
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
  }) {
    return Image.asset(
      this,
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }
}

extension AssetImageExtension on String {
  /// Load a PNG, JPG, or other raster image from assets
  AssetImage toAssetImage() {
    return AssetImage(this);
  }
}

extension SvgImageExtension on String {
  /// Load an SVG image from assets
  SvgPicture toSvg({
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    ColorFilter? colorFilter,
  }) {
    return SvgPicture.asset(
      this,
      width: width,
      height: height,
      fit: fit,
    colorFilter: colorFilter,
    );
  }
}
