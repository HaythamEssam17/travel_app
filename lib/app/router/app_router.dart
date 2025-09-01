import 'package:go_router/go_router.dart';
import 'package:travel_app/features/auth/presentation/pages/signup_page.dart';
import 'package:travel_app/features/auth/presentation/pages/splash_page.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/agent_home_page.dart';
import '../../features/home/presentation/pages/consumer_home_page.dart';
import 'route_names.dart';

final router = GoRouter(
  initialLocation: RouteNames.splash,
  // redirect: (context, state) => AuthGuardRedirect.checkRedirect(context, state),
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const SplashPage(),
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
      path: RouteNames.consumerHomePage,
      name: RouteNames.consumerHomePage,
      builder: (context, state) => const ConsumerHomePage(),
    ),
    GoRoute(
      path: RouteNames.agentHomePage,
      name: RouteNames.agentHomePage,
      builder: (context, state) => const AgentHomePage(),
    ),
  ],
);
