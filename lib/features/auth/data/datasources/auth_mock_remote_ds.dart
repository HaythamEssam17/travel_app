import 'package:injectable/injectable.dart';
import 'package:travel_app/features/auth/data/models/login_response.dart';

abstract class AuthMockRemoteDataSource {
  Future<LoginResponse> login(String email, String password);

  Future<LoginResponse> signup(
    String name,
    String email,
    String password,
    String role,
  );

  Future<LoginResponse> refresh(String refreshToken);
}

@Injectable(as: AuthMockRemoteDataSource)
class AuthMockRemoteDataSourceImpl implements AuthMockRemoteDataSource {
  @override
  Future<LoginResponse> login(String email, String password) async {
    // mock response
    return LoginResponse(
      accessToken: "mock_access_token:9435yn43u5y4u535m9um04",
      refreshToken: "mock_refresh:token:tttttttttttttttttttttt",
      user: User(id: "1", name: "Ali", role: "B2C", email: 'ali@2.com'),
    );
  }

  @override
  Future<LoginResponse> signup(
    String name,
    String email,
    String password,
    String role,
  ) async {
    return LoginResponse(
      accessToken: "mock_access",
      refreshToken: "mock_refresh",
      user: User(id: "2", name: name, role: role, email: '$name@$name.com'),
    );
  }

  @override
  Future<LoginResponse> refresh(String refreshToken) async {
    return LoginResponse(
      accessToken: "new_access",
      refreshToken: "new_refresh",
      user: User(id: "1", name: "Ali", role: "B2C", email: 'ali@2.com'),
    );
  }
}
