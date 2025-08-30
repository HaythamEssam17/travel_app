import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';

import '../helpers/helper_methods.dart';

abstract class CircularFactory {
  Widget buildCircular(BuildContext context);

  factory CircularFactory(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return AndroidCircular();
      case TargetPlatform.iOS:
        return IOSCircular();

      default:
        return AndroidCircular();
    }
  }
}

class AndroidCircular implements CircularFactory {
  @override
  Widget buildCircular(context) {
    return CircularProgressIndicator(
      color: context.appColors.primaryColor,
      backgroundColor: context.appColors.blue100,
    );
  }
}

class IOSCircular implements CircularFactory {
  @override
  Widget buildCircular(context) {
    return CupertinoActivityIndicator(color: context.appColors.primaryColor);
  }
}

/// UI
class PlatformCircularIndictor {
  static Widget buildCircular({required BuildContext context}) {
    return Container(
      height: getWidgetHeight(48),
      width: getWidgetHeight(48),
      decoration: BoxDecoration(
        color: context.appColors.bgWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: CircularFactory(
          Theme.of(context).platform,
        ).buildCircular(context),
      ),
    );
  }
}
