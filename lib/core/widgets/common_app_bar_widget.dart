import 'package:flutter/material.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';

import '../../app/router/app_router.dart';
import '../helpers/helper_methods.dart';
import 'common_title_text.dart';

class AppBarWithBottomWidget extends StatelessWidget {
  const AppBarWithBottomWidget({
    super.key,
    this.title,
    this.subtitle,
    this.isBackArrow = true,
    this.actions,
  });

  final String? title;
  final String? subtitle;
  final bool isBackArrow;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getSpaceHeight(kToolbarHeight),
          if (isBackArrow)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => router.pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: context.appColors.grey58,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),

          if (title != null) ...[
            getSpaceHeight(8),
            Center(
              child: CommonTitleText(
                textKey: title!,
                textStyle: TextStyle(color: context.textColors.main),
              ),
            ),
            getSpaceHeight(8),
            subtitle == null
                ? SizedBox()
                : CommonTitleText(
                    textKey: subtitle!,
                    textScaleFactor: 0.9,
                    textStyle: TextStyle(color: context.textColors.lightGrey),
                  ),
          ],

          if (actions != null) actions ?? const SizedBox(),
        ],
      ),
    );
  }
}
