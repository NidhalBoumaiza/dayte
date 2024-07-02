import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContinueButton extends StatelessWidget {
  void Function() onpress;
  double height, width;
  Color borderColor, textColor;
  String textButton;
  Widget? widget;
  double? textSize;
  Color? buttonColor;
  double? borderRadious;
  FontWeight? fontWeight;

  ContinueButton(
      {Key? key,
      required this.onpress,
      required this.width,
      required this.height,
      required this.borderColor,
      required this.textColor,
      required this.textButton,
      this.widget,
      this.textSize,
      this.buttonColor,
      this.borderRadious,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: Color(0xffAB3333),
            width: 2,
          ),
          elevation: 0,
          disabledBackgroundColor: Colors.transparent,
          backgroundColor: buttonColor ?? Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadious ?? 2),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textButton,
                style: TextStyle(
                  color: textColor ?? Color(0xffAB3333),
                  fontWeight: fontWeight ?? FontWeight.w700,
                  fontSize: textSize ?? 15.sp,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(width: 3.w),
              widget!,
            ],
          ),
        ),
      ),
    );
  }
}
