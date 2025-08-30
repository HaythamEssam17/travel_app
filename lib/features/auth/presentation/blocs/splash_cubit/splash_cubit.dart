import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user_model.dart';
import '../../../domain/usecases/splash_usecase.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final SplashUseCase _splashUseCase;

  SplashCubit(this._splashUseCase) : super(SplashInitial());

  Future<void> checkUser() async {
    emit(SplashLoading());

    final user = await _splashUseCase.getUser();

    if (user != null) {
      emit(SplashAuthenticated(user));
    } else {
      emit(SplashUnauthenticated());
    }
  }
}
