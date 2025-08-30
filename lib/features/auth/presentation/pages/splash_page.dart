import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/app_scaffold_page.dart';
import 'package:travel_app/core/helpers/shared_texts.dart';

import '../../../../app/di/injection.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../blocs/splash_cubit/splash_cubit.dart';
import 'login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      body: SizedBox(
        height: SharedText.screenHeight,
        width: SharedText.screenWidth,
        child: BlocProvider(
          create: (_) => getIt<SplashCubit>()..checkUser(),
          child: BlocBuilder<SplashCubit, SplashState>(
            builder: (context, state) {
              if (state is SplashLoading || state is SplashInitial) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (state is SplashAuthenticated) {
                return HomePage();
              } else {
                return const LoginPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
