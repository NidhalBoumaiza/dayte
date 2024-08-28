import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/my_customed_button.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/creation%20account%20screens/signup_step_two.dart';
import 'package:client/features/authorisation/presentation%20layer/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../../constant.dart';
import '../../../../../core/widgets/reusable_circular_progressive_indicator.dart';
import '../../../../dates/presentation layer/widgets/text_field.dart';
import '../../bloc/register bloc/register_bloc.dart';

class SignupStepOne extends StatelessWidget {
  SignupStepOne({Key? key}) : super(key: key);
  final TextEditingController phoneController = TextEditingController();
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
              resizeToAvoidBottomInset: true,
              appBar: appBar,
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(28.0.w, 0, 28.w, 40.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Text(
                              "Enter your mobile number",
                              style: GoogleFonts.openSans(
                                color: AppColor.black,
                                fontSize: 19,
                                letterSpacing: 0.02,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SizedBox(
                              height: 70.h,
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
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET,
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
                              obsecuretext: true,
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
                              obsecuretext: true,
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
                            SizedBox(height: 15.h),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: ReusableText(
                                text: "Or connect with social",
                                textSize: 17.0.sp,
                                textFontWeight: FontWeight.w400,
                                textColor: AppColor.red,
                                textDecoration: TextDecoration.underline,
                              ),
                            ),
                            SizedBox(height: 160.h),
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
                          BlocConsumer<RegisterBloc, RegisterState>(
                            listener: (context, state) {
                              if (state is RegisterFailure) {
                                snackbar(
                                    context, 1, state.message, AppColor.red);
                              } else if (state is RegisterSuccess) {
                                navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                                    context,
                                    SignupStepTwo(
                                        phoneNumber: phoneController.text));
                              }
                            },
                            builder: (context, state) {
                              return MyCustomButton(
                                width: double.infinity,
                                height: 45.h,
                                function: state is! RegisterLoading
                                    ? () {
                                        if (_formKey.currentState!.validate()) {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          context
                                              .read<RegisterBloc>()
                                              .add(RegisterEventRegister(
                                                phoneNumber:
                                                    phoneController.text,
                                                password:
                                                    newPasswordController.text,
                                                passwordConfirm:
                                                    confirmNewPasswordController
                                                        .text,
                                              ));
                                        }
                                      }
                                    : () {},
                                buttonColor: AppColor.red,
                                text: "Next",
                                fontWeight: FontWeight.w700,
                                widget: state is RegisterLoading
                                    ? ReusablecircularProgressIndicator(
                                        indicatorColor: AppColor.white,
                                        width: 10,
                                        height: 10,
                                      )
                                    : null,
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
