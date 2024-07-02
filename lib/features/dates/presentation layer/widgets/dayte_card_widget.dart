import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constant.dart';
import '../../../authorisation/presentation layer/widgets/continueButton.dart';
import 'home_profile_widget.dart';

class DayteCard extends StatelessWidget {
  void Function() onPress;
  String image;
  String date, time;

  DayteCard(
      {Key? key,
      required this.image,
      required this.onPress,
      required this.date,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0.h),
      child: Container(
        width: double.infinity,
        height: 150.h,
        constraints: BoxConstraints(
          maxWidth: double.infinity,
          minWidth: double.infinity,
          maxHeight: 185.h,
          minHeight: 160.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColor.grey, width: 2.5),
        ),
        child: Padding(
          padding: EdgeInsets.all(11.0),
          child: Row(
            children: [
              ProfileWidget(
                  borderRadious: 9,
                  borderColor: Colors.transparent,
                  width: 80.w,
                  image: "images/1.png" // image,
                  ),
              SizedBox(width: 7.w),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: "Location",
                      textSize: 14.sp,
                      textColor: AppColor.red,
                      textFontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      width: 95.w,
                      child: ReusableText(
                        text: "Huntington Park",
                        textSize: 13.sp,
                        textColor: AppColor.black,
                        textFontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    ReusableText(
                      text: "California",
                      textSize: 13.sp,
                      textColor: AppColor.black,
                      textFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 2.h),
                    ReusableText(
                      text: "USA",
                      textSize: 13.sp,
                      textColor: AppColor.black,
                      textFontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2.h),
              Padding(
                padding: EdgeInsets.only(top: 8.0.h),
                child: VerticalDivider(
                  color: Colors.black,
                  thickness: 2.5,
                ),
              ),
              SizedBox(width: 8.h),
              Padding(
                padding: EdgeInsets.only(top: 7.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: "Time",
                      textSize: 13.sp,
                      textColor: AppColor.red,
                      textFontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: 4.h),
                    ReusableText(
                      text: time,
                      textSize: 12.sp,
                      textColor: AppColor.black,
                      textFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 6.h),
                    ReusableText(
                      text: date,
                      textSize: 12.sp,
                      textColor: AppColor.black,
                      textFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 33.h),
                    Center(
                      child: ContinueButton(
                        onpress: onPress,
                        width: SizeScreen.width * 0.23,
                        height: SizeScreen.height * 0.028,
                        borderColor: AppColor.red,
                        textColor: AppColor.white,
                        textButton: 'Cancel',
                        textSize: 9.sp,
                        buttonColor: AppColor.red,
                        widget: SizedBox(),
                        borderRadious: 5,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
