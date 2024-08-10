import 'dart:convert';

import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/my_customed_button.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/creation%20account%20screens/signup_step_one.dart';
import 'package:client/features/authorisation/presentation%20layer/widgets/snackBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant.dart';
import 'active_location_screen.dart';
import 'finishing account screens/account_creation_step_one.dart';
import 'login_with_phone_number.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false;
  String? accessTokenGoogle;
  String? accessTokenFacebook;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account != null) {
        GoogleSignInAuthentication authentication =
            await account.authentication;
        accessTokenGoogle = authentication.accessToken;
        print(accessTokenGoogle);
        var body = jsonEncode({"token": accessTokenGoogle});

        setState(() {
          isLoading = true;
        });
        print(111);

        // DIO INIT
        Dio dio = Dio();

        final response = await dio.post(
          '${dotenv.env['URL']}/user/google/',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
          data: {
            'token': accessTokenGoogle,
          },
        );
        print(response.data);
        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.data);
          final token = responseBody['token'];
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('token', token);
          navigateToAnotherScreenWithFadeTransition(
              context, ActiveLocationScreen());
        } else if (response.statusCode == 206) {
          final responseBody = jsonDecode(response.data);
          final token = responseBody['token'];
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('token', token);
          navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
              context,
              FinishingAccountStepOne(
                phoneNumber: "",
              ));
        } else {
          snackbar(context, 2, response.statusCode, Colors.redAccent);
        }
        // ✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨
        // 9a3da tarja3lek token 3adeya lahne taw twali testaamelha kayeni ay token staamelneha fel login (jwt ya3ni) .. ahawka tjik el token taw ykamel y3amer el info mte3o aadi
        //..........................
        // Handle the response
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  Future<void> _handleFacebookSignIn(BuildContext context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile'],
      ); // by default we request the email and the public profile

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        accessTokenFacebook = accessToken.token;

        print(accessTokenFacebook);

        setState(() {
          isLoading = true;
        });

        // DIO INIT
        Dio dio = Dio();

        var response = await dio.post(
          '${dotenv.env['URL']}/user/facebook/',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
          data: {
            'token': accessTokenFacebook,
          },
        );
        print(response.data);

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.data);
          final token = responseBody['token'];
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('token', token);
          navigateToAnotherScreenWithFadeTransition(
              context, ActiveLocationScreen());
        } else if (response.statusCode == 206) {
          final responseBody = jsonDecode(response.data);
          final token = responseBody['token'];
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('token', token);
          navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
              context,
              FinishingAccountStepOne(
                phoneNumber: "",
              ));
        } else {
          snackbar(context, 2, response.statusCode, Colors.redAccent);
        }

        // Handle the response
      } else {
        print(result.status);
        print(result.message);
      }
    } catch (error) {
      print("Facebook Sign-In Error: $error");
    }
  }

  void saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Stack(
          children: [
            SvgPicture.string(
              backgroundsSignIn,
              fit: BoxFit.cover,
            ),
            Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 40.0.h),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 110.h),
                          Text(
                            "Let's sign you in",
                            style: TextStyle(
                              color: AppColor.red,
                              fontSize: 25.sp,
                              letterSpacing: 0.7,
                              fontFamily: 'Times',
                              fontWeight: FontWeight.w800,
                              wordSpacing: 0.7,
                            ),
                          ),
                          SizedBox(height: 70.h),
                          MyCustomButton(
                            width: double.infinity,
                            height: 45.h,
                            function: () async {
                              try {
                                await _googleSignIn.signOut();
                                GoogleSignInAccount? account =
                                    await _googleSignIn.signIn();

                                if (account != null) {
                                  GoogleSignInAuthentication authentication =
                                      await account.authentication;
                                  accessTokenGoogle =
                                      authentication.accessToken;
                                  print(accessTokenGoogle);
                                  var body =
                                      jsonEncode({"token": accessTokenGoogle});

                                  setState(() {
                                    isLoading = true;
                                  });
                                  print(111);

                                  // DIO INIT
                                  Dio dio = Dio();

                                  final response = await dio.post(
                                    '${dotenv.env['URL']}/user/google/',
                                    options: Options(
                                      headers: {
                                        'Content-Type': 'application/json',
                                      },
                                    ),
                                    data: {
                                      'token': accessTokenGoogle,
                                    },
                                  );
                                  print(response.data);
                                  if (response.statusCode == 200) {
                                    final responseBody =
                                        jsonDecode(response.data);
                                    final token = responseBody['token'];
                                    final SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.setString('token', token);
                                    navigateToAnotherScreenWithFadeTransition(
                                        context, ActiveLocationScreen());
                                  } else if (response.statusCode == 206) {
                                    print(
                                        "s:kjgbsdlgksbqnerglkjsqerglhsergksrjg");
                                    print(response.data);
                                    // final responseBody =
                                    //     jsonDecode(response.data);
                                    print("responseBody : ${response.data}");
                                    final token = response.data['token'];
                                    final SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.setString('token', token);
                                    navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                                        context,
                                        FinishingAccountStepOne(
                                          phoneNumber: "",
                                        ));
                                  } else {
                                    snackbar(context, 2, response.statusCode,
                                        Colors.redAccent);
                                  }
                                  // ✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨
                                  // 9a3da tarja3lek token 3adeya lahne taw twali testaamelha kayeni ay token staamelneha fel login (jwt ya3ni) .. ahawka tjik el token taw ykamel y3amer el info mte3o aadi
                                  //..........................
                                  // Handle the response
                                }
                              } catch (error) {
                                print("Google Sign-In Error: $error");
                              }
                            },
                            buttonColor: AppColor.red,
                            fontWeight: FontWeight.w700,
                            text: "Continue with Google",
                            icon: Icon(
                              FontAwesomeIcons.google,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 40.h),
                          MyCustomButton(
                            width: double.infinity,
                            height: 45.h,
                            function: () async {
                              try {
                                final LoginResult result =
                                    await FacebookAuth.instance.login(
                                  permissions: ['public_profile'],
                                ); // by default we request the email and the public profile

                                if (result.status == LoginStatus.success) {
                                  final AccessToken accessToken =
                                      result.accessToken!;
                                  accessTokenFacebook = accessToken.token;

                                  print(accessTokenFacebook);

                                  setState(() {
                                    isLoading = true;
                                  });

                                  // DIO INIT
                                  Dio dio = Dio();

                                  var response = await dio.post(
                                    '${dotenv.env['URL']}/user/facebook/',
                                    options: Options(
                                      headers: {
                                        'Content-Type': 'application/json',
                                      },
                                    ),
                                    data: {
                                      'token': accessTokenFacebook,
                                    },
                                  );
                                  print(response.data);

                                  if (response.statusCode == 200) {
                                    final token = response.data['token'];
                                    final SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.setString('token', token);
                                    navigateToAnotherScreenWithFadeTransition(
                                        context, ActiveLocationScreen());
                                  } else if (response.statusCode == 206) {
                                    final token = response.data['token'];
                                    final SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.setString('token', token);
                                    navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                                        context,
                                        FinishingAccountStepOne(
                                          phoneNumber: "",
                                        ));
                                  } else {
                                    snackbar(context, 2, response.statusCode,
                                        Colors.redAccent);
                                  }

                                  // Handle the response
                                } else {
                                  print(result.status);
                                  print(result.message);
                                }
                              } catch (error) {
                                print("Facebook Sign-In Error: $error");
                              }
                            },
                            fontWeight: FontWeight.w700,
                            buttonColor: AppColor.red,
                            text: "Continue with Facebook",
                            icon: Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 35.h),
                          GestureDetector(
                            onTap: () {
                              navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                                  context, LoginWithPhoneNumber());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Use phone number',
                                  style: GoogleFonts.roboto(
                                      fontSize: 13.sp,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 5.w),
                                Icon(FontAwesomeIcons.angleRight,
                                    color: AppColor.black, size: 15.sp),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                            context, SignupStepOne());
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "You don't have an account? ",
                              style: GoogleFonts.roboto(
                                color: AppColor.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: " Sign up",
                              style: GoogleFonts.roboto(
                                color: AppColor.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
