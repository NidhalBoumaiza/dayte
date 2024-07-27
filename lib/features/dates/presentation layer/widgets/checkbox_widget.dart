import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constant.dart';

class CheckboxWidget extends StatelessWidget {
  bool? d;
  String text;
  Function()? onPress;
  Function(bool?)? onChange;

  CheckboxWidget(
      {Key? key,
      required this.text,
      this.onPress,
      this.onChange,
      this.d = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(
                      color: Color(0xffADA9A9),
                      width: 2,
                    ),
                    splashRadius: 0,
                    value: d!,
                    onChanged: onChange,
                    activeColor: const Color(0xffADA9A9),
                    checkColor: AppColor.red,
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: onPress,
                    child: SizedBox(
                      child: ReusableText(
                        text: text,
                        textSize: 15.sp,
                        textFontWeight: FontWeight.w500,
                        textColor: Color(0xff7C7C7C),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 0,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Color(0xff7C7C7C),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
