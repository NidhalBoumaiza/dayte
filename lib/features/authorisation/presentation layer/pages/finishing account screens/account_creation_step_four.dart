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
    "drawing",
    "gym",
    "baking",
    "writing"
  ];

  Map<String, String> interestsMap = {
    "66c9f75e18e6f43435d2169c": "sport",
    "66c9f72e18e6f43435d21690": "travelling",
    "66c9f73418e6f43435d21692": "music",
    "66c9f74818e6f43435d21694": "photography",
    "66c9f75018e6f43435d21696": "dancing",
    "66c9f75518e6f43435d21698": "books",
    "66c9f75918e6f43435d2169a": "reading",
    "66c9f76318e6f43435d2169e": "modeling",
    "66c9f76818e6f43435d216a0": "painting",
    "66c9f76d18e6f43435d216a2": "shopping",
    "66c9f77218e6f43435d216a4": "animals",
    "66c9f77618e6f43435d216a6": "Baking",
    "66c9f77b18e6f43435d216a8": "gym",
    "66c9f78118e6f43435d216aa": "writing",
    "66c9f78618e6f43435d216ac": "drawing"
  };

  void _toggleInterest(String interest) {
    String interestId = interestsMap.entries
        .firstWhere(
            (entry) => entry.value.toLowerCase() == interest.toLowerCase(),
            orElse: () => MapEntry(interest, interest))
        .key;

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
    return Stack(
      children: [
        SvgPicture.string(
          backgroundEmpty,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: appBar,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 40.h),
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
                            SizedBox(height: 40.h),
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
    );
  }

  Widget _buildInterestButton(String interest) {
    String interestId = interestsMap.entries
        .firstWhere(
            (entry) => entry.value.toLowerCase() == interest.toLowerCase(),
            orElse: () => MapEntry(interest, interest))
        .key;

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
