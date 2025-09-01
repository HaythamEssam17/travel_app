import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:travel_app/core/helpers/keys.dart';
import 'package:travel_app/core/services/service_provider.dart';
import 'package:travel_app/features/auth/data/models/login_response.dart';
import 'package:travel_app/features/search/data/models/flight_model.dart';
import 'package:travel_app/features/search/data/models/hotel_model.dart';

class HiveServiceProvider implements ServiceProvider {
  static final HiveServiceProvider _instance = HiveServiceProvider._();

  static HiveServiceProvider get i => _instance;

  HiveServiceProvider._();

  @override
  Future<void> register() async {
    await Hive.initFlutter();

    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(LoginResponseAdapter());
    Hive.registerAdapter(FlightModelAdapter());
    Hive.registerAdapter(HotelModelAdapter());

    // await deleteBox(LocalKeys.userBox);
    // await deleteBox(LocalKeys.loginResponseBox);

    await Future.wait([
      openBox<String>(LocalKeys.userBox),
      openBox<LoginResponse>(LocalKeys.loginResponseBox),
      openBox<String>(LocalKeys.flightsCacheBoxKey),
      openBox<String>(LocalKeys.hotelsCacheBoxKey),
    ]);
  }

  Future<void> deleteBox(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }

  Future<void> openBox<T>(boxName) async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        await Hive.openBox<T>('$boxName');
      }
    } catch (error) {
      await Hive.deleteBoxFromDisk(boxName);
      await Hive.openBox<T>(boxName);
    }
  }

  Box<String> get userBox => Hive.box<String>(LocalKeys.userBox);

  Box<String> get _flightsBox => Hive.box<String>(LocalKeys.flightsCacheBoxKey);

  Box<Map<String, dynamic>> get _hotelsBox =>
      Hive.box<Map<String, dynamic>>(LocalKeys.hotelsCacheBoxKey);

  Box<LoginResponse> get loginBox =>
      Hive.box<LoginResponse>(LocalKeys.loginResponseBox);

  Future<void> saveUser(User user) async {
    final String jsonString = jsonEncode(user);
    await userBox.put(LocalKeys.userKey, jsonString);
  }

  Future<void> saveLoginResponse(LoginResponse response) async {
    await loginBox.put(LocalKeys.loginResponseKey, response);
  }

  Map<String, dynamic>? getUser() {
    final jsonString = userBox.get(LocalKeys.userKey);
    if (jsonString == null) return null;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  LoginResponse? getLoginResponse() => loginBox.get(LocalKeys.loginResponseBox);

  Future<void> logout() async {
    await userBox.clear();
    await loginBox.clear();
  }

  Future<void> saveFlights(Map<String, dynamic> flightsMap) async {
    final String jsonString = jsonEncode(flightsMap);
    await _flightsBox.put(LocalKeys.flightsCacheKey, jsonString);
  }

  Map<String, dynamic>? getFlights() {
    final jsonString = _flightsBox.get(LocalKeys.flightsCacheKey);
    if (jsonString == null) return null;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  Future<void> saveHotels(Map<String, dynamic> data) async {
    await _hotelsBox.put(LocalKeys.hotelsCacheKey, data);
  }

  Map<String, dynamic>? getHotels() => _hotelsBox.get(LocalKeys.hotelsCacheKey);
}
