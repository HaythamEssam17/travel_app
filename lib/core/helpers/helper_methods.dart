import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import 'shared_texts.dart';

void devLog(String message) => dev.log(message);

bool isARLocal() => SharedText.currentLocale == 'ar';

/// Get Widget Height
double getWidgetHeight(double height) {
  return SharedText.screenHeight * (height / 812);
}

/// Get Widget Width
double getWidgetWidth(double width) {
  return SharedText.screenWidth * (width / 375);
}

/// Get Space Height
SizedBox getSpaceHeight(double height) {
  final double currentHeight = SharedText.screenHeight * (height / 812);
  return SizedBox(height: currentHeight);
}

/// Get Space Width
SizedBox getSpaceWidth(double width) {
  final double currentWidth = SharedText.screenWidth * (width / 375);
  return SizedBox(width: currentWidth);
}
