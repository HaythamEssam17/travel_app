import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/splash_usecase.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final SplashUseCase _splashUseCase;

  SplashCubit(this._splashUseCase) : super(SplashInitial());

  Future<void> checkUser() async {
    emit(SplashLoading());

    await _splashUseCase.clearUser();

    final user = await _splashUseCase.getUser();

    await Future.delayed(const Duration(seconds: 1));

    if (user != null) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
  }

  Future<void> init() async {
    emit(SplashLoading());
    await Future.delayed(const Duration(seconds: 1));

    final isLoggedIn = await _splashUseCase.isLoggedIn();

    if (isLoggedIn) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
  }
}
