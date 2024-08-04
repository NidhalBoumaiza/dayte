import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constant.dart';
import '../../../../../core/utils/navigation_with_transition.dart';
import '../../../../authorisation/domain layer/entities/user_entity.dart';
import '../../../../authorisation/presentation layer/widgets/continueButton.dart';
import '../../../../authorisation/presentation layer/widgets/snackBar.dart';
import '../../bloc/date bloc/date_bloc.dart';
import '../../widgets/home_profile_widget.dart';
import '../../widgets/shimmer_loading_petals.dart';
import '../../widgets/sign_out_logic_widget.dart';
import '../profile_details_screen.dart';

class PetalsScreen extends StatelessWidget {
  const PetalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 10.0.h, left: 15.w, right: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Petals",
              style: TextStyle(
                color: AppColor.red,
                fontSize: 35.sp,
                letterSpacing: 0.3,
                fontFamily: 'Times',
                fontWeight: FontWeight.w700,
                wordSpacing: 0.0,
              ),
            ),
            ReusableText(
              text: "Select 3 profiles",
              textSize: 11.sp,
              textColor: Color(0xff717171),
            ),
            SvgPicture.string(today),
            SizedBox(height: 10.h),
            BlocConsumer<DateBloc, DateState>(
              listener: (context, state) {
                if (state is GetRecommendationError) {
                  snackbar(context, 2, state.message, AppColor.red);
                } else if (state is EndOfPlanErreur) {
                  snackbar(context, 2, state.message, AppColor.red);
                } else if (state is ShuffleErreur) {
                  snackbar(context, 2, state.message, AppColor.red);
                }
              },
              builder: (context, state) {
                // Retrieve the last successful state
                final lastSuccessState = context.read<DateBloc>().state;
                List<User>? recommendations;

                if (lastSuccessState is GetRecommendationSuccess) {
                  recommendations = lastSuccessState.recommendations;
                }

                if (state is GetRecommendationUnauthorized) {
                  return handleUnauthorizedAccessLogic(context);
                } else if (state is GetRecommendationLoading) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:
                          SizeScreen.height * 0.1 / SizeScreen.width * 3,
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: listSuggestions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ShimmerLoadingPetals();
                    },
                  );
                } else if (state is GetRecommendationSuccess) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:
                          SizeScreen.height * 0.1 / SizeScreen.width * 3,
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: state.recommendations.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                            context,
                            ProfileDetailScreen(
                                profile: recommendations![index]),
                          );
                        },
                        child: ProfileWidget(
                          name: recommendations![index].name!.split(" ")[0],
                          image: recommendations[index].images![0].image!,
                          //"images/${index + 1}.png",
                          age: recommendations[index].age.toString(),
                        ),
                      );
                    },
                  );
                } else if (state is EndOfPlanErreur) {
                  return Column(
                    children: [
                      SizedBox(
                        height: SizeScreen.height * 0.09,
                      ),
                      Image.asset("images/Payment.png"),
                      ReusableText(
                        text: "You have to renew your plan.",
                        textSize: 15.sp,
                        textColor: AppColor.red,
                        textFontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: SizeScreen.height * 0.12,
                      ),
                    ],
                  );
                } else if (state is ShuffleErreur) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:
                          SizeScreen.height * 0.1 / SizeScreen.width * 3,
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: recommendationsForShuffleErreur.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                            context,
                            ProfileDetailScreen(
                                profile:
                                    recommendationsForShuffleErreur![index]),
                          );
                        },
                        child: ProfileWidget(
                          name: recommendationsForShuffleErreur![index]
                              .name!
                              .split(" ")[0],
                          image: recommendationsForShuffleErreur[index]
                              .images![0]
                              .image!,
                          //"images/${index + 1}.png",
                          age: recommendationsForShuffleErreur[index]
                              .age
                              .toString(),
                        ),
                      );
                    },
                  );
                } else {
                  return SizedBox();
                }
                return SizedBox();
              },
            ),
            const SizedBox(height: 10),
            Center(
              child: ContinueButton(
                onpress: () {
                  context
                      .read<DateBloc>()
                      .add(GetRecommendationEvent(isShuffle: true));
                },
                width: 110.w,
                height: SizeScreen.height * 0.04,
                borderColor: AppColor.red,
                textColor: AppColor.red,
                textButton: 'Shuffle',
                textSize: 13,
                widget: SvgPicture.string(shuffle),
              ),
            )
          ],
        ),
      ),
    );
  }
}
