import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/app_scaffold_page.dart';
import 'package:travel_app/core/factories/circular_indicator_factory.dart';
import 'package:travel_app/features/auth/presentation/blocs/splash_cubit/splash_cubit.dart';

import '../../../../app/di/injection.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:travel_app/app/app_scaffold_page.dart';
// import 'package:travel_app/core/factories/circular_indicator_factory.dart';
// import 'package:travel_app/core/helpers/shared_texts.dart';
//
// import '../../../../app/di/injection.dart';
// import '../blocs/splash_cubit/splash_cubit.dart';
//
// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});
//
//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }
//
// class _SplashPageState extends State<SplashPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Future.delayed(const Duration(seconds: 2), () {
//     //   router.refresh();
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AppScaffoldPage(
//       body: SizedBox(
//         height: SharedText.screenHeight,
//         width: SharedText.screenWidth,
//         child: BlocProvider(
//           create: (_) => getIt<SplashCubit>()..checkUser(),
//           child: BlocConsumer<SplashCubit, SplashState>(
//             builder: (context, state) {
//               return AppScaffoldPage(
//                 body: PlatformCircularIndictor.buildCircular(context: context),
//               );
//             },
//             listener: (context, state) {
//               // if (state is SplashAuthenticated) {
//               //   router.go(RouteNames.home);
//               // } else if (state is SplashUnauthenticated) {
//               //   router.go(RouteNames.login);
//               // }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Future.microtask(() {
    //   final user = HiveServiceProvider.i.getUser();
    //
    //   if (user == null) {
    //     router.go(RouteNames.login);
    //   } else if (user['role'] == LocalKeys.b2bKey) {
    //     router.go(RouteNames.agentHomePage);
    //   } else if (user['role'] == LocalKeys.b2cKey) {
    //     router.go(RouteNames.consumerHomePage);
    //   } else {
    //     router.go(RouteNames.login);
    //   }
    // });

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
