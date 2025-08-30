import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/domain/repositories/auth_repository.dart';
import '../di/injection.dart';

class AuthGuard {
  static Future<String?> redirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final authRepo = getIt<IAuthRepository>();
    final loggedIn = await authRepo.isLoggedIn();

    if (!loggedIn) {
      return '/login';
    }
    return '/';
  }
}
