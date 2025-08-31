import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_app/features/auth/data/models/user_credentials_model.dart';

import '../../../../core/network/error_handling/custom_error.dart';
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
  Future<Either<CustomError, UserCredentialsModel>> login(
    String username,
    String password,
  ) async {
    return await remote.login(username, password).then((value) {
      return value.fold((l) => left(l), (r) async {
        await local.saveUser(r);
        return right(r);
      });
    });
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
    return await local.isLoggedIn();
  }

  @override
  Future<void> setLoggedIn(bool value) async {
    return await local.setLoggedIn(value);
  }

  @override
  Future<UserCredentialsModel?> getUser() async {
    return await local.getUser();
  }

  @override
  Future<void> clearUser() async {
    return await local.clearUser();
  }
}
