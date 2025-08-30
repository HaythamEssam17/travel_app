import '../../data/models/user_model.dart';

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> logout();
  Future<void> signup(String username, String phone);
  Future<void> refreshToken();
  Future<bool> isLoggedIn();
  Future<User?> getUser();
}
