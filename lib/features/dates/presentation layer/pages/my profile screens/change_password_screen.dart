import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/widgets/snackBar.dart';
import 'package:client/features/dates/presentation%20layer/pages/squelette_home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../constant.dart';
import '../../../../../core/strings.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../../../../core/widgets/reusable_circular_progressive_indicator.dart';
import '../../../../authorisation/presentation layer/cubit/change password cubit/change_password__cubit.dart';
import '../../widgets/sign_out_logic_widget.dart';
import '../../widgets/text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isLoading = false;
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
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
              "Change password",
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
              ///TODO LATER
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 25.0.w),
              child: SizedBox(child: SvgPicture.string(arrowBack)),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0.w, 35.h, 15.w, 30.h),
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
                        text: "Enter old password",
                        textSize: 13.sp,
                        textFontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 3.h),
                      TextFieldWidget(
                        controller: oldPassController,
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
                      ReusableText(
                        text: "Enter new password",
                        textSize: 13.sp,
                        textFontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 3.h),
                      TextFieldWidget(
                        controller: newPassController,
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
                      ReusableText(
                        text: "Confirm new password",
                        textSize: 13.sp,
                        textFontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 3.h),
                      TextFieldWidget(
                        controller: confirmPassController,
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
                    ],
                  ),
                ),
                SizedBox(height: 240.h),
                Center(
                  child: BlocConsumer<ChangePasswordCubit,
                      ChangePasswordState>(
                    listener: (context, state) {
                      if (state is ChangePasswordError) {
                        snackbar(context, 2, state.message, AppColor.red);
                      } else if (state is ChangePasswordSuccess) {
                        snackbar(context, 2, PasswordResetedSuccessMessage,
                            Colors.green);
                        navigateToAnotherScreenWithSlideTransitionFromBottomToTop(
                            context, SqueletteHomeScreen());
                      }else if (state is EndOfPlanErreur) {
                        snackbar(context, 2, state.message, AppColor.red);
                      }
                    },
                    builder: (context, state) {
                      if (state is ChangePasswordUnauthorized) {
                        return handleUnauthorizedAccessLogic(context);
                      } else {
                        return MyCustomButton(
                          width: double.infinity,
                          height: 45.h,
                          function: state is ChangePasswordLoading
                              ? () {}
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    if (newPassController.text ==
                                        confirmPassController.text) {
                                      BlocProvider.of<ChangePasswordCubit>(
                                              context)
                                          .changePassword(
                                              oldPassController.text,
                                              newPassController.text,
                                              confirmPassController.text);
                                    } else {
                                      snackbar(
                                          context,
                                          2,
                                          "Passwords do not match",
                                          AppColor.red);
                                    }
                                  }
                                },
                          buttonColor: AppColor.red,
                          text: "Submit",
                          fontWeight: FontWeight.w700,
                          widget: state is ChangePasswordLoading
                              ? ReusablecircularProgressIndicator(
                                  indicatorColor: Colors.white,
                                  height: 15,
                                  width: 15,
                                )
                              : null,
                        );
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
