import 'package:flutter/material.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';

import '../../../../factories/circular_indicator_factory.dart';

class ConnectionLoadingScreen extends StatelessWidget {
  const ConnectionLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: context.appColors.surfacesWhite,
        body: Container(
          decoration: BoxDecoration(
            color: context.appColors.grey58.withAlpha(90),
          ),
          child: Center(
            child: PlatformCircularIndictor.buildCircular(context: context),
          ),
        ),
      ),
    );
  }
}
