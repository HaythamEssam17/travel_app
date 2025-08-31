import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_app/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/network/error_handling/custom_error.dart';
import '../../data/models/user_credentials_model.dart';

@injectable
class LoginUseCase {
  final IAuthRepository _iAuthRepository;

  LoginUseCase(this._iAuthRepository);

  Future<Either<CustomError, UserCredentialsModel>> login(
    String email,
    String password,
  ) async {
    return await _iAuthRepository.login(email, password);
  }
}
