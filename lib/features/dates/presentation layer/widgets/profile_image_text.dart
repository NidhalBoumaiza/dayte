import 'dart:core';

import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImageText extends StatelessWidget {
  String? prompt, description, img;

  ProfileImageText({
    super.key,
    this.description,
    this.prompt,
    this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.h),
      child: Column(
        children: [
          Container(
            height: 370.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage("${dotenv.env['URLIMAGE']}$img"),
                //AssetImage(img!), // NetworkImage('$img'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          // Image.asset(img!), // Image.network('$img'),
          SizedBox(height: 4.h),
          prompt != null
              ? Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffFCF1F1),
                      borderRadius: BorderRadius.circular(5)),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.5,
                      vertical: 13,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prompt!,
                          style: const TextStyle(
                            fontFamily: "Times",
                            fontSize: 12,
                            color: Color(0xffAB3333),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        ReusableText(
                          text: description ?? "",
                          textSize: 12.sp,
                          textColor: Color(0xff6D6D6D),
                          textFontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
