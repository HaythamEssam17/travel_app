import 'package:injectable/injectable.dart';

import '../repositories/auth_mock_repository.dart';

@injectable
class LogoutUseCase {
  final IAuthMockRepository _iAuthMockRepository;

  LogoutUseCase(this._iAuthMockRepository);

  Future<void> logoutMockData() async {
    return await _iAuthMockRepository.logout();
  }
}
