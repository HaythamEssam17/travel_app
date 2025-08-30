import 'package:flutter/material.dart';

import '../enums/device_enums.dart';
import '../helpers/shared_texts.dart';

// // This functions are responsible to make UI responsive across all the mobile devices.
//

late BuildContext sizeUtilContext;
MediaQueryData get mediaQueryData => MediaQuery.of(sizeUtilContext);
//
//
// ///This method is used to get device viewport width.

bool get isIpad => SharedText.deviceType == DeviceType.tablet;
num get _width => num.parse(SharedText.screenWidth.toString());
num get designWidth => num.parse(SharedText.designWidth.toString());
num get _height => mediaQueryData.size.height;
num DESIGN_STATUS_BAR = 0;
//
// ///This method is used to get device viewport height.
get _contentHeight {
  num statusBar = mediaQueryData.viewPadding.top;
  num bottomBar = mediaQueryData.viewPadding.bottom;
  num screenHeight = _height - statusBar - bottomBar;

  return screenHeight;
}

//
Orientation get orientation => mediaQueryData.orientation;
//
bool get isLandscape => orientation == Orientation.landscape;
//
bool get isPortrait => orientation == Orientation.portrait;
//
// bool get isIpad {
//   if (isLandscape && _height >= 540) return true;
//   if (!isLandscape && _width >= 590) return true;
//
//   return false;
// }

extension NumExtensions on num {
  double w({
    double ipadMultiplier = 1.0,
    double ipadLandScapeMultiplier = 1.0,
    double iphoneMultiplier = 1.0,
    double? iphoneLandScapeMultiplier,
  }) {
    // if (!isIpad) return toDouble();

    double multiplier = 1;

    if (isIpad) {
      multiplier = ipadMultiplier;

      if (isLandscape) multiplier = ipadLandScapeMultiplier;
    } else {
      multiplier = iphoneMultiplier;

      if (isLandscape && iphoneLandScapeMultiplier != null) {
        multiplier = iphoneLandScapeMultiplier;
      }
    }

    return ((this * _width) / designWidth) * multiplier;
  }

  double h({
    double ipadMultiplier = 1.0,
    double ipadLandScapeMultiplier = 1.0,
    double iphoneMultiplier = 1.0,
    double? iphoneLandScapeMultiplier,
  }) {
    // if (!isIpad) return toDouble();
    double screenHeight = _contentHeight;

    double multiplier = 1;

    if (isIpad) {
      multiplier = ipadMultiplier;

      if (isLandscape) multiplier = ipadLandScapeMultiplier;
    } else {
      multiplier = iphoneMultiplier;

      if (isLandscape && iphoneLandScapeMultiplier != null) {
        multiplier = iphoneLandScapeMultiplier;
      }
    }

    return ((this * screenHeight) / (designWidth - DESIGN_STATUS_BAR)) *
        multiplier;
  }

  double size({
    double ipadMultiplier = 1.0,
    double iphoneMultiplier = 1.0,
    double ipadLandScapeMultiplier = 1.0,
    double? iphoneLandScapeMultiplier,
    bool ipadOnly = false,
  }) {
    if (ipadOnly && !isIpad) return toDouble();

    var height = h(
      ipadMultiplier: ipadMultiplier,
      iphoneMultiplier: iphoneMultiplier,
      iphoneLandScapeMultiplier: iphoneLandScapeMultiplier,
      ipadLandScapeMultiplier: ipadLandScapeMultiplier,
    );
    var width = w(
      ipadMultiplier: ipadMultiplier,
      iphoneMultiplier: iphoneMultiplier,
      iphoneLandScapeMultiplier: iphoneLandScapeMultiplier,
      ipadLandScapeMultiplier: ipadLandScapeMultiplier,
    );

    return (height < width) ? height : width;
  }

  double s({
    double ipadMultiplier = 1.0,
    double iphoneMultiplier = 1.0,
    double ipadLandScapeMultiplier = 1.0,
    double? iphoneLandScapeMultiplier,
    bool ipadOnly = false,
  }) {
    return size(
      ipadMultiplier: ipadMultiplier,
      iphoneMultiplier: iphoneMultiplier,
      iphoneLandScapeMultiplier: iphoneLandScapeMultiplier,
      ipadLandScapeMultiplier: ipadLandScapeMultiplier,
      ipadOnly: ipadOnly,
    );
  }
}

extension EdgeInsetsExtensions on EdgeInsets {
  EdgeInsets p({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double ipadMultiplier = 1.0,
    double? ipadHorizontalMultiplier,
    double? ipadVerticalMultiplier,
    double iphoneMultiplier = 1.0,
  }) {
    if (all != null) {
      left = all;
      top = all;
      right = all;
      bottom = all;
    }

    return EdgeInsets.only(
      left: (left ?? this.left).w(
        ipadMultiplier: ipadHorizontalMultiplier ?? ipadMultiplier,
        iphoneMultiplier: iphoneMultiplier,
      ),
      top: (top ?? this.top).h(
        ipadMultiplier: ipadVerticalMultiplier ?? ipadMultiplier,
        iphoneMultiplier: iphoneMultiplier,
      ),
      right: (right ?? this.right).w(
        ipadMultiplier: ipadHorizontalMultiplier ?? ipadMultiplier,
        iphoneMultiplier: iphoneMultiplier,
      ),
      bottom: (bottom ?? this.bottom).h(
        ipadMultiplier: ipadVerticalMultiplier ?? ipadMultiplier,
        iphoneMultiplier: iphoneMultiplier,
      ),
    );
  }

  EdgeInsets sw({
    double ipadMultiplier = 1.0,
    double iphoneMultiplier = 1.0,
    double ipadLandScapeMultiplier = 1.0,
    double? iphoneLandScapeMultiplier,
    bool ipadOnly = false,
  }) {
    if (ipadOnly && !isIpad) return this;

    return EdgeInsets.only(
      top: top.h(
        ipadMultiplier: ipadMultiplier,
        iphoneMultiplier: iphoneMultiplier,
        ipadLandScapeMultiplier: ipadLandScapeMultiplier,
        iphoneLandScapeMultiplier: iphoneLandScapeMultiplier,
      ),
      bottom: bottom.h(
        ipadMultiplier: ipadMultiplier,
        iphoneMultiplier: iphoneMultiplier,
        ipadLandScapeMultiplier: ipadLandScapeMultiplier,
        iphoneLandScapeMultiplier: iphoneLandScapeMultiplier,
      ),
      left: left.w(
        ipadMultiplier: ipadMultiplier,
        iphoneMultiplier: iphoneMultiplier,
        ipadLandScapeMultiplier: ipadLandScapeMultiplier,
        iphoneLandScapeMultiplier: iphoneLandScapeMultiplier,
      ),
      right: right.w(
        ipadMultiplier: ipadMultiplier,
        iphoneMultiplier: iphoneMultiplier,
        ipadLandScapeMultiplier: ipadLandScapeMultiplier,
        iphoneLandScapeMultiplier: iphoneLandScapeMultiplier,
      ),
    );
  }

  EdgeInsets sh({
    double ipadMultiplier = 1.0,
    double iphoneMultiplier = 1.0,
    double ipadLandScapeMultiplier = 1.0,
  }) {
    return EdgeInsets.only(
      top: vertical.h(
        ipadMultiplier: ipadMultiplier,
        iphoneMultiplier: iphoneMultiplier,
        ipadLandScapeMultiplier: ipadLandScapeMultiplier,
      ),
      bottom: vertical.h(
        ipadMultiplier: ipadMultiplier,
        iphoneMultiplier: iphoneMultiplier,
        ipadLandScapeMultiplier: ipadLandScapeMultiplier,
      ),
    );
  }

  EdgeInsets getMargin({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double ipadMultiplier = 1.0,
    double iphoneMultiplier = 1.0,
  }) {
    if (all != null) {
      left = all;
      top = all;
      right = all;
      bottom = all;
    }

    return EdgeInsets.only(
      left:
          left?.w(
            ipadMultiplier: ipadMultiplier,
            iphoneMultiplier: iphoneMultiplier,
          ) ??
          0,
      top:
          top?.h(
            ipadMultiplier: ipadMultiplier,
            iphoneMultiplier: iphoneMultiplier,
          ) ??
          0,
      right:
          right?.w(
            ipadMultiplier: ipadMultiplier,
            iphoneMultiplier: iphoneMultiplier,
          ) ??
          0,
      bottom:
          bottom?.h(
            ipadMultiplier: ipadMultiplier,
            iphoneMultiplier: iphoneMultiplier,
          ) ??
          0,
    );
  }
}

extension FormatExtension on double {
  /// Return a [double] value with formatted according to provided fractionDigits
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }
}
