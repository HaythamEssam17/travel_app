import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_app/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/network/error_handling/custom_error.dart';
import '../../data/models/user_credentials_model.dart';

@injectable
class SignupUseCase {
  final IAuthRepository _iAuthRepository;

  SignupUseCase(this._iAuthRepository);

  Future<Either<CustomError, UserCredentialsModel>> signup(
    String username,
    String phone,
  ) async {
    return await _iAuthRepository.signup(username, phone);
  }
}
