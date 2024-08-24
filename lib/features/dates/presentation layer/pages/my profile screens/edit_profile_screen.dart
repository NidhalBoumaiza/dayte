import 'dart:convert';
import 'dart:io';

import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/get%20profile%20bloc/get_profile_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../constant.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../../../../core/widgets/reusable_circular_progressive_indicator.dart';
import '../../../../authorisation/presentation layer/widgets/add_image.dart';
import '../../../../authorisation/presentation layer/widgets/gender_select.dart';
import '../../../../authorisation/presentation layer/widgets/snackBar.dart';
import '../../cubit/edit image/edit_image_cubit.dart';
import '../../cubit/edit image/edit_image_state.dart';
import '../../cubit/edit profile cubit/edit_profile_cubit.dart';
import '../../widgets/sign_out_logic_widget.dart';
import '../../widgets/text_field.dart';

class EditProfileScreen extends StatefulWidget {
  late String name;
  late String birthday;
  late String gender;
  late DateTime birthdayDate;

  EditProfileScreen({
    Key? key,
    required this.name,
    required this.gender,
    required this.birthday,
    required this.birthdayDate,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Static values for testing

  List<dynamic> pictures = [];

  late TextEditingController controllerName;
  late TextEditingController controllerBirthday;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers in initState
    controllerName = TextEditingController(text: widget.name);
    controllerBirthday = TextEditingController(text: widget.birthday);
  }

  @override
  Widget build(BuildContext context) {
    void _showDatePicker(Widget child) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          decoration: BoxDecoration(
              color: CupertinoColors.systemBackground.resolveFrom(context),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )),
          height: 0.43.sh,
          padding: EdgeInsets.only(top: 6.h),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                SizedBox(
                  height: 0.3.sh,
                  child: child,
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: MyCustomButton(
                    width: double.infinity,
                    height: 45.h,
                    function: () {
                      Navigator.pop(context);
                    },
                    buttonColor: AppColor.red,
                    text: "Save",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Stack(
        children: [
          SvgPicture.string(
            backgroundEmpty,
            fit: BoxFit.cover,
          ),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Transform(
                  transform: Matrix4.translationValues(-0.0, 0.0, 0.0),
                  child: Text(
                    "Edit profile",
                    style: TextStyle(
                      color: AppColor.red,
                      fontSize: 20.sp,
                      letterSpacing: 0.3,
                      fontFamily: 'Times',
                      fontWeight: FontWeight.w700,
                      wordSpacing: 0.0,
                    ),
                  ),
                ),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.w),
                    child: SizedBox(child: SvgPicture.string(arrowBack)),
                  ),
                ),
                backgroundColor: Colors.transparent,
              ),
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15.w, 25.h, 15.w, 30.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<EditImageCubit, EditImageState>(
                                builder: (context, state) {
                                  print(state.img);
                                  return GestureDetector(
                                    onTap: state.img.isEmpty
                                        ? () {
                                            showImagePicker(context);
                                          }
                                        : null,
                                    child: AddImage(
                                        height: SizeScreen.height * 0.138,
                                        width: SizeScreen.width * 0.28,
                                        imageString: state.img.isNotEmpty &&
                                                state.img[0].contains(
                                                    "https://dayteimages.s3.eu-north-1.amazonaws.com")
                                            ? state.img[0]
                                            : null,
                                        image: state.img.isNotEmpty
                                            ? state.img[0]
                                            : null,
                                        onPress: () {
                                          context
                                              .read<EditImageCubit>()
                                              .removeImage(0);
                                        }),
                                  );
                                },
                              ),
                              BlocBuilder<EditImageCubit, EditImageState>(
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
                                        imageString: state.img.length > 1 &&
                                                state.img[1].contains(
                                                    "https://dayteimages.s3.eu-north-1.amazonaws.com")
                                            ? state.img[1]
                                            : null,
                                        image: state.img.length > 1
                                            ? state.img[1]
                                            : null,
                                        onPress: () {
                                          context
                                              .read<EditImageCubit>()
                                              .removeImage(1);
                                        }),
                                  );
                                },
                              ),
                              BlocBuilder<EditImageCubit, EditImageState>(
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
                                        imageString: state.img.length > 2 &&
                                                state.img[2].contains(
                                                    "https://dayteimages.s3.eu-north-1.amazonaws.com")
                                            ? state.img[2]
                                            : null,
                                        image: state.img.length > 2
                                            ? state.img[2]
                                            : null,
                                        onPress: () {
                                          context
                                              .read<EditImageCubit>()
                                              .removeImage(2);
                                        }),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<EditImageCubit, EditImageState>(
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
                                        imageString: state.img.length > 3 &&
                                                state.img[3].contains(
                                                    "https://dayteimages.s3.eu-north-1.amazonaws.com")
                                            ? state.img[3]
                                            : null,
                                        image: state.img.length > 3
                                            ? state.img[3]
                                            : null,
                                        onPress: () {
                                          context
                                              .read<EditImageCubit>()
                                              .removeImage(3);
                                        }),
                                  );
                                },
                              ),
                              BlocBuilder<EditImageCubit, EditImageState>(
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
                                        imageString: state.img.length > 4 &&
                                                state.img[4].contains(
                                                    "https://dayteimages.s3.eu-north-1.amazonaws.com")
                                            ? state.img[4]
                                            : null,
                                        image: state.img.length > 4
                                            ? state.img[4]
                                            : null,
                                        onPress: () {
                                          context
                                              .read<EditImageCubit>()
                                              .removeImage(4);
                                        }),
                                  );
                                },
                              ),
                              BlocBuilder<EditImageCubit, EditImageState>(
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
                                        imageString: state.img.length > 5 &&
                                                state.img[5].contains(
                                                    "https://dayteimages.s3.eu-north-1.amazonaws.com")
                                            ? state.img[5]
                                            : null,
                                        image: state.img.length > 5
                                            ? state.img[5]
                                            : null,
                                        onPress: () {
                                          context
                                              .read<EditImageCubit>()
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
                            textSize: 12.sp,
                            textColor: AppColor.grey,
                            textFontWeight: FontWeight.w400,
                          ),
                          // TextWidget("3 photos required", AppColor.grey, 12.sp,
                          //     FontWeight.w400, 0.0),
                          SizedBox(height: 30.h),
                          ReusableText(
                            text: "Name",
                            textSize: 12.sp,
                            textColor: AppColor.grey,
                            textFontWeight: FontWeight.w400,
                          ),

                          SizedBox(height: 5.h),

                          TextFieldWidget(
                            colorText: const Color(0xff7F7D7D),
                            controller: controllerName,
                            function: (value) {
                              setState(() {
                                widget.name = value;
                              });
                            },
                            hint: 'Enter your name...',
                            keyboardType: TextInputType.name,
                            inputdecoration: KinputDecoration.copyWith(
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 15.sp),
                              hintText: "Enter your name...",
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Icon(
                                  FontAwesomeIcons.chevronRight,
                                  size: 17.sp,
                                  color: AppColor.greyTextField,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 30.h),
                          ReusableText(
                            text: "Birthday",
                            textSize: 12.sp,
                            textColor: AppColor.grey,
                            textFontWeight: FontWeight.w400,
                          ),

                          SizedBox(height: 5.h),
                          GestureDetector(
                            onTap: () {
                              _showDatePicker(
                                CupertinoDatePicker(
                                  initialDateTime: widget.birthdayDate,
                                  mode: CupertinoDatePickerMode.date,
                                  use24hFormat: true,
                                  showDayOfWeek: true,
                                  onDateTimeChanged: (DateTime newDate) {
                                    setState(() {
                                      widget.birthdayDate = newDate;
                                      widget.birthday = DateFormat('dd/MM/yyyy')
                                          .format(newDate);
                                      controllerBirthday.text = widget.birthday;
                                    });
                                  },
                                ),
                              );
                            },
                            child: TextFieldWidget(
                              controller: controllerBirthday,
                              colorText: const Color(0xff7F7D7D),
                              function: (String) {},
                              enabled: false,
                              hint: 'Select your birthday...',
                              keyboardType: TextInputType.name,
                              inputdecoration: KinputDecoration.copyWith(
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 15.sp),
                                hintText: "Select your birthday...",
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: Icon(
                                    FontAwesomeIcons.chevronDown,
                                    size: 17.sp,
                                    color: AppColor.greyTextField,
                                  ),
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: Icon(
                                    FontAwesomeIcons.cakeCandles,
                                    size: 17.sp,
                                    color: AppColor.greyTextField,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.gender = 'man';
                                  });
                                },
                                child: GenderSelect(
                                  containerColor: widget.gender == 'man'
                                      ? AppColor.red
                                      : const Color(0xffe9e7e7),
                                  horizontalPadding: 20.w,
                                  function: () {},
                                  borderColor: widget.gender == 'man'
                                      ? AppColor.red
                                      : const Color(0xffe9e7e7),
                                  checked: const SizedBox(),
                                  textGender: 'Man',
                                  textColor: widget.gender == 'man'
                                      ? Colors.white
                                      : const Color(0xff717171),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.gender = 'woman';
                                  });
                                },
                                child: GenderSelect(
                                  containerColor: widget.gender == 'woman'
                                      ? AppColor.red
                                      : const Color(0xffe9e7e7),
                                  horizontalPadding: 20.w,
                                  function: () {},
                                  borderColor: widget.gender == 'woman'
                                      ? AppColor.red
                                      : const Color(0xffe9e7e7),
                                  checked: const SizedBox(),
                                  textGender: 'Woman',
                                  textColor: widget.gender == 'woman'
                                      ? Colors.white
                                      : const Color(0xff717171),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.gender = 'other';
                                  });
                                },
                                child: GenderSelect(
                                  containerColor: widget.gender == 'other'
                                      ? AppColor.red
                                      : const Color(0xffe9e7e7),
                                  horizontalPadding: 20.w,
                                  function: () {},
                                  borderColor: widget.gender == 'other'
                                      ? AppColor.red
                                      : const Color(0xffe9e7e7),
                                  checked: const SizedBox(),
                                  textGender: 'Other',
                                  textColor: widget.gender == 'other'
                                      ? Colors.white
                                      : const Color(0xff717171),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 0.04.sh),
                      Center(
                        child: BlocConsumer<EditProfileCubit, EditProfileState>(
                          listener: (context, state) {
                            if (state is EditProfileSuccess) {
                              snackbar(
                                context,
                                2,
                                'Your profile has been updated succefully .',
                                Colors.green,
                              );
                              context.read<GetProfileBloc>().add(GetProfile());
                              Future.delayed(Duration(seconds: 1), () {
                                Get.back();
                              });
                            } else if (state is EditProfileErreur) {
                              snackbar(
                                context,
                                2,
                                state.message,
                                Colors.red,
                              );
                            } else if (state is EditProfileUnauthorised) {
                              snackbar(
                                context,
                                2,
                                state.message,
                                Colors.red,
                              );
                            } else if (state is EditProfileOffline) {
                              snackbar(
                                context,
                                2,
                                state.message,
                                Colors.red,
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is EditProfileUnauthorised) {
                              return handleUnauthorizedAccessLogic(context);
                            }
                            return MyCustomButton(
                              width: double.infinity,
                              height: 45.h,
                              function: state is EditProfileLoading
                                  ? () {}
                                  : () {
                                      context
                                          .read<EditProfileCubit>()
                                          .editProfile(
                                            widget.name,
                                            widget.gender,
                                            widget.birthdayDate
                                                .add(Duration(days: 1)),
                                            context
                                                .read<EditImageCubit>()
                                                .state
                                                .croppedImage!,
                                          );
                                    },
                              buttonColor: AppColor.red,
                              text: "Submit",
                              fontWeight: FontWeight.w700,
                              widget: state is EditProfileLoading
                                  ? ReusablecircularProgressIndicator(
                                      indicatorColor: Colors.white,
                                      height: 15,
                                      width: 15,
                                    )
                                  : SizedBox(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
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
      context.read<EditImageCubit>().changeImage(base64Data, croppedFile.path);
    }
  }

  Future<String> fileToBase64(File file) async {
    List<int> fileBytes = await file.readAsBytes();
    String base64Image = base64Encode(fileBytes);
    return base64Image;
  }
}

// The remaining functions (StoragePermission, _imgFromGallery, _cropImage, fileToBase64)
// can be kept as they are, with minor adjustments to remove GetX dependencies if any.
