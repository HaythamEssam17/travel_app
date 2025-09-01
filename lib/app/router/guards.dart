// import 'dart:async';
//
// import 'package:injectable/injectable.dart';
// import 'package:travel_app/app/router/route_names.dart';
//
// import '../../features/auth/data/datasources/auth_local_ds.dart';
//
// @injectable
// class AuthGuard {
//   final AuthLocalDataSource _localDataSource;
//
//   AuthGuard(this._localDataSource);
//
//   FutureOr<String?> redirect(context, state) async {
//     final loggedIn = await _localDataSource.isLoggedIn();
//
//     await Future.delayed(const Duration(seconds: 5));
//     return loggedIn ? RouteNames.home : RouteNames.login;
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_app/app/router/route_names.dart';

import '../../core/services/hive_service.dart';
import '../../features/auth/data/models/login_response.dart';
import '../../features/auth/domain/repositories/auth_mock_repository.dart';

@injectable
class AuthGuard {
  final IAuthMockRepository repository;

  AuthGuard(this.repository);

  FutureOr<String?> redirect(context, state) async {
    final user = await repository.getUser();

    await Future.delayed(const Duration(seconds: 5));
    return user == null
        ? RouteNames.login
        : user.role == 'B2C'
        ? RouteNames.consumerHomePage
        : RouteNames.agentHomePage;
  }

  Future<bool> canActivate() async {
    return await repository.getUser() != null;
  }
}

@injectable
class RoleGuard {
  final IAuthMockRepository repository;

  RoleGuard(this.repository);

  Future<bool> canActivate(String requiredRole) async {
    final user = await repository.getUser();
    return user?.role == requiredRole;
  }
}

class AuthGuardRedirect {
  static String? checkRedirect(BuildContext context, GoRouterState state) {
    final user = HiveServiceProvider.i.getUser();

    if (user == null) {
      return RouteNames.login;
    }

    User userObject = User.fromJson(user);

    if (userObject.role == 'B2B') return RouteNames.agentHomePage;
    if (userObject.role == 'B2C') return RouteNames.consumerHomePage;

    return RouteNames.login;
  }
}
