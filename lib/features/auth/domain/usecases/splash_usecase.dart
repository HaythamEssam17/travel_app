import 'package:injectable/injectable.dart';

import '../../data/models/user_credentials_model.dart';
import '../repositories/auth_repository.dart';

@injectable
class SplashUseCase {
  final IAuthRepository _authRepository;

  SplashUseCase(this._authRepository);

  Future<UserCredentialsModel?> getUser() async {
    return _authRepository.getUser();
  }

  Future<bool> isLoggedIn() async {
    return await _authRepository.isLoggedIn();
  }

  Future<void> setLoggedIn(bool value) async {
    return await _authRepository.setLoggedIn(value);
  }

  Future<void> clearUser() async {
    return await _authRepository.clearUser();
  }
}
