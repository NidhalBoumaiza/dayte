import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/my_customed_button.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/creation%20account%20screens/signup_step_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../../constant.dart';

class SignupStepOne extends StatelessWidget {
  SignupStepOne({Key? key}) : super(key: key);
  final TextEditingController phoneController = TextEditingController();

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
            resizeToAvoidBottomInset: true,
            appBar: appBar,
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.fromLTRB(28.0.w, 0, 28.w, 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 35.h),
                        Text(
                          "Enter your mobile number",
                          style: GoogleFonts.openSans(
                            color: AppColor.black,
                            fontSize: 19,
                            letterSpacing: 0.02,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 18.h),
                        SizedBox(
                          height: 55.h,
                          width: 250.w,
                          child: InternationalPhoneNumberInput(
                            initialValue: PhoneNumber(
                              phoneNumber: '',
                              dialCode: "+216",
                              isoCode: "TN",
                            ),
                            inputDecoration: InputDecoration(
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(
                                        0xff979797)), // Change the border color here
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(
                                        0xff979797)), // Change the focused border color here
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(
                                        0xff979797)), // Change the enabled border color here
                              ),
                              hintText: 'Phone number',
                              hintStyle: GoogleFonts.roboto(
                                color: const Color(0xff979797),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            textStyle: const TextStyle(
                              color: Color(0xff979797),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            isEnabled: true,
                            onInputChanged: (PhoneNumber number) {
                              phoneController.text = number.phoneNumber!;
                            },
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            spaceBetweenSelectorAndTextField: 0,
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: const TextStyle(
                              color: AppColor.black,
                              fontSize: 14,
                            ),
                            formatInput: true,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: ReusableText(
                            text: "Or connect with social",
                            textSize: 17.0.sp,
                            textFontWeight: FontWeight.w700,
                            textColor: AppColor.red,
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "By continuing you may receive an SMS for verification. Message and data rates may apply.",
                        style: GoogleFonts.roboto(
                          color: const Color(0xff979797),
                          fontSize: 12.sp,
                          letterSpacing: 0.02,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 25),
                      MyCustomButton(
                        width: double.infinity,
                        height: 45.h,
                        function: () {
                          navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                              context,
                              SignupStepTwo(phoneNumber: phoneController.text));
                        },
                        buttonColor: AppColor.red,
                        text: "Next",
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
