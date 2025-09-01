import '../../data/models/login_response.dart';

abstract class IAuthMockRepository {
  Future<LoginResponse> login(String email, String password);

  Future<LoginResponse> signup(
    String name,
    String email,
    String password,
    String role,
  );

  Future<LoginResponse> refresh(String refreshToken);

  Future<void> logout();

  Future<User?> getUser();
}
