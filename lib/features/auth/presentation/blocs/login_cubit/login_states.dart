part of 'login_cubit.dart';

@immutable
abstract class LoginStates {}

class LoginInit extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginSuccess extends LoginStates {}

class LoginButtonEnabled extends LoginStates {}

class LoginButtonDisabled extends LoginStates {}

class LoginError extends LoginStates {
  final String message;
  LoginError(this.message);
}
