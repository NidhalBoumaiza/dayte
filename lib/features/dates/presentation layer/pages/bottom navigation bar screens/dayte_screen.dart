import 'dart:ui';

import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../constant.dart';
import '../../../../authorisation/presentation layer/widgets/gender_select.dart';
import '../../widgets/dayte_card_widget.dart';

class DayteScreen extends StatelessWidget {
  final List<Map<String, dynamic>> daytes;

  const DayteScreen({Key? key, required this.daytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(2.w, 7.h, 2.w, 27.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Center(
              child: Text(
                "Daytes",
                style: TextStyle(
                  color: AppColor.red,
                  fontSize: 35.sp,
                  letterSpacing: 0.3,
                  fontFamily: 'Times',
                  fontWeight: FontWeight.w700,
                  wordSpacing: 0.0,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.h),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: daytes.length,
                itemBuilder: (BuildContext context, int index) {
                  final dayte = daytes[index];
                  return index == 0
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/itsadate');
                          },
                          child: DayteCard(
                            image: dayte['profilePicture'],
                            onPress: () => cancelDayte(context),
                            date: dayte['date'],
                            time: dayte['time'],
                          ),
                        )
                      : ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            tileMode: TileMode.decal,
                            sigmaX: 3.5,
                            sigmaY: 3.5,
                          ),
                          child: DayteCard(
                            image: dayte['profilePicture'],
                            onPress: () {},
                            date: dayte['date'],
                            time: dayte['time'],
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Keep the cancelDayte and ShimmerLoadingDaytes as they are

void cancelDayte(context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      // Drawer from the bottom
      return Container(
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: SizeScreen.height * 0.41,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: SizeScreen.width * 0.8,
                  child: ReusableText(
                    text: "Are you sure you want to cancel the dayte ?",
                    textSize: 18.sp,
                    textColor: AppColor.red,
                    textFontWeight: FontWeight.w800,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO LATER
                      Get.back();
                    },
                    child: GenderSelect(
                      horizontalPadding: 20,
                      textSize: 13,
                      function: () {},
                      borderColor: const Color(0xffe9e7e7),
                      // AppColor.red,
                      checked: const SizedBox(),
                      // SvgPicture.string(doubleCheck)
                      textGender: 'Yes',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO LATER
                      Get.back();
                    },
                    child: GenderSelect(
                      horizontalPadding: 20,
                      textSize: 13,
                      function: () {},
                      borderColor: const Color(0xffe9e7e7),
                      // AppColor.red,
                      checked: const SizedBox(),
                      // SvgPicture.string(doubleCheck)
                      textGender: 'Not sure yet',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO LATER
                      Get.back();
                    },
                    child: GenderSelect(
                      horizontalPadding: 20,
                      textSize: 13,
                      function: () {},
                      borderColor: const Color(0xffe9e7e7),
                      // AppColor.red,
                      checked: const SizedBox(),
                      // SvgPicture.string(doubleCheck)
                      textGender: 'No',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.grey,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        // TextWidget
                        text: "• You will be flagged",
                        textSize: 13.sp,
                        textColor: AppColor.grey,
                        textFontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 13.h),
                      ReusableText(
                        // TextWidget
                        text: "• We encourage you to date without fear",
                        textSize: 13.sp,
                        textColor: AppColor.grey,
                        textFontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 13.h),
                      ReusableText(
                        text: "• Safety is enforced, strictly",
                        textSize: 13.sp,
                        textColor: AppColor.grey,
                        textFontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class ShimmerLoadingDaytes extends StatelessWidget {
  const ShimmerLoadingDaytes({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[350]!, // Darker gray for base color
      highlightColor: Colors.grey[200]!, // Lighter gray for highlight color
      child: Container(
        width: double.infinity,
        height: 165,
        constraints: const BoxConstraints(
          maxWidth: double.infinity,
          minWidth: double.infinity,
          maxHeight: 190,
          minHeight: 165,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColor.grey, width: 2.5),
        ),
      ),
    );
  }
}
