import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../constant.dart';
import '../../../../core/widgets/my_customed_button.dart';
import '../../../../core/widgets/reusable_circular_progressive_indicator.dart';
import '../bloc/register bloc/register_bloc.dart';
import 'active_location_screen.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final TextEditingController phoneController = TextEditingController();
  String password = "";

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
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
            appBar: appBar,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.0.w, 10.h, 15.w, 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 35.h),
                    ReusableText(
                      text: "Enter your mobile number",
                      textSize: 17.sp,
                      textFontWeight: FontWeight.w500,
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
                    SizedBox(height: 25.h),
                    ReusableText(
                      text: "Enter your password",
                      textSize: 17.sp,
                      textFontWeight: FontWeight.w500,
                    ),
                    TextField(
                      onChanged: (ch) {
                        password = ch;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
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
                        hintText: 'Password',
                        hintStyle: GoogleFonts.roboto(
                          color: const Color(0xff979797),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: const TextStyle(
                        color: Color(0xff979797),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 150.h),
                    Center(
                      child: BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (context, state) {
                          if (state is LoginWithPhoneNumberSuccess) {
                            navigateToAnotherScreenWithSlideTransitionFromBottomToTopPushReplacement(
                                context, ActiveLocationScreen());
                          } else if (state is LoginWithPhoneNumberFailure) {
                            snackbar(context, 1, state.message, AppColor.red);
                          }
                        },
                        builder: (context, state) {
                          return MyCustomButton(
                            width: double.infinity,
                            height: 45.h,
                            function: state is LoginWithPhoneNumberLoading
                                ? () {}
                                : () {
                                    // print(password);
                                    // print(phoneController.text);
                                    if (phoneController.text.isNotEmpty &&
                                        password.isNotEmpty) {
                                      context.read<RegisterBloc>().add(
                                            LoginWithPhoneNumberEvent(
                                              phoneNumber:
                                                  phoneController.text,
                                              password: password,
                                            ),
                                          );
                                    } else {
                                      snackbar(
                                          context,
                                          1,
                                          "Please fill your password and phone number !",
                                          AppColor.red);
                                    }
                                  },
                            buttonColor: AppColor.red,
                            text: "Connect",
                            fontWeight: FontWeight.w700,
                            widget: state is LoginWithPhoneNumberLoading
                                ? ReusablecircularProgressIndicator(
                                    indicatorColor: AppColor.white,
                                    width: 10,
                                    height: 10,
                                  )
                                : null,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
