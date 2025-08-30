import 'package:flutter/material.dart';
import 'package:travel_app/app/router/app_router.dart';

import '../core/helpers/shared_texts.dart';
import '../core/responsive_ui/device_info.dart';
import '../core/responsive_ui/ui_components.dart';

class AppMaterialWidget extends StatelessWidget {
  final Widget homeWidget;

  const AppMaterialWidget({super.key, required this.homeWidget});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // onGenerateRoute: RouteGenerator.generateRoute,
      title: 'AppConstants.appName',
      // themeMode: themeMode,
      // theme: lightTheme,
      // darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: (context, child) {
        return InfoComponents(
          builder: (BuildContext infoComponentsContext, DeviceInfo deviceInfo) {
            if (deviceInfo.orientation == Orientation.portrait) {
              SharedText.screenHeight = deviceInfo.screenHeight;
              SharedText.screenWidth = deviceInfo.screenWidth;
              SharedText.deviceType = deviceInfo;
            } else {
              SharedText.screenHeight = deviceInfo.screenWidth;
              SharedText.screenWidth = deviceInfo.screenHeight;
              SharedText.deviceType = deviceInfo;
            }
            // SharedText.currentLocale = LangCubit.get(context).appLocal.languageCode;

            return homeWidget;
          },
        );
      },
      // locale: LangCubit.get(context).appLocal,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,

      // /// widget that calculate width and height and type
      // home: InfoComponents(
      //   builder: (BuildContext infoComponentsContext, DeviceInfo deviceInfo) {
      //     if (deviceInfo.orientation == Orientation.portrait) {
      //       SharedText.screenHeight = deviceInfo.screenHeight;
      //       SharedText.screenWidth = deviceInfo.screenWidth;
      //       SharedText.deviceType = deviceInfo;
      //     } else {
      //       SharedText.screenHeight = deviceInfo.screenWidth;
      //       SharedText.screenWidth = deviceInfo.screenHeight;
      //       SharedText.deviceType = deviceInfo;
      //     }
      //     // SharedText.currentLocale = LangCubit.get(context).appLocal.languageCode;
      //
      //     return homeWidget;
      //   },
      // ),
    );
  }
}
