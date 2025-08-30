import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<void> login(String username, String password);

  Future<void> logout();

  Future<void> refreshToken();

  Future<void> signup(String username, String phone);
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
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
}
