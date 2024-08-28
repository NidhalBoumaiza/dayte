import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/widgets/snackBar.dart';
import 'package:client/features/dates/presentation%20layer/pages/forget%20passwor%20screens/forget_password_step_two.dart';
import 'package:client/features/dates/presentation%20layer/widgets/sign_out_logic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../constant.dart';
import '../../../../../core/strings.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../../../../core/widgets/reusable_circular_progressive_indicator.dart';
import '../../../../authorisation/presentation layer/cubit/forget password cubit/forget_password__cubit.dart';
import '../../widgets/text_field.dart';

class ForgetPasswordStepOne extends StatelessWidget {
  ForgetPasswordStepOne({Key? key}) : super(key: key);
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0.w, 40.h, 15.w, 30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text:
                            "Enter the phone number attached to your account",
                        textSize: 13.0.sp,
                        textColor: AppColor.grey,
                        textFontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 3.h),
                      TextFieldWidget(
                        controller: phoneController,
                        function: (String) {},
                        hint: 'Password',
                        keyboardType: TextInputType.phone,
                        inputdecoration: KinputDecoration.copyWith(
                          focusedBorder: InputBorder.none,
                          // Remove the focused border
                          enabledBorder: InputBorder.none,
                          // Remove the non-focused border
                          filled: true,
                          fillColor: const Color(0xffEDECEC),
                          hintStyle: const TextStyle(
                              color: AppColor.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          hintText: "Phone number",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 380.h),
                Center(
                  child: BlocConsumer<ForgetPasswordCubit,
                      ForgetPasswordState>(
                    listener: (context, state) {
                      if (state is ForgetPasswordErreur) {
                        snackbar(context, 2, state.message, AppColor.red);
                      } else if (state is ForgetPasswordSuccess) {
                        snackbar(context, 2, ForgetPasswordSuccessMessage,
                            Colors.green);
                        navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                            context,
                            ForgetPasswordStepTwo(
                                phoneNumber: phoneController.text));
                      }
                    },
                    builder: (context, state) {
                      if (state is ForgetPasswordUnauthorised) {
                        return handleUnauthorizedAccessLogic(context);
                      } else {
                        return MyCustomButton(
                            width: double.infinity,
                            height: 45.h,
                            function: state is ForgetPasswordLoading
                                ? () {}
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      context
                                          .read<ForgetPasswordCubit>()
                                          .forgetPassword(
                                              phoneController.text);
                                    }
                                  },
                            buttonColor: AppColor.red,
                            text: "Next",
                            fontWeight: FontWeight.w700,
                            widget: state is ForgetPasswordLoading
                                ? ReusablecircularProgressIndicator(
                                    indicatorColor: AppColor.white,
                                    height: 15,
                                    width: 15,
                                  )
                                : const SizedBox());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
          ],
        );
  }
}
