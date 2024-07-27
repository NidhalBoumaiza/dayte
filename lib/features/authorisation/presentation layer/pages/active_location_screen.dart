import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/get%20profile%20bloc/get_profile_bloc.dart';
import 'package:client/features/dates/presentation%20layer/pages/squelette_home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constant.dart';
import '../../../../../core/animation/animation_top.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../../../../core/widgets/reusable_circular_progressive_indicator.dart';
import '../../../dates/presentation layer/cubit/bottom_navigation_bar_cubit.dart';
import '../../../dates/presentation layer/widgets/sign_out_logic_widget.dart';
import '../bloc/update_coordinate_bloc/update_coordinate_bloc.dart';

class ActiveLocationScreen extends StatelessWidget {
  ActiveLocationScreen({
    Key? key,
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
                BlocConsumer<UpdateCoordinateBloc, UpdateCoordinateState>(
                    listener: (context, state) {
                  if (state is UpdateCoordinateSuccess) {
                    context.read<BottomNavigationCubit>().changePage(1);
                    context.read<GetProfileBloc>().add(GetProfile());
                    navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
                        context, SqueletteHomeScreen());
                  } else if (state is UpdateCoordinateError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }, builder: (context, state) {
                  if (state is UpdateCoordinateUnauthorized) {
                    return handleUnauthorizedAccessLogic(context);
                  } else {
                    return MyCustomButton(
                      width: double.infinity,
                      height: 50.h,
                      function: state is UpdateCoordinateLoading
                          ? () {}
                          : () {
                              context
                                  .read<UpdateCoordinateBloc>()
                                  .add(UpdateCoordinate());
                            },
                      buttonColor: AppColor.red,
                      text: 'Activer localisation',
                      circularRadious: 15.sp,
                      textButtonColor: Colors.white,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w800,
                      widget: state is UpdateCoordinateLoading
                          ? ReusablecircularProgressIndicator(
                              indicatorColor: Colors.white,
                            )
                          : null,
                    );
                  }
                }),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
