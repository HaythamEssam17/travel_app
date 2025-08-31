import 'package:flutter/material.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';

import '../helpers/helper_methods.dart';
import 'common_title_text.dart';

class CommonGlobalButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressedFunction;
  final Color? buttonBackgroundColor;
  final Color? onPressedColor;
  final Color? shadowBackgroundColor;
  final double? elevation;
  final double? width;
  final double? height;
  final Color? buttonTextColor;
  final double? buttonTextSize;
  final FontWeight? buttonTextFontWeight;
  final Color? iconColor;
  final double? radius;
  final Widget? icon;
  final double? spaceSize;
  final bool isLoading;
  final bool isEnable;
  final bool showBorder;
  final Color? borderColor;

  const CommonGlobalButton({
    super.key,
    required this.buttonText,
    required this.onPressedFunction,
    this.buttonBackgroundColor,
    this.onPressedColor,
    this.shadowBackgroundColor,
    this.elevation = 0.0,
    this.width = 343,
    this.height = 48,
    this.iconColor,
    this.buttonTextColor,
    this.buttonTextFontWeight = FontWeight.w400,
    this.buttonTextSize = 14,
    this.icon,
    this.radius = 14,
    this.spaceSize = 8.0,
    this.isLoading = false,
    this.isEnable = true,
    this.showBorder = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = getWidgetWidth(width!);
    final double buttonHeight = getWidgetHeight(height!);

    return ElevatedButton(
      onPressed: isLoading || !isEnable ? null : onPressedFunction,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all<double>(elevation!),
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(
            width: 1,
            color: showBorder
                ? isLoading || !isEnable
                      ? context.appColors.grey22
                      : borderColor!
                : Colors.transparent,
          ),
        ),
        shadowColor: WidgetStateProperty.all(
          shadowBackgroundColor ?? context.appColors.grey22.withAlpha(30),
        ),
        overlayColor: WidgetStateProperty.all(
          onPressedColor ?? context.appColors.grey22.withAlpha(25),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
        ),
        fixedSize: WidgetStateProperty.all<Size>(
          Size(buttonWidth, buttonHeight),
        ),
        backgroundColor: isLoading || !isEnable
            ? WidgetStateProperty.all(context.appColors.lightGreyEEEEEF)
            : WidgetStateProperty.all(
                buttonBackgroundColor ?? context.appColors.primaryColor,
              ),
      ),
      child: CommonTitleText(
        textKey: isLoading ? 'Loading...' : buttonText,
        textStyle: context.textTheme.bodyMedium!.copyWith(
          fontSize: buttonTextSize!,
          fontWeight: buttonTextFontWeight!,
          color: isEnable
              ? isLoading
                    ? context.appColors.grey22
                    : buttonTextColor ?? context.textColors.white
              : context.appColors.grey22,
        ),
      ),
    );
  }
}
