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
  String name;
  DateTime birthday;
  String gender;
  List<String> pictures;
  String phoneNumber;

  FinishingAccountStepFour({
    Key? key,
    required this.name,
    required this.birthday,
    required this.gender,
    required this.pictures,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  _FinishingAccountStepFourState createState() =>
      _FinishingAccountStepFourState();
}

class _FinishingAccountStepFourState extends State<FinishingAccountStepFour> {
  final List<String> _selectedInterestIds = [];
  final List<String> interestOptions = [
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

  Map<String, String> interestsMap = {
    "666f67f9b3a28407b9f3b7ad": "sport",
    "668d335bacf669f3d84e202e": "travelling",
    "668d3369acf669f3d84e2030": "music",
    "668d338eacf669f3d84e2032": "photography",
    "668d33a4acf669f3d84e2034": "dancing",
    "668d33afacf669f3d84e2036": "books",
    "668d33bcacf669f3d84e2038": "reading",
    "668d33cbacf669f3d84e203a": "modeling",
    "668d33e2acf669f3d84e203c": "painting",
    "668d33ebacf669f3d84e203e": "shopping",
    "668d33f9acf669f3d84e2040": "animals",
    "668d3402acf669f3d84e2042": "drawing"
  };

  void _toggleInterest(String interest) {
    String interestId =
        interestsMap.entries.firstWhere((entry) => entry.value == interest).key;

    setState(() {
      if (_selectedInterestIds.contains(interestId)) {
        _selectedInterestIds.remove(interestId);
      } else {
        _selectedInterestIds.add(interestId);
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
                        for (int i = 0; i < interestOptions.length; i += 3)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  for (int j = 0; j < 3; j++)
                                    if (i + j < interestOptions.length)
                                      _buildInterestButton(
                                          interestOptions[i + j]),
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
                        if (_selectedInterestIds.isEmpty) {
                          snackbar(
                            context,
                            1,
                            "You have to select at least one interest",
                            Colors.redAccent,
                          );
                        } else {
                          navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                              context,
                              FinishingAccountStepFive(
                                name: widget.name,
                                birthday: widget.birthday,
                                gender: widget.gender,
                                pictures: widget.pictures,
                                interests: _selectedInterestIds,
                                phoneNumber: widget.phoneNumber,
                              ));
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
    String interestId =
        interestsMap.entries.firstWhere((entry) => entry.value == interest).key;

    return GestureDetector(
      onTap: () => _toggleInterest(interest),
      child: GenderSelect(
        containerWidth:
            _selectedInterestIds.contains(interestId) ? 105.w : 90.w,
        containerColor: AppColor.white,
        radious: 5.r,
        function: () {},
        borderColor: _selectedInterestIds.contains(interestId)
            ? AppColor.red
            : const Color(0xffE8E6EA),
        checked: _selectedInterestIds.contains(interestId)
            ? SizedBox(
                height: 18.h,
                width: 18.w,
                child: SvgPicture.string(doubleCheck),
              )
            : const SizedBox(),
        textGender: interest.capitalizeFirstLetter(),
        textColor: _selectedInterestIds.contains(interestId)
            ? AppColor.red
            : AppColor.grey,
      ),
    );
  }
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    return this[0].toUpperCase() + substring(1);
  }
}
