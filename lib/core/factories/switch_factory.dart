import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';

abstract class SwitchFactory {
  Widget buildSwitch({
    required bool value,
    required Function(bool p1) onChanged,
    required BuildContext context,
  });

  factory SwitchFactory(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return AndroidSwitch();
      case TargetPlatform.iOS:
        return IOSSwitch();

      default:
        return AndroidSwitch();
    }
  }
}

class AndroidSwitch implements SwitchFactory {
  @override
  Widget buildSwitch({
    required bool value,
    required Function(bool p1) onChanged,
    required BuildContext context,
  }) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: context.appColors.surfacesWhite4,
      activeTrackColor: context.appColors.primaryColor,
    );
  }
}

class IOSSwitch implements SwitchFactory {
  @override
  Widget buildSwitch({
    required bool value,
    required Function(bool p1) onChanged,
    required BuildContext context,
  }) {
    return CupertinoSwitch(value: value, onChanged: onChanged);
  }
}

/// Use This in UI
class PlatformSwitch {
  static Widget buildSwitch({
    required BuildContext context,
    required bool value,
    required Function(bool p1) onChanged,
  }) {
    return SwitchFactory(
      Theme.of(context).platform,
    ).buildSwitch(value: value, onChanged: onChanged, context: context);
  }
}
