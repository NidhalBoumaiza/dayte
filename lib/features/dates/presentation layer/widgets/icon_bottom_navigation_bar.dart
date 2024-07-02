import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconBottomNavigationBar extends StatelessWidget {
  Widget icon;
  String pageName;
  Color? textColor;

  IconBottomNavigationBar(
      {super.key, required this.icon, required this.pageName, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        ReusableText(
          text: pageName,
          textSize: 10.sp,
          textFontWeight: FontWeight.w800,
          textColor: textColor ?? Color(0xff907A7A),
        ),
      ],
    );
  }
}
