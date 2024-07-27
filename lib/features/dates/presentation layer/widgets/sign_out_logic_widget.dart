import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/utils/navigation_with_transition.dart';
import '../../../../core/widgets/reusable_circular_progressive_indicator.dart';
import '../../../authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import '../../../authorisation/presentation layer/pages/signin_screen.dart';

// Make sure to import all necessary files

Widget handleUnauthorizedAccessLogic(BuildContext context) {
  BlocProvider.of<SignOutBloc>(context).add(SignOutMyAccountEventPressed());
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
    },
    listener: (context, state) {
      if (state is SignOutSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Votre session a expiré , veuillez vous reconnecter"),
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
    },
  );
}
