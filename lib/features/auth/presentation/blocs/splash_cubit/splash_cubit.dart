import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_app/app/router/app_router.dart';
import 'package:travel_app/core/helpers/shared_texts.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../core/helpers/keys.dart';
import '../../../../../core/services/hive_service.dart';
import '../../../data/models/login_response.dart';
import '../../../domain/usecases/splash_usecase.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final SplashUseCase _splashUseCase;

  SplashCubit(this._splashUseCase) : super(SplashInitial());

  Future<void> checkUser() async {
    emit(SplashLoading());

    await _splashUseCase.clearUser();

    // final user = await _splashUseCase.getMockUser();

    await Future.delayed(const Duration(seconds: 1));
  }

  void getUser() {
    final user = HiveServiceProvider.i.getUser();

    if (user != null) {
      SharedText.user = User.fromJson(user);
    }

    Future.delayed(const Duration(seconds: 4), () {
      if (user == null) {
        router.go(RouteNames.login);
      } else if (user['role'] == LocalKeys.b2bKey) {
        router.go(RouteNames.agentHomePage);
      } else if (user['role'] == LocalKeys.b2cKey) {
        router.go(RouteNames.consumerHomePage);
      } else {
        router.go(RouteNames.login);
      }
    });
  }
}
