import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/factories/circular_indicator_factory.dart';

import '../../helpers/helper_methods.dart';
import '../../helpers/icon_paths.dart';
import 'common_asset_image_widget.dart';

class CommonCachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final String? imagePlaceHolder;
  final double width;
  final double height;
  final double? radius;
  final BoxFit? fit;
  final bool? isCircular;
  final bool? isProfile;
  final Color? errorImageColor;
  const CommonCachedImageWidget({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.isCircular = false,
    this.isProfile = false,
    this.radius = 0.0,
    this.fit = BoxFit.fill,
    this.imagePlaceHolder,
    this.errorImageColor,
  });

  @override
  Widget build(BuildContext context) {
    final double imageHeight = getWidgetHeight(height);
    final double imageWidth = isCircular!
        ? getWidgetHeight(height)
        : getWidgetWidth(width);

    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: imageHeight,
        width: imageWidth,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius!),
          image: DecorationImage(image: imageProvider, fit: fit),
        ),
      ),
      placeholder: (context, img) => Container(
        height: imageHeight,
        width: imageWidth,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius!)),
        child: Center(
          child: PlatformCircularIndictor.buildCircular(context: context),
        ),
      ),
      errorWidget: (context, url, error) => CommonAssetImageWidget(
        imageString: IconPaths.logoIconPNG,
        height: imageHeight,
        width: imageWidth,
        radius: radius,
        fit: fit,
      ),
    );
  }
}
