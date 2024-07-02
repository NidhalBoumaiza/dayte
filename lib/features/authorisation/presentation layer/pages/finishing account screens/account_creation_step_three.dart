import 'dart:convert';
import 'dart:io';

import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../constant.dart';
import '../../../../../core/widgets/reusable_text.dart';
import '../../cubit/first image cubit/first_image_cubit.dart';
import '../../cubit/first image cubit/first_image_state.dart';
import '../../widgets/add_image.dart';
import '../../widgets/continueButton.dart';
import 'account_creation_step_four.dart';

class FinishingAccountStepThree extends StatelessWidget {
  FinishingAccountStepThree({Key? key}) : super(key: key);

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
          appBar: appBar,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.fromLTRB(15.0.w, 30.h, 15.w, 45.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select your photos",
                        style: TextStyle(
                          color: AppColor.red,
                          fontSize: 25.sp,
                          letterSpacing: 0.3,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.w700,
                          wordSpacing: 0.0,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<FirstImageCubit, FirstImageState>(
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: state.img.isEmpty
                                    ? () {
                                        showImagePicker(context);
                                      }
                                    : null,
                                child: AddImage(
                                    height: SizeScreen.height * 0.138,
                                    width: SizeScreen.width * 0.28,
                                    image: state.img.isNotEmpty
                                        ? state.img[0]
                                        : null,
                                    onPress: () {
                                      context
                                          .read<FirstImageCubit>()
                                          .removeImage(0);
                                    }),
                              );
                            },
                          ),
                          BlocBuilder<FirstImageCubit, FirstImageState>(
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: state.img.length == 1
                                    ? () {
                                        showImagePicker(context);
                                      }
                                    : null,
                                child: AddImage(
                                    height: SizeScreen.height * 0.138,
                                    width: SizeScreen.width * 0.28,
                                    image: state.img.length > 1
                                        ? state.img[1]
                                        : null,
                                    onPress: () {
                                      context
                                          .read<FirstImageCubit>()
                                          .removeImage(1);
                                    }),
                              );
                            },
                          ),
                          BlocBuilder<FirstImageCubit, FirstImageState>(
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: state.img.length == 2
                                    ? () {
                                        showImagePicker(context);
                                      }
                                    : null,
                                child: AddImage(
                                    height: SizeScreen.height * 0.138,
                                    width: SizeScreen.width * 0.28,
                                    image: state.img.length > 2
                                        ? state.img[2]
                                        : null,
                                    onPress: () {
                                      context
                                          .read<FirstImageCubit>()
                                          .removeImage(2);
                                    }),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<FirstImageCubit, FirstImageState>(
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: state.img.length == 3
                                    ? () {
                                        showImagePicker(context);
                                      }
                                    : null,
                                child: AddImage(
                                    height: SizeScreen.height * 0.138,
                                    width: SizeScreen.width * 0.28,
                                    image: state.img.length > 3
                                        ? state.img[3]
                                        : null,
                                    onPress: () {
                                      context
                                          .read<FirstImageCubit>()
                                          .removeImage(3);
                                    }),
                              );
                            },
                          ),
                          BlocBuilder<FirstImageCubit, FirstImageState>(
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: state.img.length == 4
                                    ? () {
                                        showImagePicker(context);
                                      }
                                    : null,
                                child: AddImage(
                                    height: SizeScreen.height * 0.138,
                                    width: SizeScreen.width * 0.28,
                                    image: state.img.length > 4
                                        ? state.img[4]
                                        : null,
                                    onPress: () {
                                      context
                                          .read<FirstImageCubit>()
                                          .removeImage(4);
                                    }),
                              );
                            },
                          ),
                          BlocBuilder<FirstImageCubit, FirstImageState>(
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: state.img.length == 5
                                    ? () {
                                        showImagePicker(context);
                                      }
                                    : null,
                                child: AddImage(
                                    height: SizeScreen.height * 0.138,
                                    width: SizeScreen.width * 0.28,
                                    image: state.img.length > 5
                                        ? state.img[5]
                                        : null,
                                    onPress: () {
                                      context
                                          .read<FirstImageCubit>()
                                          .removeImage(5);
                                    }),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ReusableText(
                        text: "3 photos required",
                        textColor: AppColor.grey,
                        textSize: 10.0.sp,
                        textFontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 65.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColor.grey,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.h),
                            child: ReusableText(
                              text:
                                  "Your profile must contain at least 1 face photo and 2 full body photos",
                              textColor: AppColor.grey,
                              textSize: 11.0.sp,
                              textFontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: ContinueButton(
                    onpress: () {
                      // if (context.read<FirstImageCubit>().state.img.length <
                      //     3) {
                      //   snackbar(
                      //       context,
                      //       1,
                      //       "Your profile must have at least 3 photos",
                      //       Colors.redAccent);
                      // } else {
                      //   // Get.toNamed("/accountstepfour");
                      // }
                      navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                        context,
                        FinishingAccountStepFour(),
                      );
                    },
                    width: SizeScreen.width * 0.63,
                    height: SizeScreen.height * 0.062,
                    borderColor: AppColor.red,
                    textColor: AppColor.red,
                    textButton: 'Continue',
                    widget: SvgPicture.string(continueArrow),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  final picker = ImagePicker();

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.11,
              margin: const EdgeInsets.only(top: 8.0),
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: InkWell(
                    child: const Column(
                      children: [
                        Icon(Icons.image, size: 32.0, color: Color(0xff284F7B)),
                        SizedBox(height: 5.0),
                        Text(
                          "Galerie",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 14, color: Color(0xff284F7B)),
                        )
                      ],
                    ),
                    onTap: () {
                      _imgFromGallery(context);
                      Get.back();
                    },
                  )),
                  Expanded(
                      child: InkWell(
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt,
                              size: 32.0, color: Color(0xff284F7B)),
                          SizedBox(height: 5.0),
                          Text(
                            "Caméra",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff284F7B)),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      _imgFromCamera(context);
                      Get.back();
                    },
                  ))
                ],
              ));
        });
  }

  _imgFromGallery(BuildContext context) async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path), context);
      }
    });
  }

  _imgFromCamera(BuildContext context) async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path), context);
      }
    });
  }

  _cropImage(File imgFile, BuildContext context) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Sélectionnez l'image",
              toolbarColor: const Color(0xff284F7B),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: "Sélectionnez l'image",
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      String base64Data = await fileToBase64(File(croppedFile.path));
      base64Data = "data:image/png;base64,$base64Data";
      context.read<FirstImageCubit>().changeImage(base64Data, croppedFile.path);
    }
  }

  Future<String> fileToBase64(File file) async {
    List<int> fileBytes = await file.readAsBytes();
    String base64Image = base64Encode(fileBytes);
    return base64Image;
  }
}
