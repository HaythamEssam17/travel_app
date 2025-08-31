import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/util/forms/login_form.dart';
import '../../../domain/usecases/login.dart';

part 'login_states.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._loginUseCase) : super(LoginInit());

  final LoginUseCase _loginUseCase;

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final LoginForm loginForm = LoginForm();

  void validateForm(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      emit(LoginButtonEnabled());
    } else {
      emit(LoginButtonDisabled());
    }
  }

  login() async {
    emit(LoginLoading());

    var result = await _loginUseCase.login(
      loginForm.emailController.text,
      loginForm.passwordController.text,
    );

    result.fold(
      (l) => emit(LoginError(l.errorMassage!)),
      (r) => emit(LoginSuccess()),
    );
  }
}
