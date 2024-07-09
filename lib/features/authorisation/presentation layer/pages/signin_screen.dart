import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/my_customed_button.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/creation%20account%20screens/signup_step_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constant.dart';
import 'login_with_phone_number.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                            function: () {},
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
