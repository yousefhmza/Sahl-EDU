import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sahl_edu/modules/auth/cubits/login_cubit/login_cubit.dart';
import 'package:sahl_edu/modules/auth/cubits/password_cubit/password_cubit.dart';
import 'package:sahl_edu/modules/auth/cubits/signup_cubit/signup_cubit.dart';
import 'package:sahl_edu/modules/auth/repositories/login_repository.dart';
import 'package:sahl_edu/modules/auth/repositories/password_repository.dart';
import 'package:sahl_edu/modules/auth/repositories/signup_repository.dart';
import 'package:sahl_edu/modules/splash/cubits/splash_cubit.dart';
import 'package:sahl_edu/modules/splash/repositories/splash_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/local/cache_consumer.dart';
import 'core/services/network/api_consumer.dart';
import 'core/services/network/network_info.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // external
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<PrettyDioLogger>(
    () => PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true),
  );

  // core
  sl.registerLazySingleton<CacheConsumer>(() => CacheConsumer(sl<SharedPreferences>(), sl<FlutterSecureStorage>()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo(sl<Connectivity>()));
  sl.registerLazySingleton<ApiConsumer>(() => ApiConsumer(sl<Dio>(), sl<CacheConsumer>(), sl<PrettyDioLogger>()));

  // Repositories
  sl.registerLazySingleton<SplashRepository>(() => SplashRepository(sl<NetworkInfo>()));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepository(sl<NetworkInfo>()));
  sl.registerLazySingleton<SignupRepository>(() => SignupRepository(sl<NetworkInfo>()));
  sl.registerLazySingleton<PasswordRepository>(() => PasswordRepository(sl<NetworkInfo>()));

  // Cubits
  sl.registerFactory<SplashCubit>(() => SplashCubit(sl<SplashRepository>()));
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl<LoginRepository>()));
  sl.registerFactory<SignupCubit>(() => SignupCubit(sl<SignupRepository>()));
  sl.registerFactory<PasswordCubit>(() => PasswordCubit(sl<PasswordRepository>()));
}
