import 'package:flutter/material.dart';

import '../features/auth/presentation/pages/splash_page.dart';
import 'app_lifycycle_observer.dart';
import 'main_app_material_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: AppMaterialWidget(homeWidget: SplashPage()),
    );
  }
}
