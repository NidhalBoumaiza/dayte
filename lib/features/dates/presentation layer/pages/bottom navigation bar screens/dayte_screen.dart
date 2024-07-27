import 'dart:ui';

import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_circular_progressive_indicator.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/widgets/snackBar.dart';
import 'package:client/features/dates/presentation%20layer/cubit/cancel_date_cubit/cancel_date_cubit.dart';
import 'package:client/features/dates/presentation%20layer/pages/availability%20screen/availability_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../constant.dart';
import '../../../../authorisation/presentation layer/widgets/gender_select.dart';
import '../../cubit/get matches cubit/get_matches_cubit.dart';
import '../../widgets/dayte_card_widget.dart';
import '../../widgets/sign_out_logic_widget.dart';

class DayteScreen extends StatefulWidget {
  const DayteScreen({Key? key}) : super(key: key);

  @override
  State<DayteScreen> createState() => _DayteScreenState();
}

class _DayteScreenState extends State<DayteScreen> {
  @override
  void initState() {
    context.read<GetMatchesCubit>().getMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<CancelDateCubit, CancelDateState>(
        listener: (context, state) {
          if (state is CancelDateSuccess) {
            context.read<GetMatchesCubit>().getMatches();
          } else if (state is CancelDateErreur) {
            snackbar(context, 2, state.message, AppColor.red);
          } else if (state is CancelDateNetworkErreur) {
            snackbar(context, 2, state.message, AppColor.red);
          }
        },
        builder: (context, state) {
          if (state is CancelDateUnauthorised) {
            return handleUnauthorizedAccessLogic(context);
          } else {
            return Padding(
              padding: EdgeInsets.fromLTRB(2.w, 7.h, 2.w, 27.h),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h),
                      Center(
                        child: Text(
                          "Daytes",
                          style: TextStyle(
                            color: AppColor.red,
                            fontSize: 35.sp,
                            letterSpacing: 0.3,
                            fontFamily: 'Times',
                            fontWeight: FontWeight.w700,
                            wordSpacing: 0.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.h),
                        child: BlocBuilder<GetMatchesCubit, GetMatchesState>(
                          builder: (context, state) {
                            if (state is GetMatchesUnauthorized) {
                              return handleUnauthorizedAccessLogic(context);
                            } else if (state is GetMatchesLoading) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 3,
                                itemBuilder: (BuildContext context, int index) {
                                  return ShimmerLoadingDaytes();
                                },
                              );
                            } else if (state is GetMatchesErreur) {
                              return Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 100.h),
                                  Image.asset("images/3d.png"),
                                  SizedBox(height: 20.h),
                                  ReusableText(
                                    text: state.message,
                                    textSize: 18.sp,
                                    textColor: AppColor.red,
                                    textFontWeight: FontWeight.w800,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ));
                            } else if (state is GetMatchesSucess) {
                              if (state.matches.isEmpty) {
                                return Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 100.h),
                                    Image.asset("images/3d.png"),
                                    SizedBox(height: 20.h),
                                    ReusableText(
                                      text: "No daytes yet",
                                      textSize: 18.sp,
                                      textColor: AppColor.red,
                                      textFontWeight: FontWeight.w800,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ));
                              } else {
                                return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.matches.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final dayte = state.matches[index];
                                    print(state
                                        .matches[index].finalDate.runtimeType);
                                    dynamic location = state
                                        .matches[index].location
                                        ?.split(', ')
                                        .map((s) => s.trim())
                                        .toList();

                                    return index == 0
                                        ? GestureDetector(
                                            onTap: state.matches[0].finalDate ==
                                                    null
                                                ? () {
                                                    navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                                                        context,
                                                        AvailabilityScreen(
                                                            id: state.matches[0]
                                                                .id!));
                                                  }
                                                : () {},
                                            child: DayteCard(
                                              image: state
                                                  .matches[index]
                                                  .likingUser!
                                                  .images![0]
                                                  .image!,
                                              onPress: () => cancelDayte(
                                                  context,
                                                  state.matches[index].id!),
                                              date: state.matches[index]
                                                          .finalDate !=
                                                      null
                                                  ? DateFormat('dd/MM/yyyy')
                                                      .format(state
                                                          .matches[index]
                                                          .finalDate!)
                                                  : "",
                                              time: state.matches[index]
                                                          .finalDate !=
                                                      null
                                                  ? DateFormat('hh:mm a')
                                                      .format(state
                                                          .matches[index]
                                                          .finalDate!)
                                                  : "No date yet",
                                              placeName: location?[0],
                                              stateName: location?[2],
                                              countryName: location?[3],
                                            ),
                                          )
                                        : ImageFiltered(
                                            imageFilter: ImageFilter.blur(
                                              tileMode: TileMode.decal,
                                              sigmaX: 3.5,
                                              sigmaY: 3.5,
                                            ),
                                            child: DayteCard(
                                              image: state
                                                  .matches[index]
                                                  .likingUser!
                                                  .images![0]
                                                  .image!,
                                              onPress: () {},
                                              date: state.matches[index]
                                                          .finalDate !=
                                                      null
                                                  ? DateFormat('dd/MM/yyyy')
                                                      .format(state
                                                          .matches[index]
                                                          .finalDate!)
                                                  : "",
                                              time: state.matches[index]
                                                          .finalDate !=
                                                      null
                                                  ? DateFormat('hh:mm a')
                                                      .format(state
                                                          .matches[index]
                                                          .finalDate!)
                                                  : "No date yet",
                                              placeName: location?[0],
                                              stateName: location?[2],
                                              countryName: location?[3],
                                            ),
                                          );
                                  },
                                );
                              }
                            } else {
                              return Text(
                                  "Something Very bad happened try again .");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  if (state is CancelDateLoading)
                    Column(
                      children: [
                        SizedBox(height: SizeScreen.height * 0.5),
                        Center(
                          child: ReusablecircularProgressIndicator(
                            height: 20,
                            width: 20,
                            indicatorColor: AppColor.red,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// Keep the cancelDayte and ShimmerLoadingDaytes as they are

void cancelDayte(context, dateId) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      // Drawer from the bottom
      return Container(
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: SizeScreen.height * 0.41,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: SizeScreen.width * 0.8,
                  child: ReusableText(
                    text: "Are you sure you want to cancel the dayte ?",
                    textSize: 18.sp,
                    textColor: AppColor.red,
                    textFontWeight: FontWeight.w800,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<CancelDateCubit>().cancelDate(dateId);
                      Get.back();
                    },
                    child: GenderSelect(
                      horizontalPadding: 20,
                      textSize: 13,
                      function: () {},
                      borderColor: const Color(0xffe9e7e7),
                      // AppColor.red,
                      checked: const SizedBox(),
                      // SvgPicture.string(doubleCheck)
                      textGender: 'Yes',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO LATER
                      Get.back();
                    },
                    child: GenderSelect(
                      horizontalPadding: 20,
                      textSize: 13,
                      function: () {},
                      borderColor: const Color(0xffe9e7e7),
                      // AppColor.red,
                      checked: const SizedBox(),
                      // SvgPicture.string(doubleCheck)
                      textGender: 'Not sure yet',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO LATER
                      Get.back();
                    },
                    child: GenderSelect(
                      horizontalPadding: 20,
                      textSize: 13,
                      function: () {},
                      borderColor: const Color(0xffe9e7e7),
                      // AppColor.red,
                      checked: const SizedBox(),
                      // SvgPicture.string(doubleCheck)
                      textGender: 'No',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.grey,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        // TextWidget
                        text: "• You will be flagged",
                        textSize: 13.sp,
                        textColor: AppColor.grey,
                        textFontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 13.h),
                      ReusableText(
                        // TextWidget
                        text: "• We encourage you to date without fear",
                        textSize: 13.sp,
                        textColor: AppColor.grey,
                        textFontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 13.h),
                      ReusableText(
                        text: "• Safety is enforced, strictly",
                        textSize: 13.sp,
                        textColor: AppColor.grey,
                        textFontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class ShimmerLoadingDaytes extends StatelessWidget {
  const ShimmerLoadingDaytes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[350]!, // Darker gray for base color
        highlightColor: Colors.grey[200]!, // Lighter gray for highlight color
        child: Container(
          width: double.infinity,
          height: 165,
          constraints: const BoxConstraints(
            maxWidth: double.infinity,
            minWidth: double.infinity,
            maxHeight: 190,
            minHeight: 165,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), // Increased border radius
            border: Border.all(color: Colors.grey, width: 2.5),
            gradient: LinearGradient(
              colors: [Colors.grey[300]!, Colors.grey[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
