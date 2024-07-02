import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constant.dart';

class TextFieldWidget extends StatelessWidget {
  void Function(String) function;
  TextInputType keyboardType;
  String hint;
  bool? enabled, obsecuretext;
  InputDecoration? inputdecoration;
  TextEditingController? controller;
  int? maxLines, minLines;
  String? Function(String?)? validatorFunction;
  String? errorMessage;
  Color? colorText;

  TextFieldWidget({
    Key? key,
    required this.function,
    required this.hint,
    required this.keyboardType,
    this.controller,
    this.enabled,
    this.inputdecoration,
    this.obsecuretext,
    this.maxLines,
    this.minLines,
    this.colorText,
    this.errorMessage,
    this.validatorFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      enabled: enabled ?? true,
      obscureText: obsecuretext ?? false,
      controller: controller,
      validator: validatorFunction ??
          (value) {
            if (value == null || value.isEmpty) {
              return errorMessage ?? 'Ce champ est obligatoire';
            }
            return null;
          },
      //textAlignVertical: TextAlignVertical.center,
      keyboardType: keyboardType,
      onChanged: function,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: colorText ?? AppColor.black,
        fontSize: 13.sp,
      ),
      textAlign: TextAlign.start,

      decoration: inputdecoration ??
          KinputDecoration.copyWith(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 12.sp),
          ),
    );
  }
}
