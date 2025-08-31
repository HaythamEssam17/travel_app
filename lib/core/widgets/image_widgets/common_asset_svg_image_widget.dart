import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helpers/helper_methods.dart';

class CommonAssetSvgImageWidget extends StatelessWidget {
  final String imageString;
  final double height;
  final double width;
  final bool isCircular;
  final Color? imageColor;
  final double? radius;
  final BoxFit? fit;

  const CommonAssetSvgImageWidget({
    super.key,
    required this.imageString,
    required this.height,
    required this.width,
    this.isCircular = false,
    this.radius,
    this.imageColor,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: SvgPicture.asset(
        'assets/images/$imageString',
        fit: fit ?? BoxFit.fill,
        colorFilter: imageColor == null
            ? null
            : ColorFilter.mode(imageColor!, BlendMode.srcIn),
        height: getWidgetHeight(height),
        width: isCircular ? getWidgetHeight(height) : getWidgetWidth(width),
      ),
    );
  }
}
