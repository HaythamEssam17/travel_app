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
import 'package:travel_app/app/router/guards.dart' as _i347;
import 'package:travel_app/core/features/connectivity_feature/presentation/logic/connectivity_cubit.dart'
    as _i614;
import 'package:travel_app/core/network/dio_client.dart' as _i162;
import 'package:travel_app/features/auth/data/datasources/auth_local_ds.dart'
    as _i96;
import 'package:travel_app/features/auth/data/datasources/auth_mock_local_ds.dart'
    as _i574;
import 'package:travel_app/features/auth/data/datasources/auth_mock_remote_ds.dart'
    as _i124;
import 'package:travel_app/features/auth/data/datasources/auth_remote_ds.dart'
    as _i458;
import 'package:travel_app/features/auth/data/repositories/auth_mock_repository_impl.dart'
    as _i604;
import 'package:travel_app/features/auth/data/repositories/auth_repository_impl.dart'
    as _i272;
import 'package:travel_app/features/auth/domain/repositories/auth_mock_repository.dart'
    as _i653;
import 'package:travel_app/features/auth/domain/repositories/auth_repository.dart'
    as _i382;
import 'package:travel_app/features/auth/domain/usecases/login.dart' as _i531;
import 'package:travel_app/features/auth/domain/usecases/logout.dart' as _i461;
import 'package:travel_app/features/auth/domain/usecases/signup.dart' as _i1059;
import 'package:travel_app/features/auth/domain/usecases/splash_usecase.dart'
    as _i975;
import 'package:travel_app/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart'
    as _i570;
import 'package:travel_app/features/auth/presentation/blocs/login_cubit/login_cubit.dart'
    as _i169;
import 'package:travel_app/features/auth/presentation/blocs/signup_cubit/signup_cubit.dart'
    as _i288;
import 'package:travel_app/features/auth/presentation/blocs/splash_cubit/splash_cubit.dart'
    as _i278;
import 'package:travel_app/features/booking/data/datasources/booking_remote_ds.dart'
    as _i992;
import 'package:travel_app/features/booking/data/repositories/booking_repo_impl.dart'
    as _i711;
import 'package:travel_app/features/booking/domain/repositories/booking_repo.dart'
    as _i155;
import 'package:travel_app/features/booking/domain/usecases/cancel_booking.dart'
    as _i577;
import 'package:travel_app/features/booking/domain/usecases/create_booking.dart'
    as _i528;
import 'package:travel_app/features/booking/domain/usecases/watch_booking_status.dart'
    as _i586;
import 'package:travel_app/features/booking/presentation/blocs/booking_cubit.dart'
    as _i769;
import 'package:travel_app/features/search/data/data_source/flight_remote_ds.dart'
    as _i517;
import 'package:travel_app/features/search/data/data_source/hotel_remote_ds.dart'
    as _i562;
import 'package:travel_app/features/search/data/data_source/mock_flight_remote_ds.dart'
    as _i201;
import 'package:travel_app/features/search/data/data_source/mock_hotel_remote_ds.dart'
    as _i654;
import 'package:travel_app/features/search/data/repository/search_repository_impl.dart'
    as _i62;
import 'package:travel_app/features/search/domain/repository/search_repository.dart'
    as _i971;
import 'package:travel_app/features/search/domain/usecase/hotel_search.dart'
    as _i503;
import 'package:travel_app/features/search/domain/usecase/search_flights.dart'
    as _i156;
import 'package:travel_app/features/search/presentation/bloc/flight_search/flight_search_cubit.dart'
    as _i774;
import 'package:travel_app/features/search/presentation/bloc/hotel_search/hotel_search_cubit.dart'
    as _i371;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i614.ConnectivityCubit>(() => _i614.ConnectivityCubit());
    await gh.factoryAsync<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage(),
      preResolve: true,
    );
    gh.factory<_i288.SignupCubit>(() => _i288.SignupCubit());
    gh.lazySingleton<_i895.Connectivity>(() => networkModule.connectivity);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.factory<_i458.AuthRemoteDataSource>(
      () => _i458.AuthRemoteDataSourceImpl(),
    );
    gh.factory<_i562.HotelRemoteDataSource>(
      () => _i654.HotelRemoteDataSourceMock(),
    );
    gh.factory<_i124.AuthMockRemoteDataSource>(
      () => _i124.AuthMockRemoteDataSourceImpl(),
    );
    gh.factory<_i992.BookingRemoteDataSource>(
      () => _i992.BookingRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i162.DioHelper>(
      () => registerModule.dioHelper(gh<_i361.Dio>()),
    );
    gh.factory<_i574.AuthMockLocalDataSource>(
      () => _i574.AuthMockLocalDataSourceImpl(),
    );
    gh.factory<_i517.FlightRemoteDataSource>(
      () => _i201.MockFlightRemoteDataSource(),
    );
    gh.factory<_i96.AuthLocalDataSource>(
      () => _i96.AuthLocalDataSourceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i155.IBookingRepository>(
      () => _i711.BookingRepositoryImpl(gh<_i992.BookingRemoteDataSource>()),
    );
    gh.factory<_i653.IAuthMockRepository>(
      () => _i604.AuthMockRepositoryImpl(
        gh<_i124.AuthMockRemoteDataSource>(),
        gh<_i574.AuthMockLocalDataSource>(),
      ),
    );
    gh.factory<_i971.ISearchRepository>(
      () => _i62.SearchRepositoryImpl(
        flightRemote: gh<_i517.FlightRemoteDataSource>(),
        hotelRemote: gh<_i562.HotelRemoteDataSource>(),
      ),
    );
    gh.factory<_i382.IAuthRepository>(
      () => _i272.AuthRepositoryImpl(
        gh<_i458.AuthRemoteDataSource>(),
        gh<_i96.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i347.AuthGuard>(
      () => _i347.AuthGuard(gh<_i653.IAuthMockRepository>()),
    );
    gh.factory<_i347.RoleGuard>(
      () => _i347.RoleGuard(gh<_i653.IAuthMockRepository>()),
    );
    gh.factory<_i975.SplashUseCase>(
      () => _i975.SplashUseCase(
        gh<_i382.IAuthRepository>(),
        gh<_i653.IAuthMockRepository>(),
      ),
    );
    gh.factory<_i461.LogoutUseCase>(
      () => _i461.LogoutUseCase(gh<_i653.IAuthMockRepository>()),
    );
    gh.factory<_i503.SearchHotels>(
      () => _i503.SearchHotels(gh<_i971.ISearchRepository>()),
    );
    gh.factory<_i156.SearchFlights>(
      () => _i156.SearchFlights(gh<_i971.ISearchRepository>()),
    );
    gh.factory<_i528.CreateBooking>(
      () => _i528.CreateBooking(gh<_i155.IBookingRepository>()),
    );
    gh.factory<_i586.WatchBookingStatus>(
      () => _i586.WatchBookingStatus(gh<_i155.IBookingRepository>()),
    );
    gh.factory<_i577.CancelBooking>(
      () => _i577.CancelBooking(gh<_i155.IBookingRepository>()),
    );
    gh.factory<_i531.LoginUseCase>(
      () => _i531.LoginUseCase(
        gh<_i382.IAuthRepository>(),
        gh<_i653.IAuthMockRepository>(),
      ),
    );
    gh.factory<_i1059.SignupUseCase>(
      () => _i1059.SignupUseCase(gh<_i382.IAuthRepository>()),
    );
    gh.factory<_i371.HotelSearchCubit>(
      () => _i371.HotelSearchCubit(gh<_i503.SearchHotels>()),
    );
    gh.factory<_i570.AuthCubit>(
      () => _i570.AuthCubit(gh<_i461.LogoutUseCase>()),
    );
    gh.factory<_i169.LoginCubit>(
      () => _i169.LoginCubit(gh<_i531.LoginUseCase>()),
    );
    gh.factory<_i774.FlightSearchCubit>(
      () => _i774.FlightSearchCubit(gh<_i156.SearchFlights>()),
    );
    gh.factory<_i278.SplashCubit>(
      () => _i278.SplashCubit(gh<_i975.SplashUseCase>()),
    );
    gh.factory<_i769.BookingCubit>(
      () => _i769.BookingCubit(
        gh<_i528.CreateBooking>(),
        gh<_i586.WatchBookingStatus>(),
        gh<_i577.CancelBooking>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i851.RegisterModule {}

class _$NetworkModule extends _i11.NetworkModule {}
