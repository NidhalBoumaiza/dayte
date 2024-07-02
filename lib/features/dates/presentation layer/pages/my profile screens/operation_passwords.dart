import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../../constant.dart';
import '../../../../../core/utils/navigation_with_transition.dart';
import '../../widgets/text_field.dart';
import '../forget passwor screens/forget_password_step_one.dart';
import 'change_password_screen.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        SvgPicture.string(
          backgroundEmpty,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: AppBar(
            title: Transform(
              transform: Matrix4.translationValues(-0.0, 0.0, 0.0),
              child: Text(
                "Password",
                style: TextStyle(
                  color: AppColor.red,
                  fontSize: 20.sp,
                  letterSpacing: 0.3,
                  fontFamily: 'Times',
                  fontWeight: FontWeight.w700,
                  wordSpacing: 0.0,
                ),
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: SizedBox(child: SvgPicture.string(arrowBack)),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.fromLTRB(15.0.w, 40.h, 15.w, 30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                              context, ChangePasswordScreen());
                        },
                        child: TextFieldWidget(
                          function: (String) {},
                          hint: 'Enter your name...',
                          keyboardType: TextInputType.name,
                          enabled: false,
                          inputdecoration: KinputDecoration.copyWith(
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.red,
                                  width: 2.4,
                                ), // Change the enabled border color here
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 13.sp),
                              hintText: "Change password",
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(bottom: 0.0),
                                child: Icon(
                                  FontAwesomeIcons.chevronRight,
                                  size: 17.sp,
                                  color: AppColor.red,
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                              context, ForgetPasswordStepOne());
                        },
                        child: TextFieldWidget(
                          function: (String) {},
                          hint: 'Enter your name...',
                          keyboardType: TextInputType.phone,
                          enabled: false,
                          inputdecoration: KinputDecoration.copyWith(
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.red,
                                  width: 2.4,
                                ), // Change the enabled border color here
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 13.sp),
                              hintText: "Forgot password",
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(bottom: 0.0),
                                child: Icon(
                                  FontAwesomeIcons.chevronRight,
                                  size: 17.sp,
                                  color: AppColor.red,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
    ;
  }
}
