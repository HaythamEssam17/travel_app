part of 'auth_bloc.dart';

abstract class AuthStates {}

class AuthInit extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthSuccess extends AuthStates {}

class AuthError extends AuthStates {
  final String message;

  AuthError(this.message);
}
