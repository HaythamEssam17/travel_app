import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:travel_app/app/router/route_names.dart';

import '../../features/auth/data/datasources/auth_local_ds.dart';

// class AuthGuard {
//   static Future<String?> redirect(
//     BuildContext context,
//     GoRouterState state,
//   ) async {
//     final authRepo = getIt<IAuthRepository>();
//     final loggedIn = await authRepo.isLoggedIn();
//
//     if (!loggedIn) {
//       return '/login';
//     }
//     return '/';
//   }
// }

@injectable
class AuthGuard {
  final AuthLocalDataSource _localDataSource;

  AuthGuard(this._localDataSource);

  FutureOr<String?> redirect(context, state) async {
    final loggedIn = await _localDataSource.isLoggedIn();

    await Future.delayed(const Duration(seconds: 5));
    return loggedIn ? RouteNames.home : RouteNames.login;
  }
}
