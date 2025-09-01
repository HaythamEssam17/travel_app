import 'package:injectable/injectable.dart';
import 'package:travel_app/features/auth/domain/repositories/auth_mock_repository.dart';

import '../../data/models/login_response.dart';
import '../../data/models/user_credentials_model.dart';
import '../repositories/auth_repository.dart';

@injectable
class SplashUseCase {
  final IAuthRepository _authRepository;
  final IAuthMockRepository _authMockRepository;

  SplashUseCase(this._authRepository, this._authMockRepository);

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

  Future<User?> getMockUser() async {
    return await _authMockRepository.getUser();
  }
}
