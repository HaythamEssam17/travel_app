import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_app/core/util/forms/signup_form.dart';

part 'signup_states.dart';

@injectable
class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInit());

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final SignUpForm signupForm = SignUpForm();

  void validateForm(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      emit(SignupButtonEnabled());
    } else {
      emit(SignupButtonDisabled());
    }
  }
}
