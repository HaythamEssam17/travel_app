import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_credentials_model.dart';

abstract class AuthLocalDataSource {
  Future<bool> isLoggedIn();

  Future<void> setLoggedIn(bool value);

  Future<UserCredentialsModel?> getUser();

  Future<void> saveUser(UserCredentialsModel user);

  Future<void> clearUser();
}

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  UserCredentialsModel? _cachedUser;
  static const String _keyIsLoggedIn = 'is_logged';
  static const String _keyUserData = 'user_data';

  final FlutterSecureStorage _storage;

  AuthLocalDataSourceImpl(this._storage);

  @override
  Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: _keyIsLoggedIn);
    return value == 'true';
  }

  @override
  Future<void> setLoggedIn(bool value) async {
    await _storage.write(key: _keyIsLoggedIn, value: value.toString());
  }

  @override
  Future<UserCredentialsModel?> getUser() async {
    final dioHelper = getIt<DioHelper>();

    var headers = dioHelper.dio.options.headers;

    if (!headers.containsKey('client_id')) {
      headers['client_id'] = dotenv.get('client_id');
    }
    if (!headers.containsKey('grant_type')) {
      headers['grant_type'] = dotenv.get('grant_type');
    }
    if (!headers.containsKey('client_secret')) {
      headers['client_secret'] = dotenv.get('client_secret');
    }

    String? userData = await _storage.read(key: _keyUserData);

    if (userData != null) {
      UserCredentialsModel? uData = await getUserCredentials();

      _cachedUser = uData;
    }
    return _cachedUser;
  }

  Future<UserCredentialsModel?> getUserCredentials() async {
    final jsonString = await _storage.read(key: _keyUserData);
    if (jsonString == null) return null;

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return UserCredentialsModel.fromJson(jsonMap);
  }

  @override
  Future<void> saveUser(UserCredentialsModel user) async {
    final dioHelper = getIt<DioHelper>();
    var headers = dioHelper.dio.options.headers;
    headers['access_token'] = 'Bearer ${user.accessToken}';

    await _storage.write(key: _keyUserData, value: jsonEncode(user.toJson()));

    _cachedUser = user;
  }

  @override
  Future<void> clearUser() async {
    await _storage.delete(key: _keyUserData);
    await _storage.delete(key: _keyIsLoggedIn);
    _cachedUser = null;
  }
}
