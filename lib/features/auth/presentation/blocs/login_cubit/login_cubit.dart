import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'login_states.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInit());
}
