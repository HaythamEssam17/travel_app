part of 'signup_cubit.dart';

@immutable
abstract class SignupStates {}

class SignupInit extends SignupStates {}

class SignupLoading extends SignupStates {}

class SignupSuccess extends SignupStates {}

class SignupButtonEnabled extends SignupStates {}

class SignupButtonDisabled extends SignupStates {}

class SignupError extends SignupStates {
  final String message;
  SignupError(this.message);
}
