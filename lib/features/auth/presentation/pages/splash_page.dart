import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/app_scaffold_page.dart';
import 'package:travel_app/core/factories/circular_indicator_factory.dart';
import 'package:travel_app/features/auth/presentation/blocs/splash_cubit/splash_cubit.dart';

import '../../../../app/di/injection.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (_) => getIt<SplashCubit>()..getUser(),
      child: AppScaffoldPage(
        body: BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            return Center(
              child: PlatformCircularIndictor.buildCircular(context: context),
            );
          },
        ),
      ),
    );
  }
}
