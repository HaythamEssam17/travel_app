// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:travel_app/app/di/network_module.dart' as _i11;
import 'package:travel_app/app/di/register_module.dart' as _i851;
import 'package:travel_app/core/features/connectivity_feature/presentation/logic/connectivity_cubit.dart'
    as _i614;
import 'package:travel_app/features/auth/data/datasources/auth_local_ds.dart'
    as _i96;
import 'package:travel_app/features/auth/data/datasources/auth_remote_ds.dart'
    as _i458;
import 'package:travel_app/features/auth/data/repositories/auth_repository_impl.dart'
    as _i272;
import 'package:travel_app/features/auth/domain/repositories/auth_repository.dart'
    as _i382;
import 'package:travel_app/features/auth/domain/usecases/splash_usecase.dart'
    as _i975;
import 'package:travel_app/features/auth/presentation/blocs/login_cubit/login_cubit.dart'
    as _i169;
import 'package:travel_app/features/auth/presentation/blocs/splash_cubit/splash_cubit.dart'
    as _i278;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage(),
      preResolve: true,
    );
    gh.factory<_i169.LoginCubit>(() => _i169.LoginCubit());
    gh.factory<_i614.ConnectivityCubit>(() => _i614.ConnectivityCubit());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i895.Connectivity>(() => networkModule.connectivity);
    gh.factory<_i458.AuthRemoteDataSource>(
      () => _i458.AuthRemoteDataSourceImpl(),
    );
    gh.factory<_i96.AuthLocalDataSource>(() => _i96.AuthLocalDataSourceImpl());
    gh.lazySingleton<_i382.IAuthRepository>(
      () => _i272.AuthRepositoryImpl(
        gh<_i458.AuthRemoteDataSource>(),
        gh<_i96.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i975.SplashUseCase>(
      () => _i975.SplashUseCase(gh<_i382.IAuthRepository>()),
    );
    gh.factory<_i278.SplashCubit>(
      () => _i278.SplashCubit(gh<_i975.SplashUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i851.RegisterModule {}

class _$NetworkModule extends _i11.NetworkModule {}
