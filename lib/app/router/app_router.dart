import 'package:go_router/go_router.dart';
import 'package:travel_app/features/auth/presentation/pages/signup_page.dart';
import 'package:travel_app/features/auth/presentation/pages/splash_page.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'guards.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
      redirect: AuthGuard.redirect,
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/signup', builder: (context, state) => const SignUpPage()),
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
  ],
);
