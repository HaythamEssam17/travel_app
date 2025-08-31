import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../core/network/dio_client.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.get('base_url'),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(
      LogInterceptor(request: true, requestBody: true, responseBody: true),
    );

    return dio;
  }

  @lazySingleton
  DioHelper dioHelper(Dio dio) => DioHelper(dio);

  @preResolve
  Future<FlutterSecureStorage> secureStorage() async =>
      const FlutterSecureStorage();
}
