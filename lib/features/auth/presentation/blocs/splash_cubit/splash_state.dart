part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashAuthenticated extends SplashState {
  final User user;
  SplashAuthenticated(this.user);
}

class SplashUnauthenticated extends SplashState {}
