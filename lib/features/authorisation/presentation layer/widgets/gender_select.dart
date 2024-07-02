import 'package:flutter/material.dart';

import '../../../../core/widgets/reusable_text.dart';

class GenderSelect extends StatelessWidget {
  String textGender;
  Widget checked;
  Color borderColor;
  Color? containerColor, textColor;
  double? radious;
  double? containerWidth, textSize, horizontalPadding;
  void Function() function;

  GenderSelect({
    Key? key,
    required this.borderColor,
    required this.checked,
    required this.textGender,
    required this.function,
    this.containerColor,
    this.radious,
    this.containerWidth,
    this.textSize,
    this.horizontalPadding,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: containerWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radious ?? 10),
        color: containerColor ?? Color(0xffe9e7e7),
        border: Border.all(
          color: borderColor, // Replace with your desired border color
          width: 1.5, // Adjust the border width as needed
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 6.0, horizontal: horizontalPadding ?? 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(child: checked),
              const SizedBox(width: 3),
              ReusableText(
                text: textGender,
                textColor: textColor ?? const Color(0xff717171),
                textSize: textSize ?? 12.0,
                textFontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
