import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Function function;
  final Color buttonColor;
  final String text;
  final double? circularRadious;
  final Widget? widget;
  final Color? textButtonColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget? icon;

  MyCustomButton({
    required this.width,
    required this.height,
    required this.function,
    required this.buttonColor,
    required this.text,
    this.circularRadious,
    this.widget,
    this.textButtonColor,
    this.fontSize,
    this.fontWeight,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: AbsorbPointer(
        absorbing: false,
        child: ElevatedButton(
          onPressed: () => function(),
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: buttonColor,
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(circularRadious ?? 10),
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? const SizedBox(),
                icon != null ?  SizedBox(width: 10.w) : const SizedBox(),
                Text(
                  text,
                  style: GoogleFonts.nunito(
                    color: textButtonColor ?? Colors.white,
                    fontWeight: fontWeight ?? FontWeight.w600,
                    fontSize: fontSize ?? 15,
                    letterSpacing: 0.1,
                  ),
                ),
                widget != null
                    ? Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: widget ?? const SizedBox(),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
