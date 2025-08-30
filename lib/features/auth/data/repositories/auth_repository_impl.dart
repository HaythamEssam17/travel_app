import 'package:injectable/injectable.dart';
import 'package:travel_app/features/auth/data/models/user_model.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_ds.dart';
import '../datasources/auth_remote_ds.dart';

@LazySingleton(as: IAuthRepository)
@Injectable(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImpl(this.remote, this.local);

  @override
  Future<void> login(String username, String password) async {
    // TODO: implement login
  }

  @override
  Future<void> logout() async {
    // TODO: implement logout
  }

  @override
  Future<void> refreshToken() async {
    // TODO: implement refreshToken
  }

  @override
  Future<void> signup(String username, String phone) async {
    // TODO: implement signup
  }

  @override
  Future<bool> isLoggedIn() async {
    return false;
  }

  @override
  Future<User?> getUser() async {
    return await local.getUser();
  }
}
