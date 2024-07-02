import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/core/widgets/reusable_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../constant.dart';
import '../../widgets/continueButton.dart';
import 'account_creation_step_two.dart';

class FinishingAccountStepOne extends StatelessWidget {
  FinishingAccountStepOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? birthDate;
    final TextEditingController birthdayController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

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
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15.0.w, 50.h, 15.w, 40.h),
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
                            Text(
                              "Let's start Dayting",
                              style: TextStyle(
                                color: AppColor.red,
                                fontSize: 25.sp,
                                letterSpacing: 0.3,
                                fontFamily: 'Times',
                                fontWeight: FontWeight.w700,
                                wordSpacing: 0.0,
                              ),
                            ),
                            SizedBox(height: 65.h),
                            ReusableText(
                              text: "Name",
                              textColor: AppColor.grey,
                              textSize: 12.sp,
                              textFontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 2.h),
                            ReusableTextFieldWidget(
                              controller: nameController,
                              errorMessage: "Enter your name please.",
                              hintText: "Enter your name...",
                              prefixIcon: FontAwesomeIcons.chevronRight,
                              prefixIconColor: AppColor.greyTextField,
                              borderSide: BorderSide(
                                color: Color(0xffD4D4D4),
                                width: 1.2,
                              ),
                            ),
                            SizedBox(height: 26.h),
                            ReusableText(
                              text: "Birthday",
                              textColor: AppColor.grey,
                              textSize: 12.sp,
                              textFontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 3.h),
                            GestureDetector(
                              onTap: () async {
                                birthDate = await showDateTimePicker(
                                  context,
                                  DateTime.now(),
                                  DateTime(1900),
                                  DateTime(3000),
                                  false,
                                );
                                if (birthDate != null) {
                                  birthdayController.text =
                                      "${birthDate!.day}/${birthDate!.month}/${birthDate!.year}";
                                }
                              },
                              child: AbsorbPointer(
                                child: ReusableTextFieldWidget(
                                  controller: birthdayController,
                                  errorMessage: "Enter your birthday please.",
                                  hintText: 'Select your birthday...',
                                  prefixIcon: FontAwesomeIcons.cakeCandles,
                                  prefixIconColor: AppColor.greyTextField,
                                  suffixIcon: Icon(
                                    FontAwesomeIcons.chevronDown,
                                    size: 16.sp,
                                    color: AppColor.greyTextField,
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xffD4D4D4),
                                    width: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 200.h),
                      Center(
                        child: ContinueButton(
                          onpress: () {
                            if (_formKey.currentState!.validate()) {
                              navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                                context,
                                FinishingAccountStepTwo(),
                              );
                            }
                          },
                          width: SizeScreen.width * 0.63,
                          height: SizeScreen.height * 0.062,
                          borderColor: AppColor.red,
                          textColor: AppColor.red,
                          textButton: 'Continue',
                          widget: SvgPicture.string(continueArrow),
                        ),
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

  Future<DateTime?> showDateTimePicker(
    BuildContext context,
    DateTime initialDate,
    DateTime firstDate,
    DateTime lastDate,
    bool isShowTimePicker,
  ) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (date == null) {
      return null;
    }
    if (!isShowTimePicker) {
      return date;
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (time == null) {
      return null;
    }

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
