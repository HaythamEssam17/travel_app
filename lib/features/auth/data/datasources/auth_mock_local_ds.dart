import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_app/core/helpers/shared_texts.dart';
import 'package:travel_app/core/services/hive_service.dart';

import '../../../../core/helpers/keys.dart';
import '../models/login_response.dart';

abstract class AuthMockLocalDataSource {
  Future<void> saveTokens(String access, String refresh);

  Future<void> saveUser(User user);

  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<User?> getUser();

  Future<void> clear();
}

@Injectable(as: AuthMockLocalDataSource)
class AuthMockLocalDataSourceImpl implements AuthMockLocalDataSource {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final HiveServiceProvider _hiveServiceProvider = HiveServiceProvider.i;

  AuthMockLocalDataSourceImpl();

  @override
  Future<void> saveTokens(String access, String refresh) async {
    await _secureStorage.write(key: LocalKeys.accessTokenKey, value: access);
    await _secureStorage.write(key: LocalKeys.refreshTokenKey, value: refresh);
  }

  @override
  Future<String?> getAccessToken() =>
      _secureStorage.read(key: LocalKeys.accessTokenKey);

  @override
  Future<String?> getRefreshToken() =>
      _secureStorage.read(key: LocalKeys.refreshTokenKey);

  @override
  Future<void> saveUser(User user) async {
    await _hiveServiceProvider.saveUser(user);

    SharedText.user = user;
  }

  @override
  Future<User?> getUser() async {
    final Map<String, dynamic>? data = _hiveServiceProvider.getUser();

    if (data != null) {
      var user = User.fromJson(Map<String, dynamic>.from(data));
      SharedText.user = user;

      return user;
    }
    return null;
  }

  @override
  Future<void> clear() async {
    await _secureStorage.deleteAll();

    await _hiveServiceProvider.logout();
  }
}
