import 'package:client/features/authorisation/presentation%20layer/pages/signin_screen.dart';
import 'package:client/testStripe/stripe_payment/stripe_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/authorisation/presentation layer/bloc/register_bloc.dart';
import 'features/authorisation/presentation layer/cubit/first image cubit/first_image_cubit.dart';
import 'features/dates/presentation layer/cubit/bottom_navigation_bar_cubit.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await dotenv.load(fileName: ".env");
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  // final token = sharedPreferences.getString('token');
  // Widget screen;
  // if (token != null) {
  //   screen = const HomeScreenSquelette();
  // } else {
  //   screen = const SignInScreen();
  // }
  Stripe.publishableKey = ApiKeys.pusblishableKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<FirstImageCubit>()),
        BlocProvider(create: (context) => di.sl<BottomNavigationCubit>()),
        BlocProvider(create: (context) => di.sl<RegisterBloc>()),
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
              home: SignInScreen(),
            );
          }),
    );
  }
}
