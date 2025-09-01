import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handling/custom_error.dart';
import '../../data/models/user_credentials_model.dart';

abstract class IAuthRepository {
  Future<Either<CustomError, UserCredentialsModel>> login(
    String username,
    String password,
  );

  Future<void> logout();

  Future<Either<CustomError, UserCredentialsModel>> signup(
    String username,
    String phone,
  );

  Future<void> refreshToken();

  Future<bool> isLoggedIn();

  Future<void> setLoggedIn(bool value);

  Future<void> clearUser();

  Future<UserCredentialsModel?> getUser();
}
