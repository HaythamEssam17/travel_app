import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_app/core/network/dio_base_execute.dart';
import 'package:travel_app/core/network/error_handling/custom_error.dart';
import 'package:travel_app/features/auth/data/models/user_credentials_model.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/network/dio_client.dart';

abstract class AuthRemoteDataSource {
  Future<Either<CustomError, UserCredentialsModel>> login(
    String username,
    String password,
  );

  Future<void> logout();

  Future<void> refreshToken();

  Future<Either<CustomError, UserCredentialsModel>> signup(
    String username,
    String phone,
  );
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Either<CustomError, UserCredentialsModel>> login(
    String username,
    String password,
  ) async {
    return executeAndHandleError(() async {
      final dioHelper = getIt<DioHelper>();

      var url = dotenv.get('request_access_token');
      var clientId = dotenv.get('client_id');
      var clientSecret = dotenv.get('client_secret');
      var grantType = dotenv.get('grant_type');

      Map<String, dynamic> data = {
        'client_id': clientId,
        'client_secret': clientSecret,
        'grant_type': grantType,
      };

      var response = await dioHelper.postData(url: url, data: data);

      if (response.statusCode != 200) {
        throw Exception('Failed to login');
      }

      UserCredentialsModel userCredentials = UserCredentialsModel.fromJson(
        response.data,
      );

      return userCredentials;
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
  Future<Either<CustomError, UserCredentialsModel>> signup(
    String username,
    String phone,
  ) async {
    return executeAndHandleError(() async {
      final dioHelper = getIt<DioHelper>();

      var url = dotenv.get('request_access_token');
      var clientId = dotenv.get('client_id');
      var clientSecret = dotenv.get('client_secret');
      var grantType = dotenv.get('grant_type');

      Map<String, dynamic> data = {
        'client_id': clientId,
        'client_secret': clientSecret,
        'grant_type': grantType,
      };

      var response = await dioHelper.postData(url: url, data: data);

      if (response.statusCode != 200) {
        throw Exception('Failed to login');
      }

      UserCredentialsModel userCredentials = UserCredentialsModel.fromJson(
        response.data,
      );

      return userCredentials;
    });
  }
}
