import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/router/app_router.dart';
import 'package:travel_app/core/features/connectivity_feature/presentation/logic/connectivity_cubit.dart';

import '../core/helpers/shared_texts.dart';
import '../core/responsive_ui/ui_components.dart';

class AppMaterialWidget extends StatelessWidget {
  final Widget homeWidget;

  const AppMaterialWidget({super.key, required this.homeWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConnectivityCubit>(
      create: (_) => ConnectivityCubit(),
      child: MaterialApp.router(
        title: 'AppConstants.appName',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        builder: (context, child) {
          return InfoComponents(
            builder: (infoComponentsContext, deviceInfo) {
              if (deviceInfo.orientation == Orientation.portrait) {
                SharedText.screenHeight = deviceInfo.screenHeight;
                SharedText.screenWidth = deviceInfo.screenWidth;
                SharedText.deviceType = deviceInfo;
              } else {
                SharedText.screenHeight = deviceInfo.screenWidth;
                SharedText.screenWidth = deviceInfo.screenHeight;
                SharedText.deviceType = deviceInfo;
              }

              return child ?? Container(color: Colors.red);
            },
          );
        },
      ),
    );
  }
}
