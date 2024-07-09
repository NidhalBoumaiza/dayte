import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/widgets/snackBar.dart';
import 'package:client/features/dates/presentation%20layer/cubit/bottom_navigation_bar_cubit.dart';
import 'package:client/features/dates/presentation%20layer/pages/squelette_home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constant.dart';
import '../../../../../core/animation/animation_top.dart';
import '../../../../../core/function_get_location.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../../../../core/widgets/reusable_circular_progressive_indicator.dart';
import '../../../domain layer/entities/image_entity.dart';
import '../../../domain layer/entities/user_entity.dart';
import '../../bloc/get profile bloc/get_profile_bloc.dart';
import '../../bloc/register bloc/register_bloc.dart';

class SignupStepThree extends StatelessWidget {
  bool isFinishingAccount;

  String? name;
  DateTime? birthday;
  String? gender;
  List<String>? pictures;
  List<String>? interests;
  String? phoneNumber;

  List<String>? prompts;
  List<String>? descriptions;
  String? plan;

  SignupStepThree({
    Key? key,
    required this.isFinishingAccount,
    this.pictures,
    this.phoneNumber,
    this.gender,
    this.birthday,
    this.name,
    this.descriptions,
    this.interests,
    this.prompts,
    this.plan,
  }) : super(key: key);

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
            padding: EdgeInsets.fromLTRB(20.0.w, 0, 20.0.w, 30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: AnimationTop(
                              child: SvgPicture.string(positionImage))),
                      SizedBox(height: 25.h),
                      ReusableText(
                        text: "Enable Location",
                        textSize: 18.sp,
                        textColor: Color(0xff2B2627),
                        textFontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 15.h),
                      ReusableText(
                        text:
                            "Allow Dayte to access your location? You must allow access for Dayte to work. We will only track your location while on duty.",
                        textSize: 12.sp,
                        textColor: Color(0xff2B2627),
                        textFontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 100.h)
                    ],
                  ),
                ),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is FinishingAccountFailure) {
                      snackbar(context, 2, state.message, AppColor.red);
                    } else if (state is FinishingAccountSuccess) {
                      context.read<BottomNavigationCubit>().changePage(1);
                      navigateToAnotherScreenWithSlideTransitionFromBottomToTopPushReplacement(
                          context, SqueletteHomeScreen());
                      context.read<GetProfileBloc>().add(GetProfile());
                    }
                  },
                  builder: (context, state) {
                    return MyCustomButton(
                      width: double.infinity,
                      height: 45.h,
                      function: state is FinishingAccountLoading
                          ? () {}
                          : () async {
                              dynamic coordinate = await getCurrentLocation();
                              Location location = Location(
                                  [coordinate.longitude, coordinate.latitude]);
                              List<ImageEntity> imagesList = [];
                              for (int i = 0; i < pictures!.length; i++) {
                                imagesList
                                    .add(ImageEntity(image: pictures![i]));
                              }
                              User newUser = User(
                                name: name,
                                dateOfBirth: birthday,
                                phoneNumber: phoneNumber,
                                description: descriptions,
                                prompts: prompts,
                                images: imagesList,
                                gender: gender,
                                interests: interests,
                                plan: plan,
                                location: location,
                              );
                              context
                                  .read<RegisterBloc>()
                                  .add(FinishingAccountEvent(user: newUser));
                            },
                      buttonColor: AppColor.red,
                      text: "Next",
                      fontWeight: FontWeight.w700,
                      widget: state is FinishingAccountLoading
                          ? ReusablecircularProgressIndicator(
                              indicatorColor: Colors.white,
                              height: 15,
                              width: 15,
                            )
                          : SizedBox(),
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
