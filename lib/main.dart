import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:travel_app/app/di/injection.dart';

import 'app/my_app.dart';
import 'app/observers/bloc_observer.dart';
import 'core/network/error_handling/dio_exception.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final WidgetsBinding bind = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bind);

  await Future.delayed(Duration(seconds: 2));

  FlutterNativeSplash.remove();

  FlutterError.onError = DioExceptions.onFlutterError;

  /// This function is to check the security of the app.
  /*
    [ParamsAppCheck] is a model contains the params we have to check,
    Params default values are equals to false
  */
  // checkAppSecurity(
  //   paramsAppCheck: AppSecurityModel(
  //     isEmulated: true,
  //     canMockLocation: true,
  //     onExternalStorage: true,
  //     isRooted: true,
  //     onDevMode: true,
  //   ),
  // );

  /// Initialize .Env Environment to load the file.
  await dotenv.load(fileName: ".env");

  // /// Initialize local storage
  // await SharedPrefs.init();

  /// Initialize the Injections
  await configureDependencies();

  // /// Initialize Dio SIngleton Instance
  // DioHelper.instance;

  Bloc.observer = MyBlocObserver();

  // final appRouter = AppRouter(authGuard: AuthGuard());

  runApp(const MyApp());
}
