import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/creation%20account%20screens/signup_step_four.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constant.dart';
import '../../../../../core/animation/animation_top.dart';
import '../../../../../core/widgets/my_customed_button.dart';

class SignupStepThree extends StatelessWidget {
  const SignupStepThree({Key? key}) : super(key: key);

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
          appBar: appBar,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.fromLTRB(20.0.w, 0, 20.0.w, 30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: AnimationTop(
                              child: SvgPicture.string(positionImage))),
                      SizedBox(height: 25.h),
                      ReusableText(
                        text: "Enable Location",
                        textSize: 18.sp,
                        textColor: Color(0xff2B2627),
                        textFontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 15.h),
                      ReusableText(
                        text:
                            "Allow Dayte to access your location? You must allow access for Dayte to work. We will only track your location while on duty.",
                        textSize: 12.sp,
                        textColor: Color(0xff2B2627),
                        textFontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 100.h)
                    ],
                  ),
                ),
                MyCustomButton(
                  width: double.infinity,
                  height: 45.h,
                  function: () {
                    navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                        context,
                        SignupStepFour(
                          isBillingScreen: false,
                        ));
                  },
                  buttonColor: AppColor.red,
                  text: "Next",
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
