import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/finishing%20account%20screens/account_creation_step_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constant.dart';
import '../../../../../core/widgets/reusable_text.dart';
import '../../widgets/continueButton.dart';
import '../../widgets/gender_select.dart';
import '../../widgets/snackBar.dart';

class FinishingAccountStepTwo extends StatefulWidget {
  String phoneNumber;
  String name;
  DateTime birthday;

  FinishingAccountStepTwo(
      {Key? key,
      required this.name,
      required this.birthday,
      required this.phoneNumber})
      : super(key: key);

  @override
  _FinishingAccountStepTwoState createState() =>
      _FinishingAccountStepTwoState();
}

class _FinishingAccountStepTwoState extends State<FinishingAccountStepTwo> {
  String selectedGender = '';
  bool isHidden = false;

  void selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  void toggleHidden() {
    setState(() {
      isHidden = !isHidden;
    });
  }

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
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.0.w, 50.h, 15.w, 30.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What gender best describes you?",
                          style: TextStyle(
                            color: AppColor.red,
                            fontSize: 25.sp,
                            letterSpacing: 0.3,
                            fontFamily: 'Times',
                            fontWeight: FontWeight.w700,
                            wordSpacing: 0.0,
                          ),
                        ),
                        SizedBox(height: 45.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                selectGender("man");
                              },
                              child: GenderSelect(
                                containerColor: selectedGender == 'man'
                                    ? AppColor.red
                                    : const Color(0xffe9e7e7),
                                horizontalPadding: 20,
                                function: () {},
                                borderColor: selectedGender == 'man'
                                    ? AppColor.red
                                    : const Color(0xffe9e7e7),
                                checked: const SizedBox(),
                                textGender: 'Man',
                                textColor: selectedGender == 'man'
                                    ? Colors.white
                                    : const Color(0xff717171),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selectGender("woman");
                              },
                              child: GenderSelect(
                                containerColor: selectedGender == 'woman'
                                    ? AppColor.red
                                    : const Color(0xffe9e7e7),
                                horizontalPadding: 20,
                                function: () {},
                                borderColor: selectedGender == 'woman'
                                    ? AppColor.red
                                    : const Color(0xffe9e7e7),
                                checked: const SizedBox(),
                                textGender: 'Woman',
                                textColor: selectedGender == 'woman'
                                    ? Colors.white
                                    : const Color(0xff717171),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selectGender('other');
                              },
                              child: GenderSelect(
                                containerColor: selectedGender == 'other'
                                    ? AppColor.red
                                    : const Color(0xffe9e7e7),
                                horizontalPadding: 20,
                                function: () {},
                                borderColor: selectedGender == 'other'
                                    ? AppColor.red
                                    : const Color(0xffe9e7e7),
                                checked: const SizedBox(),
                                textGender: 'Non-binary',
                                textColor: selectedGender == 'other'
                                    ? Colors.white
                                    : const Color(0xff717171),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50.h),
                        Row(
                          children: [
                            Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              side: const BorderSide(
                                color: Color(0xffADA9A9),
                                width: 2,
                              ),
                              splashRadius: 0,
                              value: isHidden,
                              onChanged: (bool? newValue) {
                                toggleHidden();
                              },
                              activeColor: const Color(0xffADA9A9),
                              checkColor: AppColor.red,
                            ),
                            GestureDetector(
                              onTap: toggleHidden,
                              child: SizedBox(
                                child: ReusableText(
                                  text: "Hidden",
                                  textColor: const Color(0xffADA9A9),
                                  textSize: 15.0.sp,
                                  textFontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.34),
                    Center(
                      child: ContinueButton(
                        onpress: () {
                          if (selectedGender == "") {
                            snackbar(
                              context,
                              1,
                              "You have to select your gender",
                              Colors.redAccent,
                            );
                          } else {
                            navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                                context,
                                FinishingAccountStepThree(
                                  name: widget.name,
                                  birthday: widget.birthday,
                                  gender: selectedGender,
                                  phoneNumber: widget.phoneNumber,
                                ));
                          }
                        },
                        width: MediaQuery.of(context).size.width * 0.63,
                        height: MediaQuery.of(context).size.height * 0.062,
                        borderColor: AppColor.red,
                        textColor: AppColor.red,
                        textButton: 'Continue',
                        widget: SvgPicture.string(continueArrow),
                      ),
                    ),
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
