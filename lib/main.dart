import 'package:client/features/authorisation/presentation%20layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/update_coordinate_bloc/update_coordinate_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/signin_screen.dart';
import 'package:client/features/dates/presentation%20layer/bloc/like%20recommendation%20cubit/like_recommendation__cubit.dart';
import 'package:client/features/dates/presentation%20layer/cubit/cancel_date_cubit/cancel_date_cubit.dart';
import 'package:client/testStripe/stripe_payment/stripe_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/authorisation/presentation layer/bloc/get profile bloc/get_profile_bloc.dart';
import 'features/authorisation/presentation layer/bloc/register bloc/register_bloc.dart';
import 'features/authorisation/presentation layer/cubit/change password cubit/change_password__cubit.dart';
import 'features/authorisation/presentation layer/cubit/first image cubit/first_image_cubit.dart';
import 'features/authorisation/presentation layer/cubit/forget password cubit/forget_password__cubit.dart';
import 'features/authorisation/presentation layer/pages/active_location_screen.dart';
import 'features/dates/presentation layer/bloc/date bloc/date_bloc.dart';
import 'features/dates/presentation layer/cubit/bottom_navigation_bar_cubit.dart';
import 'features/dates/presentation layer/cubit/get matches cubit/get_matches_cubit.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await dotenv.load(fileName: ".env");
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final token = sharedPreferences.getString('token');
  print(token);
  Widget screen;
  print(token != null);
  if (token != null) {
    screen = ActiveLocationScreen();
  } else {
    screen = const SignInScreen();
  }
  Stripe.publishableKey = ApiKeys.pusblishableKey;
  runApp(MyApp(
    screen: screen,
  ));
}

class MyApp extends StatelessWidget {
  Widget screen;

  MyApp({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<ForgetPasswordCubit>()),
        BlocProvider(create: (context) => di.sl<ChangePasswordCubit>()),
        BlocProvider(create: (context) => di.sl<LikeRecommendationCubit>()),
        BlocProvider(create: (context) => di.sl<FirstImageCubit>()),
        BlocProvider(create: (context) => di.sl<BottomNavigationCubit>()),
        BlocProvider(create: (context) => di.sl<RegisterBloc>()),
        BlocProvider(create: (context) => di.sl<UpdateCoordinateBloc>()),
        BlocProvider(create: (context) => di.sl<GetProfileBloc>()),
        BlocProvider(create: (context) => di.sl<SignOutBloc>()),
        BlocProvider(create: (context) => di.sl<DateBloc>()),
        BlocProvider(create: (context) => di.sl<GetMatchesCubit>()),
        BlocProvider(create: (context) => di.sl<CancelDateCubit>()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: screen,
            );
          }),
    );
  }
}
