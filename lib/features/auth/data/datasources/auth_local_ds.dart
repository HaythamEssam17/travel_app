import 'package:injectable/injectable.dart';

import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<User?> getUser();
  Future<void> saveUser(User user);
  Future<void> clearUser();
}

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  User? _cachedUser;

  @override
  Future<User?> getUser() async {
    // هنا تحطي SharedPreferences أو Hive أو أي DB
    // أنا عامل mock للتوضيح
    return _cachedUser;
  }

  @override
  Future<void> saveUser(User user) async {
    _cachedUser = user;
  }

  @override
  Future<void> clearUser() async {
    _cachedUser = null;
  }
}
