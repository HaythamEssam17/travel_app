import 'package:injectable/injectable.dart';

import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

@injectable
class SplashUseCase {
  final IAuthRepository _authRepository;

  SplashUseCase(this._authRepository);

  Future<User?> getUser() async {
    return _authRepository.getUser();
  }
}
