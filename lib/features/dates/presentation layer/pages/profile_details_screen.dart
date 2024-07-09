import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constant.dart';
import '../../../../core/colors.dart';
import '../../../../core/utils/navigation_with_transition.dart';
import '../../../../core/widgets/reusable_circular_progressive_indicator.dart';
import '../../../authorisation/domain layer/entities/user_entity.dart';
import '../../../authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import '../../../authorisation/presentation layer/pages/signin_screen.dart';
import '../bloc/like recommendation cubit/like_recommendation__cubit.dart';
import '../widgets/interest_widget.dart';
import '../widgets/profile_image_text.dart';

class ProfileDetailScreen extends StatelessWidget {
  final User profile;

  const ProfileDetailScreen({Key? key, required this.profile})
      : super(key: key);

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
            floatingActionButton: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 17.0.h, left: 23.w),
                child: FloatingActionButton(
                  highlightElevation: 0,
                  hoverColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverElevation: 0,
                  focusColor: Colors.transparent,
                  focusElevation: 0,
                  disabledElevation: 0,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.string(arrowBack),
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: SizeScreen.height * 0.635,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "${dotenv.env['URLIMAGE']}${profile.images![0].image!}"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: SizeScreen.height * 0.59,
                        child: Container(
                          width: SizeScreen.width,
                          height: 50.h,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 23.w,
                        top: SizeScreen.height * 0.56,
                        child: BlocConsumer<LikeRecommendationCubit,
                            LikeRecommendationState>(
                          listener: (context, state) {
                            if (state is LikeRecommendationError) {
                              snackbar(context, 1, state.message, AppColor.red);
                            } else if (state is LikeRecommendationSuccess) {
                              snackbar(context, 1, "YAAAAY", Colors.green);
                            }
                          },
                          builder: (context, state) {
                            if (state is LikeRecommendationUnauthorized) {
                              BlocProvider.of<SignOutBloc>(context)
                                  .add(SignOutMyAccountEventPressed());
                              return BlocConsumer<SignOutBloc, SignOutState>(
                                  builder: (context, state) {
                                if (state is SignOutLoading) {
                                  return ReusablecircularProgressIndicator(
                                    height: 20.h,
                                    width: 20.w,
                                    indicatorColor: primaryColor,
                                  );
                                } else {
                                  return const Text("errrorororororor");
                                }
                              }, listener: (context, state) {
                                if (state is SignOutSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Votre session a expiré , veuillez vous reconnecter"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
                                    context,
                                    SignInScreen(),
                                  );
                                } else if (state is SignOutError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              });
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  print(profile.id);
                                  // Handle like action
                                  context
                                      .read<LikeRecommendationCubit>()
                                      .likeRecommendationUseCase(profile.id!);
                                },
                                // onTap: profile.liked == false
                                //     ? () {
                                //   // Handle like action
                                // }
                                //     : null,
                                child: Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color:
                                        // profile.liked == false
                                        //     ? const Color(0xffAB3333)  Colors.grey.withOpacity(0.9)
                                        //  :
                                        const Color(0xffAB3333),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.white,
                                    size: 33.sp,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10.0.w, right: 10.w, bottom: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: "${profile.name}, ${profile.age}",
                          textSize: 20.sp,
                          textColor: AppColor.black,
                          textFontWeight: FontWeight.w800,
                        ),
                        SizedBox(height: 3.h),
                        ReusableText(
                          text: "${profile.gender}",
                          textSize: 10.sp,
                          textColor: AppColor.grey,
                          textFontWeight: FontWeight.w300,
                        ),
                        SizedBox(height: 3.h),
                        ReusableText(
                          text: "Interests",
                          textSize: 16.sp,
                          textColor: AppColor.grey,
                          textFontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 3.h),
                        Container(
                          height: 38.h,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: profile.interests!.length,
                            itemBuilder: (BuildContext context, int i) {
                              return InterestWidget(
                                icon: FontAwesomeIcons.book,
                                interest: profile.interests![i],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: profile.images!.length - 1,
                          itemBuilder: (BuildContext context, int index) {
                            return ProfileImageText(
                              description: index < profile.prompts!.length
                                  ? profile.prompts![index]
                                  : null,
                              prompt: index < profile.prompts!.length
                                  ? profile.prompts![index]
                                  : null,
                              img: profile.images![index + 1].image!,
                            );
                          },
                        ),
                        SizedBox(height: 18.h),
                        Center(
                          child: ReusableText(
                            text: "${profile.name!.split(" ")[0]}'s profile",
                            textSize: 14.sp,
                            textColor: AppColor.black,
                            textFontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
