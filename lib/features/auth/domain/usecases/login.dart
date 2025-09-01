import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_app/features/auth/data/models/login_response.dart';
import 'package:travel_app/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/network/error_handling/custom_error.dart';
import '../../data/models/user_credentials_model.dart';
import '../repositories/auth_mock_repository.dart';

@injectable
class LoginUseCase {
  final IAuthRepository _iAuthRepository;
  final IAuthMockRepository _iAuthMockRepository;

  LoginUseCase(this._iAuthRepository, this._iAuthMockRepository);

  Future<Either<CustomError, UserCredentialsModel>> login(
    String email,
    String password,
  ) async {
    return await _iAuthRepository.login(email, password);
  }

  Future<LoginResponse> loginMockData(String email, String password) async {
    return await _iAuthMockRepository.login(email, password);
  }
}
