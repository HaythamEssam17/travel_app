import 'package:go_router/go_router.dart';
import 'package:travel_app/features/auth/presentation/pages/signup_page.dart';
import 'package:travel_app/features/auth/presentation/pages/splash_page.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'route_names.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const SplashPage(),
      // redirect: (context, state) => getIt<AuthGuard>().redirect(context, state),
    ),
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RouteNames.signup,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: RouteNames.home,
      name: RouteNames.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
