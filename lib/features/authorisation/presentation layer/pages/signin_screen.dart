import 'dart:convert';

import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/my_customed_button.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/creation%20account%20screens/signup_step_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant.dart';
import 'login_with_phone_number.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;
  String? accessTokenGoogle;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        "186651681146-fpaiaa8ui39jba8e14h01q8c2i42da9t.apps.googleusercontent.com",
  );
  bool isLoading = false;

  _handleSignIn() async {
    print("im here mf");
    try {
      print("111111111111111111111111111111111111111111111111111111111");
      GoogleSignInAccount? account = await _googleSignIn.signOut();
      print("22222222222222222222222222222222222222222222222222222");

      account = await _googleSignIn.signIn();
      print("33333333333333333333333333333333333333333333333");
      GoogleSignInAuthentication authentication = await account!.authentication;
      print("44444444444444444444444444444444444444444444444");

      if (account != null) {
        accessTokenGoogle = authentication.accessToken;
        print(accessTokenGoogle);
        // var body = jsonEncode({
        //   "token": accessTokenGoogle,
        //   "backend": "google-oauth2",
        //   "grant_type": "convert_token",
        //change the client_id / client_secret !!!!!!!! 🍑🍑🍑🍑🍑🍑
        // "client_id": '',
        // "client_secret":
        //     'hpvsXP5nIvcOLni0Q6htIBPU1u393uQ9hXyTv9Z0TBcwaZUapG317B9OZslwepFaAF9ro5ys73cmhzQkgBvpd19C8LU48L95nbmLFWXnzgh1asP7hSltqLDyzC4SC0EH'
        //});
        //     setState(() {
        //       isLoading = true;
        //     });
        //     print(URL);
        //     //change the url nidhal !!!! 💀💀💀💀💀💀💀💀💀💀
        //     var res = await http.post(
        //       Uri.parse("http://192.168.1.101:8000/auth/convert-token/"),
        //       headers: {
        //         'Content-Type': 'application/json; charset=UTF-8',
        //       },
        //       body: body,
        //     );
        //     print(res.body);
        //     var decodedBody = jsonDecode(res.body);
        //     if (res.statusCode == 200) {
        //       //token = decodedBody["access_token"];
        //       print(decodedBody);
        //
        //       var response = await http.post(
        //         Uri.parse("$URL/auth/profile_exist/"),
        //         headers: {
        //           'Authorization': 'Bearer ${decodedBody["access_token"]}',
        //         },
        //       );
        //       print(response.body);
        //       print(response.statusCode);
        //
        //       if (response.statusCode == 200) {
        //         saveData("AccessToken", decodedBody["access_token"]);
        //         saveData("RefreshToken", decodedBody["refresh_token"]);
        //         navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(context, newScreen)
        //       } else {
        //         Get.offAllNamed(
        //           '/SignUpStepOneGoogle',
        //           arguments: {
        //             "access_token": decodedBody["access_token"],
        //             "refresh_token": decodedBody["refresh_token"],
        //           },
        //         );
        //       }
        //     } else {
        //       setState(() {
        //         isLoading = false;
        //       });
        //       snackbar(
        //           context, 1, "Something reallt wrong happened", Colors.redAccent);
        //     }
        //   }
        // } catch (error) {
        //   print("tnakettttttttttttttttttttttttttttttttttt");
        //   print(error);
        // }
      }
    } catch (error) {
      print("tnakettttttt");
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
                padding: EdgeInsets.only(
                    bottom: 40.0.h, left: 30.0.w, right: 30.0.w),
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
                              print(
                                  "111111111111111111111111111111111111111111111111111111111");
                              GoogleSignInAccount? account =
                                  await _googleSignIn.signOut();
                              print(
                                  "22222222222222222222222222222222222222222222222222222");

                              account = await _googleSignIn.signIn();
                              print(
                                  "33333333333333333333333333333333333333333333333");
                              GoogleSignInAuthentication authentication =
                                  await account!.authentication;
                              print(
                                  "44444444444444444444444444444444444444444444444");

                              if (account != null) {
                                accessTokenGoogle = authentication.accessToken;
                                print(accessTokenGoogle);
                                var body = jsonEncode({
                                  "token": accessTokenGoogle,
                                  "backend": "google-oauth2",
                                  "grant_type": "convert_token",
                                  //change the client_id / client_secret !!!!!!!! 🍑🍑🍑🍑🍑🍑
                                  // "client_id": '',
                                  // "client_secret":
                                  //     'hpvsXP5nIvcOLni0Q6htIBPU1u393uQ9hXyTv9Z0TBcwaZUapG317B9OZslwepFaAF9ro5ys73cmhzQkgBvpd19C8LU48L95nbmLFWXnzgh1asP7hSltqLDyzC4SC0EH'
                                });
                                //     setState(() {
                                //       isLoading = true;
                                //     });
                                //     print(URL);
                                //     //change the url nidhal !!!! 💀💀💀💀💀💀💀💀💀💀
                                //     var res = await http.post(
                                //       Uri.parse("http://192.168.1.101:8000/auth/convert-token/"),
                                //       headers: {
                                //         'Content-Type': 'application/json; charset=UTF-8',
                                //       },
                                //       body: body,
                                //     );
                                //     print(res.body);
                                //     var decodedBody = jsonDecode(res.body);
                                //     if (res.statusCode == 200) {
                                //       //token = decodedBody["access_token"];
                                //       print(decodedBody);
                                //
                                //       var response = await http.post(
                                //         Uri.parse("$URL/auth/profile_exist/"),
                                //         headers: {
                                //           'Authorization': 'Bearer ${decodedBody["access_token"]}',
                                //         },
                                //       );
                                //       print(response.body);
                                //       print(response.statusCode);
                                //
                                //       if (response.statusCode == 200) {
                                //         saveData("AccessToken", decodedBody["access_token"]);
                                //         saveData("RefreshToken", decodedBody["refresh_token"]);
                                //         navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(context, newScreen)
                                //       } else {
                                //         Get.offAllNamed(
                                //           '/SignUpStepOneGoogle',
                                //           arguments: {
                                //             "access_token": decodedBody["access_token"],
                                //             "refresh_token": decodedBody["refresh_token"],
                                //           },
                                //         );
                                //       }
                                //     } else {
                                //       setState(() {
                                //         isLoading = false;
                                //       });
                                //       snackbar(
                                //           context, 1, "Something reallt wrong happened", Colors.redAccent);
                                //     }
                                //   }
                                // } catch (error) {
                                //   print("tnakettttttttttttttttttttttttttttttttttt");
                                //   print(error);
                                // }
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
                            function: () {},
                            fontWeight: FontWeight.w700,
                            buttonColor: AppColor.red,
                            text: "Continue with Facebook",
                            icon: Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.white,
                            ),
                          ),

                          SizedBox(height: 35.h),

                          /// USE PHONE NUMBER
                          GestureDetector(
                            onTap: () async {
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
