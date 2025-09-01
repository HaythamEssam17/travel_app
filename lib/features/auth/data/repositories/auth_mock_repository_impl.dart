import 'package:injectable/injectable.dart';

import '../../domain/repositories/auth_mock_repository.dart';
import '../datasources/auth_mock_local_ds.dart';
import '../datasources/auth_mock_remote_ds.dart';
import '../models/login_response.dart';

@Injectable(as: IAuthMockRepository)
class AuthMockRepositoryImpl implements IAuthMockRepository {
  final AuthMockRemoteDataSource remote;
  final AuthMockLocalDataSource local;

  AuthMockRepositoryImpl(this.remote, this.local);

  @override
  Future<LoginResponse> login(String email, String password) async {
    final res = await remote.login(email, password);
    await local.saveTokens(
      res.accessToken ?? 'accessToken',
      res.refreshToken ?? 'refreshToken',
    );
    await local.saveUser(res.user!);

    return res;
  }

  @override
  Future<LoginResponse> signup(
    String name,
    String email,
    String password,
    String role,
  ) async {
    final res = await remote.signup(name, email, password, role);
    await local.saveTokens(
      res.accessToken ?? 'accessToken',
      res.refreshToken ?? 'refreshToken',
    );
    await local.saveUser(res.user!);
    return res;
  }

  @override
  Future<LoginResponse> refresh(String refreshToken) async {
    final res = await remote.refresh(refreshToken);
    await local.saveTokens(
      res.accessToken ?? 'accessToken',
      res.refreshToken ?? 'refreshToken',
    );
    return res;
  }

  @override
  Future<void> logout() async => await local.clear();

  @override
  Future<User?> getUser() async => await local.getUser();
}
