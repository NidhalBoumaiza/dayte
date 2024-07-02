import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/widgets/snackBar.dart';
import 'package:client/features/dates/presentation%20layer/pages/squelette_home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../constant.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../widgets/text_field.dart';

class ForgetPasswordStepThree extends StatelessWidget {
  ForgetPasswordStepThree({Key? key}) : super(key: key);

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        SvgPicture.string(
          backgroundEmpty,
          fit: BoxFit.cover,
        ),
        GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Transform(
                transform: Matrix4.translationValues(-0.0, 0.0, 0.0),
                child: Text(
                  "Forget password",
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
                  padding: EdgeInsets.only(left: 25.0.sp),
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: "Enter new password",
                            textSize: 12.sp,
                            textColor: AppColor.grey,
                            textFontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 5),
                          TextFieldWidget(
                            controller: newPasswordController,
                            function: (String) {},
                            obsecuretext: false,
                            hint: 'Password',
                            keyboardType: TextInputType.name,
                            inputdecoration: KinputDecoration.copyWith(
                              focusedBorder: InputBorder.none,
                              // Remove the focused border
                              enabledBorder: InputBorder.none,
                              // Remove the non-focused border
                              filled: true,
                              fillColor: const Color(0xffEDECEC),
                              hintStyle: const TextStyle(
                                  color: AppColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              hintText: "Password",
                            ),
                          ),
                          SizedBox(height: 15.h),
                          ReusableText(
                            text: "Confirm new password",
                            textSize: 12.sp,
                            textColor: AppColor.grey,
                            textFontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          TextFieldWidget(
                            controller: confirmNewPasswordController,
                            obsecuretext: false,
                            function: (String) {},
                            hint: 'Password',
                            keyboardType: TextInputType.name,
                            inputdecoration: KinputDecoration.copyWith(
                              focusedBorder: InputBorder.none,
                              // Remove the focused border
                              enabledBorder: InputBorder.none,
                              // Remove the non-focused border
                              filled: true,
                              fillColor: const Color(0xffEDECEC),
                              hintStyle: const TextStyle(
                                  color: AppColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              hintText: "Password",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: MyCustomButton(
                      width: double.infinity,
                      height: 45.h,
                      function: () {
                        if (_formKey.currentState!.validate()) {
                          if (newPasswordController.text !=
                              confirmNewPasswordController.text) {
                            snackbar(
                                context,
                                1,
                                "Your passwords are not matching !",
                                AppColor.red);
                          } else {
                            navigateToAnotherScreenWithSlideTransitionFromBottomToTopPushReplacement(
                                context, SqueletteHomeScreen());
                          }
                        }
                      },
                      buttonColor: AppColor.red,
                      text: "Submit",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
