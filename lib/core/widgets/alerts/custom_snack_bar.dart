import 'package:flutter/material.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';

import '../../helpers/helper_methods.dart';
import '../common_title_text.dart';

void showSnackBar({
  required BuildContext context,
  required String title,
  Color? color,
  double? height = 150,
}) {
  final snackBar = SnackBar(
    content: CommonTitleText(
      textKey: title,
      textStyle: context.textTheme.bodyMedium!.copyWith(
        color: context.appColors.surfacesWhite,
        fontWeight: FontWeight.w700,
      ),
      maxLines: 2,
    ),
    backgroundColor: context.appColors.primaryColor,
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - height!,
      right: getWidgetWidth(16),
      left: getWidgetWidth(16),
    ),
    duration: const Duration(milliseconds: 3500),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
