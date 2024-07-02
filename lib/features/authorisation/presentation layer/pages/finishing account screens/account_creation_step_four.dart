import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../constant.dart';
import '../../../../../svgImages.dart';
import '../../widgets/continueButton.dart';
import '../../widgets/gender_select.dart';
import '../../widgets/snackBar.dart';
import 'account_creation_step_five.dart';

class FinishingAccountStepFour extends StatefulWidget {
  const FinishingAccountStepFour({Key? key}) : super(key: key);

  @override
  _FinishingAccountStepFourState createState() =>
      _FinishingAccountStepFourState();
}

class _FinishingAccountStepFourState extends State<FinishingAccountStepFour> {
  final List<String> _interests = [];
  final List<String> _interestOptions = [
    "travelling",
    "music",
    "photography",
    "dancing",
    "books",
    "reading",
    "sport",
    "modeling",
    "painting",
    "shopping",
    "animals",
    "drawing"
  ];

  void _toggleInterest(String interest) {
    setState(() {
      if (_interests.contains(interest)) {
        _interests.remove(interest);
      } else {
        _interests.add(interest);
      }
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
            body: Padding(
              padding: EdgeInsets.fromLTRB(15.w, 40.h, 15.w, 40.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select your interests",
                          style: TextStyle(
                            color: AppColor.red,
                            fontSize: 25.sp,
                            letterSpacing: 0.3,
                            fontFamily: 'Times',
                            fontWeight: FontWeight.w700,
                            wordSpacing: 0.0,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ReusableText(
                          text:
                              "Select a few of your interests and let everyone know what you’re passionate about.",
                          textSize: 11.sp,
                          textFontWeight: FontWeight.w400,
                          textColor: AppColor.grey,
                        ),
                        SizedBox(height: 30.h),
                        for (int i = 0; i < _interestOptions.length; i += 3)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  for (int j = 0; j < 3; j++)
                                    if (i + j < _interestOptions.length)
                                      _buildInterestButton(
                                          _interestOptions[i + j]),
                                ],
                              ),
                              SizedBox(height: 45.h),
                            ],
                          ),
                        GestureDetector(
                          onTap: () {
                            /// TODO LATER
                          },
                          child: SvgPicture.string(more),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: ContinueButton(
                      onpress: () {
                        if (_interests.isEmpty) {
                          snackbar(
                            context,
                            1,
                            "You have to select at least one interest",
                            Colors.redAccent,
                          );
                        } else {
                          navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                              context, FinishingAccountStepFive());
                        }
                      },
                      width: 0.63.sw,
                      height: 0.062.sh,
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
        ],
      ),
    );
  }

  Widget _buildInterestButton(String interest) {
    return GestureDetector(
      onTap: () => _toggleInterest(interest),
      child: GenderSelect(
        containerWidth: _interests.contains(interest) ? 105.w : 90.w,
        containerColor: AppColor.white,
        radious: 5.r,
        function: () {},
        borderColor: _interests.contains(interest)
            ? AppColor.red
            : const Color(0xffE8E6EA),
        checked: _interests.contains(interest)
            ? SizedBox(
                height: 18.h,
                width: 18.w,
                child: SvgPicture.string(doubleCheck),
              )
            : const SizedBox(),
        textGender: interest.capitalizeFirstLetter(),
        textColor: _interests.contains(interest) ? AppColor.red : AppColor.grey,
      ),
    );
  }
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    return this[0].toUpperCase() + substring(1);
  }
}
