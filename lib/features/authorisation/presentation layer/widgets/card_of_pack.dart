import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constant.dart';

class PriceCard extends StatelessWidget {
  String? packName, price, text1, text2, text3;
  Widget? tick;
  Color? borderColor;
  double? borderWidth;

  PriceCard({
    Key? key,
    this.packName,
    this.price,
    this.text1,
    this.text2,
    this.text3,
    this.tick,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeScreen.width * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: borderColor!,
          width: borderWidth!,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(
                  text: packName!,
                  textSize: 17.0.sp,
                  textColor: AppColor.grey,
                  textFontWeight: FontWeight.w600,
                ),
                tick!,
              ],
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                      text: price!,
                      textSize: 23.0.sp,
                      textColor: AppColor.grey,
                      textFontWeight: FontWeight.w800),
                  SizedBox(height: 10.h),
                  rowCard(text1),
                  SizedBox(height: 10.h),
                  rowCard(text2),
                  SizedBox(height: 10.h),
                  rowCard(text3),
                  SizedBox(height: 10.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget rowCard(text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(
        FontAwesomeIcons.solidCircleCheck,
        color: AppColor.red,
        size: 17.sp,
      ),
      SizedBox(width: 10.w),
      ReusableText(
          text: text,
          textSize: 14.0.sp,
          textColor: AppColor.grey,
          textFontWeight: FontWeight.w400),
    ],
  );
}
