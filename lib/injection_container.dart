import 'package:client/features/authorisation/domain%20layer/usecases/register_use_case.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/register_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/cubit/first%20image%20cubit/first_image_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/authorisation/data layer/data sources/user_local_data_source.dart';
import 'features/authorisation/data layer/data sources/user_remote_data_source.dart';
import 'features/authorisation/data layer/repositories/user_repository_impl.dart';
import 'features/authorisation/domain layer/repositories/user_repository.dart';
import 'features/authorisation/domain layer/usecases/finish_profile_use_case.dart';
import 'features/authorisation/domain layer/usecases/send_verification_code_use_case.dart';
import 'features/authorisation/domain layer/usecases/verify_phone_number_use_case.dart';
import 'features/dates/presentation layer/cubit/bottom_navigation_bar_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => FirstImageCubit());
  sl.registerFactory(() => BottomNavigationCubit());
  sl.registerFactory(() => RegisterBloc(
        registerUseCase: sl(),
        verifyPhoneNumberUseCase: sl(),
        sendVerificationCodeUseCase: sl(),
        finishProfileUseCase: sl(),
      ));
  // Use Cases
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => VerifyPhoneNumberUseCase(sl()));
  sl.registerLazySingleton(() => SendVerificationCodeUseCase(sl()));
  sl.registerLazySingleton(() => FinishProfileUseCase(sl()));
  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        userRemoteDataSource: sl(),
        userLocalDataSource: sl(),
        networkInfo: sl(),
      ));
  // Data Sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
