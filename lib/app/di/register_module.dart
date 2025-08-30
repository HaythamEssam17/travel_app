import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio() => Dio(
    BaseOptions(
      baseUrl: dotenv.env['base_url'] ?? '',
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
      receiveDataWhenStatusError: true,
    ),
  );

  @preResolve
  Future<FlutterSecureStorage> secureStorage() async =>
      const FlutterSecureStorage();
}
