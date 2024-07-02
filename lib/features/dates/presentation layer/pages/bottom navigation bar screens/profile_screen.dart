import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/creation%20account%20screens/signup_step_four.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../constant.dart';
import '../../../../../core/utils/navigation_with_transition.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../../../../svgImages.dart';
import '../../widgets/profile_picture_widget.dart';
import '../../widgets/text_field.dart';
import '../my profile screens/edit_profile_screen.dart';
import '../my profile screens/operation_passwords.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(8.w, 10.h, 8.w, 30.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Profile",
              style: TextStyle(
                color: AppColor.red,
                fontSize: 35.sp,
                letterSpacing: 0.3,
                fontFamily: 'Times',
                fontWeight: FontWeight.w700,
                wordSpacing: 0.0,
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: profilePictureWidget(
                heightProfilePic: 150,
                widthProfilePic: 150,
                img: "images/1.png",
              ),
            ),
            SizedBox(height: 7.h),
            ReusableText(
              text: "John week",
              textSize: 25.sp,
              textColor: AppColor.black,
              textFontWeight: FontWeight.w700,
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                          context, EditProfileScreen());
                    },
                    child: TextFieldWidget(
                      enabled: false,
                      function: (String) {},
                      hint: 'Enter your name...',
                      keyboardType: TextInputType.name,
                      inputdecoration: KinputDecoration.copyWith(
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.red,
                            width: 2.4,
                          ), // Change the enabled border color here
                        ),
                        hintStyle:
                            TextStyle(color: AppColor.black, fontSize: 14.sp),
                        hintText: "Edit profile",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          child: Icon(
                            FontAwesomeIcons.userLarge,
                            size: 17,
                            color: AppColor.red,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Icon(
                            FontAwesomeIcons.chevronRight,
                            size: 17.sp,
                            color: AppColor.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  GestureDetector(
                    onTap: () {
                      navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                          context, PasswordScreen());
                    },
                    child: TextFieldWidget(
                      enabled: false,
                      function: (String) {},
                      hint: 'Password',
                      keyboardType: TextInputType.name,
                      inputdecoration: KinputDecoration.copyWith(
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.red,
                            width: 2.4,
                          ), // Change the enabled border color here
                        ),
                        hintStyle:
                            TextStyle(color: AppColor.black, fontSize: 14.sp),
                        hintText: "Password",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          child: Icon(
                            FontAwesomeIcons.lock,
                            size: 17,
                            color: AppColor.red,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Icon(
                            FontAwesomeIcons.chevronRight,
                            size: 17.sp,
                            color: AppColor.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  GestureDetector(
                    onTap: () {
                      navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                          context,
                          SignupStepFour(
                            isBillingScreen: true,
                          ));
                    },
                    child: TextFieldWidget(
                      enabled: false,
                      function: (String) {},
                      hint: 'Billing',
                      keyboardType: TextInputType.name,
                      inputdecoration: KinputDecoration.copyWith(
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.red,
                            width: 2.4,
                          ), // Change the enabled border color here
                        ),
                        hintStyle:
                            TextStyle(color: AppColor.black, fontSize: 14.sp),
                        hintText: "Billing",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          child: Icon(
                            FontAwesomeIcons.dollarSign,
                            size: 25,
                            color: AppColor.red,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Icon(
                            FontAwesomeIcons.chevronRight,
                            size: 17.sp,
                            color: AppColor.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  GestureDetector(
                    onTap: () {
                      Logout(context);
                    },
                    child: TextFieldWidget(
                      enabled: false,
                      function: (String) {},
                      hint: 'Logout',
                      keyboardType: TextInputType.name,
                      inputdecoration: KinputDecoration.copyWith(
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.red,
                            width: 2.4,
                          ), // Change the enabled border color here
                        ),
                        hintStyle:
                            TextStyle(color: AppColor.black, fontSize: 13.sp),
                        hintText: "Logout",
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 0.0.h),
                          child: Icon(
                            FontAwesomeIcons.arrowRightFromBracket,
                            size: 16.sp,
                            color: AppColor.red,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Icon(
                            FontAwesomeIcons.chevronRight,
                            size: 17.sp,
                            color: AppColor.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void Logout(context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: SizeScreen.height * 0.27,
        child: Padding(
          padding: EdgeInsets.only(left: 14.0.w, right: 15.w, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: SvgPicture.string(logout)),
              SizedBox(height: 12.h),
              ReusableText(
                text: "Are you sure you want to logout ?",
                textSize: 14.sp,
                textColor: AppColor.grey,
                textFontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.h),
              Center(
                child: MyCustomButton(
                  width: double.infinity,
                  height: 45.h,
                  function: () {},
                  buttonColor: AppColor.red,
                  text: "Logout",
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
