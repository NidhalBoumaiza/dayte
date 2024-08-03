import 'package:client/features/authorisation/domain%20layer/usecases/change_password_use_case.dart';
import 'package:client/features/authorisation/domain%20layer/usecases/login_with_phone_number_use_case.dart';
import 'package:client/features/authorisation/domain%20layer/usecases/register_use_case.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/register%20bloc/register_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/cubit/first%20image%20cubit/first_image_cubit.dart';
import 'package:client/features/authorisation/presentation%20layer/cubit/forget%20password%20cubit/forget_password__cubit.dart';
import 'package:client/features/dates/domain%20layer/repositories/date_repository.dart';
import 'package:client/features/dates/domain%20layer/usecases/edit_profile_use_case.dart';
import 'package:client/features/dates/domain%20layer/usecases/get_recommendation_use_case.dart';
import 'package:client/features/dates/presentation%20layer/bloc/date%20bloc/date_bloc.dart';
import 'package:client/features/dates/presentation%20layer/bloc/like%20recommendation%20cubit/like_recommendation__cubit.dart';
import 'package:client/features/dates/presentation%20layer/cubit/cancel_date_cubit/cancel_date_cubit.dart';
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
import 'features/authorisation/domain layer/usecases/forgot_password_use_case.dart';
import 'features/authorisation/domain layer/usecases/get_profile_use_case.dart';
import 'features/authorisation/domain layer/usecases/reset_password_use_case.dart';
import 'features/authorisation/domain layer/usecases/send_verification_code_use_case.dart';
import 'features/authorisation/domain layer/usecases/sign_out.dart';
import 'features/authorisation/domain layer/usecases/update_coordinate.dart';
import 'features/authorisation/domain layer/usecases/verify_phone_number_use_case.dart';
import 'features/authorisation/presentation layer/bloc/get profile bloc/get_profile_bloc.dart';
import 'features/authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import 'features/authorisation/presentation layer/bloc/update_coordinate_bloc/update_coordinate_bloc.dart';
import 'features/authorisation/presentation layer/cubit/change password cubit/change_password__cubit.dart';
import 'features/dates/data layer/data sources/date_remote_data_source.dart';
import 'features/dates/data layer/repositories/date_repository_impl.dart';
import 'features/dates/domain layer/usecases/cancel_date.dart';
import 'features/dates/domain layer/usecases/get_user_matches.dart';
import 'features/dates/domain layer/usecases/like_recommendation_use_case.dart';
import 'features/dates/presentation layer/cubit/bottom_navigation_bar_cubit.dart';
import 'features/dates/presentation layer/cubit/edit image/edit_image_cubit.dart';
import 'features/dates/presentation layer/cubit/edit profile cubit/edit_profile_cubit.dart';
import 'features/dates/presentation layer/cubit/get matches cubit/get_matches_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => EditProfileCubit(editProfileUseCase: sl()));
  sl.registerFactory(() => EditImageCubit());
  sl.registerFactory(() => CancelDateCubit(cancelDateUseCase: sl()));
  sl.registerFactory(() => GetMatchesCubit(getUserMatches: sl()));
  sl.registerFactory(() => ForgetPasswordCubit(
      resetPasswordUseCase: sl(), forgetPasswordUseCase: sl()));
  sl.registerFactory(() => ChangePasswordCubit(changePasswordUseCase: sl()));
  sl.registerFactory(
      () => LikeRecommendationCubit(likeRecommendationUseCase: sl()));
  sl.registerFactory(() => DateBloc(getRecommendationUseCase: sl()));
  sl.registerFactory(() => SignOutBloc(signOut: sl()));
  sl.registerFactory(() => GetProfileBloc(getProfileUseCase: sl()));
  sl.registerFactory(() => FirstImageCubit());
  sl.registerFactory(() => BottomNavigationCubit());
  sl.registerFactory(() => RegisterBloc(
        registerUseCase: sl(),
        verifyPhoneNumberUseCase: sl(),
        sendVerificationCodeUseCase: sl(),
        finishProfileUseCase: sl(),
        loginWithPhoneNumberUserCase: sl(),
      ));
  sl.registerFactory(() => UpdateCoordinateBloc(updateCoordinateUseCase: sl()));
  // Use Cases
  sl.registerLazySingleton(() => EditProfileUseCase(sl()));
  sl.registerLazySingleton(() => CancelDateUseCase(sl()));
  sl.registerLazySingleton(() => GetUserMatches(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => LikeRecommendationUseCase(sl()));
  sl.registerLazySingleton(() => GetRecommendationUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => LoginWithPhoneNumberUserCase(sl()));
  sl.registerLazySingleton(() => UpdateCoordinateUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => VerifyPhoneNumberUseCase(sl()));
  sl.registerLazySingleton(() => SendVerificationCodeUseCase(sl()));
  sl.registerLazySingleton(() => FinishProfileUseCase(sl()));

  // Repository
  sl.registerLazySingleton<DateRepository>(() => DateRepositoryImpl(
        dateRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        userRemoteDataSource: sl(),
        userLocalDataSource: sl(),
        networkInfo: sl(),
      ));
  // Data Sources
  sl.registerLazySingleton<DateRemoteDataSource>(
      () => DateRemoteDataSource(client: sl()));
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
