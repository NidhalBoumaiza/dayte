import 'dart:convert';
import 'dart:io';

import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../constant.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../../../authorisation/presentation layer/widgets/add_image.dart';
import '../../../../authorisation/presentation layer/widgets/gender_select.dart';
import '../../widgets/text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Static values for testing
  String name = "John Doe";
  String birthday = "1990/01/01";
  String gender = "man";
  List<dynamic> pictures = [];
  DateTime birthdayDate = new DateTime(1990, 1, 1);
  late TextEditingController controllerName;
  late TextEditingController controllerBirthday;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers in initState
    controllerName = TextEditingController(text: name);
    controllerBirthday = TextEditingController(text: birthday);
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
                MyCustomButton(
                  width: double.infinity,
                  height: 45.h,
                  function: () {
                    Navigator.pop(context);
                  },
                  buttonColor: AppColor.red,
                  text: "Logout",
                  fontWeight: FontWeight.w700,
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
          Scaffold(
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
                            GestureDetector(
                              onTap: () => StoragePermission(),
                              child: AddImage(
                                height: 0.138.sh,
                                width: 0.28.sw,
                                image: null,
                                imageString: null,
                                onPress: () {},
                              ),
                            ),
                            GestureDetector(
                              onTap: () => StoragePermission(),
                              child: AddImage(
                                height: 0.138.sh,
                                width: 0.28.sw,
                                image: null,
                                imageString: null,
                                onPress: () {},
                              ),
                            ),
                            GestureDetector(
                              onTap: () => StoragePermission(),
                              child: AddImage(
                                height: 0.138.sh,
                                width: 0.28.sw,
                                image: null,
                                imageString: null,
                                onPress: () {},
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => StoragePermission(),
                              child: AddImage(
                                height: 0.138.sh,
                                width: 0.28.sw,
                                image: null,
                                imageString: null,
                                onPress: () {},
                              ),
                            ),
                            GestureDetector(
                              onTap: () => StoragePermission(),
                              child: AddImage(
                                height: 0.138.sh,
                                width: 0.28.sw,
                                image: null,
                                imageString: null,
                                onPress: () {},
                              ),
                            ),
                            GestureDetector(
                              onTap: () => StoragePermission(),
                              child: AddImage(
                                height: 0.138.sh,
                                width: 0.28.sw,
                                image: null,
                                imageString: null,
                                onPress: () {},
                              ),
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
                              name = value;
                            });
                          },
                          hint: 'Enter your name...',
                          keyboardType: TextInputType.name,
                          inputdecoration: KinputDecoration.copyWith(
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 15.sp),
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
                                initialDateTime: birthdayDate,
                                mode: CupertinoDatePickerMode.date,
                                use24hFormat: true,
                                showDayOfWeek: true,
                                onDateTimeChanged: (DateTime newDate) {
                                  setState(() {
                                    birthdayDate = newDate;
                                    birthday = DateFormat('yyyy/MM/dd')
                                        .format(newDate);
                                    controllerBirthday.text = birthday;
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
                                  gender = 'man';
                                });
                              },
                              child: GenderSelect(
                                containerColor: gender == 'man'
                                    ? AppColor.red
                                    : const Color(0xffe9e7e7),
                                horizontalPadding: 20.w,
                                function: () {},
                                borderColor: gender == 'man'
                                    ? AppColor.red
                                    : const Color(0xffe9e7e7),
                                checked: const SizedBox(),
                                textGender: 'Man',
                                textColor: gender == 'man'
                                    ? Colors.white
                                    : const Color(0xff717171),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  gender = 'woman';
                                });
                              },
                              child: GenderSelect(
                                containerColor: gender == 'woman'
                                    ? AppColor.red
                                    : const Color(0xffe9e7e7),
                                horizontalPadding: 20.w,
                                function: () {},
                                borderColor: gender == 'woman'
                                    ? AppColor.red
                                    : const Color(0xffe9e7e7),
                                checked: const SizedBox(),
                                textGender: 'Woman',
                                textColor: gender == 'woman'
                                    ? Colors.white
                                    : const Color(0xff717171),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  gender = 'other';
                                });
                              },
                              child: GenderSelect(
                                containerColor: gender == 'other'
                                    ? AppColor.red
                                    : const Color(0xffe9e7e7),
                                horizontalPadding: 20.w,
                                function: () {},
                                borderColor: gender == 'other'
                                    ? AppColor.red
                                    : const Color(0xffe9e7e7),
                                checked: const SizedBox(),
                                textGender: 'Other',
                                textColor: gender == 'other'
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
                      child: MyCustomButton(
                        width: double.infinity,
                        height: 45.h,
                        function: () {},
                        buttonColor: AppColor.red,
                        text: "Submit",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// The remaining functions (StoragePermission, _imgFromGallery, _cropImage, fileToBase64)
// can be kept as they are, with minor adjustments to remove GetX dependencies if any.

void StoragePermission() async {
  var status = await Permission.storage.status;
  if (status.isGranted) {
    _imgFromGallery();
  } else if (status.isDenied) {
    // You haven't requested permission yet; request it now.
    var result = await Permission.storage.request();
    if (result.isGranted) {
      _imgFromGallery();
    } else {
      var result = await Permission.storage.request();
    }
  } else if (status.isDenied || status.isPermanentlyDenied) {
    openAppSettings(); // Open device settings for the user to enable permissions.
  }
}

File? imageFile;
var bytesss;

_imgFromGallery() async {
  await picker
      .pickImage(source: ImageSource.gallery, imageQuality: 50)
      .then((value) {
    if (value != null) {
      _cropImage(File(value.path));
    }
  });
}

final picker = ImagePicker();

_cropImage(File imgFile) async {
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
    // var controllerHome = Get.find<MotherScreenController>();
    imageCache.clear();
    String base64Data = await fileToBase64(File(croppedFile.path));
    print(File(croppedFile.path).runtimeType);
    base64Data = "$base64Data";
    print(base64Data);
    // controllerHome.myProfile.pictures!.add(File(croppedFile.path));
  }
}

Future<String> fileToBase64(File file) async {
  List<int> fileBytes = await file.readAsBytes();
  String base64Image = base64Encode(file.readAsBytesSync());

  return base64Image;
}
