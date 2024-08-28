import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_circular_progressive_indicator.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/register%20bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../constant.dart';
import '../../../../../core/widgets/reusable_text_field_widget.dart';
import '../../widgets/continueButton.dart';
import '../creation account screens/signup_step_four.dart';

class FinishingAccountStepFive extends StatefulWidget {
  String name;
  DateTime birthday;
  String gender;
  List<String> pictures;
  List<String> interests;
  String phoneNumber;

  FinishingAccountStepFive(
      {Key? key,
      required this.name,
      required this.birthday,
      required this.gender,
      required this.pictures,
      required this.interests,
      required this.phoneNumber})
      : super(key: key);

  @override
  _FinishingAccountStepFiveState createState() =>
      _FinishingAccountStepFiveState();
}

class _FinishingAccountStepFiveState extends State<FinishingAccountStepFive> {
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> promptControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<TextEditingController> descriptionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  int promptNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            appBar: appBar,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.w, 30.h, 15.w, 40.h),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "What would you like Daytors to know?",
                                style: TextStyle(
                                  color: AppColor.red,
                                  fontSize: 25.sp,
                                  letterSpacing: 0.3,
                                  fontFamily: 'Times',
                                  fontWeight: FontWeight.w700,
                                  wordSpacing: 0.0,
                                ),
                              ),
                              SizedBox(height: 25.h),
                              ReusableTextFieldWidget(
                                controller:
                                    promptControllers[promptNumber - 1],
                                errorMessage: "You have to enter a prompt.",
                                hintText: "Prompt $promptNumber",
                                minLines: 1,
                                maxLines: 3,
                                borderSide: BorderSide(
                                  color: Color(0xffD4D4D4),
                                  width: 1.2,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              ReusableTextFieldWidget(
                                controller:
                                    descriptionControllers[promptNumber - 1],
                                errorMessage:
                                    "You have to enter brief description.",
                                hintText: "Brief description...",
                                minLines: 8,
                                maxLines: 8,
                                borderSide: BorderSide(
                                  color: Color(0xffD4D4D4),
                                  width: 1.2,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ReusableText(
                                      text: "$promptNumber / 3",
                                      textSize: 16.sp,
                                      textColor: AppColor.red,
                                      textFontWeight: FontWeight.w800),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              ReusableText(
                                  text:
                                      "•  2 prompts are required to proceed",
                                  textSize: 11.sp,
                                  textColor: AppColor.grey,
                                  textFontWeight: FontWeight.w400),
                            ],
                          ),
                        ),
                        SizedBox(height: 50.h),
                        Center(
                          child: BlocBuilder<RegisterBloc, RegisterState>(
                            builder: (context, state) {
                              return ContinueButton(
                                onpress: () {
                                  if (promptNumber < 3) {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                  }

                                  if (promptNumber >= 3) {
                                    List<String> prompts = [];
                                    List<String> descriptions = [];
                                    for (int i = 0; i < 3; i++) {
                                      prompts.add(promptControllers[i].text);
                                      descriptions.add(
                                          descriptionControllers[i].text);
                                    }
                                    // TODO IN THE LAST SCREEN
                                    // List<ImageEntity> imagesList = [];
                                    // for (int i = 0;
                                    //     i < widget.pictures.length;
                                    //     i++) {
                                    //   imagesList.add(ImageEntity(
                                    //       image: widget.pictures[i]));
                                    // }
                                    // User newUser = User(
                                    //   name: widget.name,
                                    //   dateOfBirth: widget.birthday,
                                    //   phoneNumber: widget.phoneNumber,
                                    //   description: descriptions,
                                    //   prompts: prompts,
                                    //   images: imagesList,
                                    //   gender: widget.gender,
                                    //   interests: widget.interests,
                                    // );
                                    // context.read<RegisterBloc>().add(
                                    //     FinishingAccountEvent(user: newUser));
                                    navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                                        context,
                                        SignupStepFour(
                                          name: widget.name,
                                          birthday: widget.birthday,
                                          isBillingScreen: false,
                                          phoneNumber: widget.phoneNumber,
                                          pictures: widget.pictures,
                                          gender: widget.gender,
                                          interests: widget.interests,
                                          descriptions: descriptions,
                                          prompts: prompts,
                                        ));
                                  } else {
                                    setState(() {
                                      promptNumber++;
                                    });
                                  }
                                },
                                width: 0.63.sw,
                                height: 0.062.sh,
                                borderColor: AppColor.red,
                                textColor: AppColor.red,
                                textButton:
                                    promptNumber < 3 ? 'Add' : "Submit",
                                widget: const SizedBox(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        return state is FinishingAccountLoading
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: SizeScreen.height * 0.38),
                                    Center(
                                      child:
                                          ReusablecircularProgressIndicator(
                                        indicatorColor: AppColor.red,
                                        width: 15,
                                        height: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ReusableText(
                                      text: "Wait...",
                                      textSize: 15,
                                      textFontWeight: FontWeight.w700,
                                      textColor: AppColor.red,
                                    )
                                  ],
                                ),
                              )
                            : SizedBox();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
