import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constant.dart';
import '../../../../authorisation/presentation layer/widgets/continueButton.dart';
import '../../widgets/home_profile_widget.dart';
import '../profile_details_screen.dart';

class PetalsScreen extends StatelessWidget {
  const PetalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 10.0.h, left: 15.w, right: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Petals",
              style: TextStyle(
                color: AppColor.red,
                fontSize: 35.sp,
                letterSpacing: 0.3,
                fontFamily: 'Times',
                fontWeight: FontWeight.w700,
                wordSpacing: 0.0,
              ),
            ),
            ReusableText(
              text: "Select 3 profiles",
              textSize: 11.sp,
              textColor: Color(0xff717171),
            ),
            SvgPicture.string(today),
            SizedBox(height: 10.h),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio:
                    SizeScreen.height * 0.1 / SizeScreen.width * 3,
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: listSuggestions.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                      context,
                      ProfileDetailScreen(profile: listSuggestions[index]),
                    );
                  },
                  child: ProfileWidget(
                    name: listSuggestions[index]['name'].split(" ")[0],
                    image: "images/${index + 1}.png",
                    age: listSuggestions[index]['age'].toString(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Center(
              child: ContinueButton(
                onpress: () {
                  // Get.toNamed("accountsteptwo");
                },
                width: 110.w,
                height: SizeScreen.height * 0.04,
                borderColor: AppColor.red,
                textColor: AppColor.red,
                textButton: 'Shuffle',
                textSize: 13,
                widget: SvgPicture.string(shuffle),
              ),
            )
          ],
        ),
      ),
    );
  }
}
