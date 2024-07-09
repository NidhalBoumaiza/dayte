import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_circular_progressive_indicator.dart';
import 'package:client/features/authorisation/presentation%20layer/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../constant.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../bloc/register bloc/register_bloc.dart';
import '../finishing account screens/account_creation_step_one.dart';

class SignupStepTwo extends StatefulWidget {
  final String phoneNumber;

  const SignupStepTwo({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _SignupStepTwoState createState() => _SignupStepTwoState();
}

class _SignupStepTwoState extends State<SignupStepTwo> {
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
              appBar: appBar,
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: EdgeInsets.fromLTRB(20.0.w, 0, 20.0.w, 30.h),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 40.h),
                              SizedBox(
                                width: width * 0.8,
                                child: Text(
                                  "Enter the 4-digit code sent to you at",
                                  style: GoogleFonts.openSans(
                                    color: const Color(0xff595959),
                                    fontSize: 19,
                                    letterSpacing: 0.02,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.h),
                              Text(
                                widget.phoneNumber,
                                style: GoogleFonts.openSans(
                                  color: const Color(0xff595959),
                                  fontSize: 13,
                                  letterSpacing: 0.02,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 7.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(4, (index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 17.w),
                                    child: SizedBox(
                                      height: height * 0.08,
                                      width: width * 0.1,
                                      child: TextField(
                                        controller: controllers[index],
                                        focusNode: focusNodes[index],
                                        textInputAction: index < 3
                                            ? TextInputAction.next
                                            : TextInputAction.done,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) =>
                                            _handleFocusChange(index, value),
                                        style: TextStyle(
                                          color: Color(0xff595959),
                                          fontSize: 20.sp,
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        textAlign: TextAlign.center,
                                        decoration: KinputDecoration,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(height: 20.h),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<RegisterBloc>()
                                      .add(ResendVerifactionCodeEvent());
                                },
                                child: Text(
                                  "Resend the code",
                                  style: GoogleFonts.openSans(
                                    color: AppColor.red,
                                    fontSize: 12.sp,
                                    letterSpacing: 0.02,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        BlocConsumer<RegisterBloc, RegisterState>(
                          listener: (context, state) {
                            if (state is verifyCodeSuccess) {
                              navigateToAnotherScreenWithSlideTransitionFromBottomToTop(
                                  context,
                                  FinishingAccountStepOne(
                                    phoneNumber: widget.phoneNumber,
                                  ));
                            } else if (state is verifyCodeFailure) {
                              snackbar(context, 1, state.message, AppColor.red);
                            } else if (state is ResendVerifactionCodeFailure) {
                              snackbar(context, 1, state.message, AppColor.red);
                            } else if (state is ResendVerifactionCodeSuccess) {
                              snackbar(context, 1, "Code sent successfully",
                                  Colors.green);
                            }
                          },
                          builder: (context, state) {
                            return MyCustomButton(
                              width: double.infinity,
                              height: 45.h,
                              function: () {
                                String verificationCode = controllers
                                    .map((controller) => controller.text)
                                    .join();
                                // TODO Handle the verification code
                                context.read<RegisterBloc>().add(
                                      VerifyCodeEvent(code: verificationCode),
                                    );
                              },
                              buttonColor: AppColor.red,
                              text: "Next",
                              fontWeight: FontWeight.w700,
                              widget: state is verifyCodeLoading
                                  ? ReusablecircularProgressIndicator(
                                      indicatorColor: Colors.white,
                                      height: 10,
                                      width: 10,
                                    )
                                  : null,
                            );
                          },
                        ),
                      ],
                    ),
                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        if (state is ResendVerifactionCodeLoading) {
                          return Center(
                              child: ReusablecircularProgressIndicator(
                            indicatorColor: AppColor.red,
                            height: 15,
                            width: 15,
                          ));
                        } else {
                          return SizedBox();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
