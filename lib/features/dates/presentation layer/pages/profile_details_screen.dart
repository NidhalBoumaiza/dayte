import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constant.dart';
import '../widgets/interest_widget.dart';
import '../widgets/profile_image_text.dart';

class ProfileDetailScreen extends StatelessWidget {
  final Map<String, dynamic> profile;

  const ProfileDetailScreen({Key? key, required this.profile})
      : super(key: key);

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
            floatingActionButton: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 17.0.h, left: 23.w),
                child: FloatingActionButton(
                  highlightElevation: 0,
                  hoverColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverElevation: 0,
                  focusColor: Colors.transparent,
                  focusElevation: 0,
                  disabledElevation: 0,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.string(arrowBack),
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: SizeScreen.height * 0.635,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/1.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: SizeScreen.height * 0.59,
                        child: Container(
                          width: SizeScreen.width * 1,
                          height: 50.h,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 23.w,
                        top: SizeScreen.height * 0.56,
                        child: GestureDetector(
                          onTap: profile['liked']['value'] == false
                              ? () {
                                  // Handle like action
                                }
                              : null,
                          child: Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: profile['liked']['value'] == false
                                  ? const Color(0xffAB3333)
                                  : Colors.grey.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                              size: 33.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10.0.w, right: 10.w, bottom: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: "${profile['name']}, ${profile['age']}",
                          textSize: 20.sp,
                          textColor: AppColor.black,
                          textFontWeight: FontWeight.w800,
                        ),
                        SizedBox(height: 3.h),
                        ReusableText(
                          text: "${profile['gender']}",
                          textSize: 10.sp,
                          textColor: AppColor.grey,
                          textFontWeight: FontWeight.w300,
                        ),
                        SizedBox(height: 3.h),
                        ReusableText(
                          text: "Interests",
                          textSize: 16.sp,
                          textColor: AppColor.grey,
                          textFontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 3.h),
                        Container(
                          height: 38.h,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: profile['interests'].length,
                            itemBuilder: (BuildContext context, int i) {
                              return InterestWidget(
                                icon: FontAwesomeIcons.book,
                                interest: "${profile['interests'][i]}",
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: profile['pictures'].length - 1,
                          itemBuilder: (BuildContext context, int indexx) {
                            return ProfileImageText(
                                description: indexx < profile['prompts'].length
                                    ? profile['prompts'][indexx]['answer']
                                    : null,
                                prompt: indexx < profile['prompts'].length
                                    ? profile['prompts'][indexx]['prompt']
                                    : null,
                                img:
                                    "images/2.png" //profile['pictures'][indexx + 1],
                                );
                          },
                        ),
                        SizedBox(height: 18.h),
                        Center(
                          child: ReusableText(
                            text: "${profile['name'].split(" ")[0]}'s profile",
                            textSize: 14.sp,
                            textColor: AppColor.black,
                            textFontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
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
}
