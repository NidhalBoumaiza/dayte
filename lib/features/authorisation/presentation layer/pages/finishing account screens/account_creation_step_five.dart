import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/dates/presentation%20layer/pages/squelette_home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../constant.dart';
import '../../../../../core/widgets/reusable_text_field_widget.dart';
import '../../widgets/continueButton.dart';

class FinishingAccountStepFive extends StatefulWidget {
  const FinishingAccountStepFive({Key? key}) : super(key: key);

  @override
  _FinishingAccountStepFiveState createState() =>
      _FinishingAccountStepFiveState();
}

class _FinishingAccountStepFiveState extends State<FinishingAccountStepFive> {
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> promptControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<TextEditingController> descriptionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  int promptNumber = 1;

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
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: appBar,
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15.w, 30.h, 15.w, 40.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "What would you like Daytors to know?",
                              style: TextStyle(
                                color: AppColor.red,
                                fontSize: 25.sp,
                                letterSpacing: 0.3,
                                fontFamily: 'Times',
                                fontWeight: FontWeight.w700,
                                wordSpacing: 0.0,
                              ),
                            ),

                            SizedBox(height: 25.h),
                            ReusableTextFieldWidget(
                              controller: promptControllers[promptNumber - 1],
                              errorMessage: "You have to enter a prompt.",
                              hintText: "Prompt $promptNumber",
                              minLines: 1,
                              maxLines: 3,
                              borderSide: BorderSide(
                                color: Color(0xffD4D4D4),
                                width: 1.2,
                              ),
                            ),
                            // TextFieldWidget(
                            //   controller: promptControllers[promptNumber - 1],
                            //   function: (String) {},
                            //   minLines: 1,
                            //   maxLines: 3,
                            //   hint: 'Enter your name...',
                            //   keyboardType: TextInputType.name,
                            //   inputdecoration: KinputDecoration.copyWith(
                            //     hintStyle:
                            //         TextStyle(color: Colors.grey, fontSize: 15.sp),
                            //     hintText: "Prompt $promptNumber",
                            //   ),
                            // ),
                            SizedBox(height: 15.h),
                            ReusableTextFieldWidget(
                              controller:
                                  descriptionControllers[promptNumber - 1],
                              errorMessage:
                                  "You have to enter brief description.",
                              hintText: "Brief description...",
                              minLines: 8,
                              maxLines: 8,
                              borderSide: BorderSide(
                                color: Color(0xffD4D4D4),
                                width: 1.2,
                              ),
                            ),
                            // TextFieldWidget(
                            //   controller: descriptionControllers[promptNumber - 1],
                            //   function: (String) {},
                            //   hint: 'Brief description...',
                            //   minLines: 8,
                            //   maxLines: 8,
                            //   keyboardType: TextInputType.name,
                            //   inputdecoration: KinputDecoration.copyWith(
                            //     hintStyle:
                            //         TextStyle(color: Colors.grey, fontSize: 15.sp),
                            //     hintText: "Brief description...",
                            //   ),
                            // ),
                            SizedBox(height: 15.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ReusableText(
                                    text: "$promptNumber / 3",
                                    textSize: 16.sp,
                                    textColor: AppColor.red,
                                    textFontWeight: FontWeight.w800),
                                // TextWidget(
                                //   "/",
                                //   AppColor.red,
                                //   16.0.sp,
                                //   FontWeight.w800,
                                //   0.0,
                                // ),
                                // TextWidget(
                                //   "3",
                                //   AppColor.red,
                                //   16.0.sp,
                                //   FontWeight.w800,
                                //   0.0,
                                // ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            ReusableText(
                                text: "•  2 prompts are required to proceed",
                                textSize: 11.sp,
                                textColor: AppColor.grey,
                                textFontWeight: FontWeight.w400),
                          ],
                        ),
                      ),
                      SizedBox(height: 50.h),
                      Center(
                        child: ContinueButton(
                          onpress: () {
                            if (promptNumber < 3) {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                            }

                            if (promptNumber >= 3) {
                             navigateToAnotherScreenWithSlideTransitionFromBottomToTopPushReplacement(context, SqueletteHomeScreen());
                            } else {
                              setState(() {
                                promptNumber++;
                              });
                            }
                          },
                          width: 0.63.sw,
                          height: 0.062.sh,
                          borderColor: AppColor.red,
                          textColor: AppColor.red,
                          textButton: promptNumber < 3 ? 'Add' : "Submit",
                          widget: const SizedBox(),
                        ),
                      ),
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
