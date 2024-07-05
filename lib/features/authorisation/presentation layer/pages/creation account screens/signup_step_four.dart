import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/widgets/snackBar.dart';
import 'package:client/features/dates/presentation%20layer/pages/squelette_home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../constant.dart';
import '../../widgets/card_of_pack.dart';
import '/testStripe/stripe_payment/payment_manager.dart';

class SignupStepFour extends StatefulWidget {
  bool isBillingScreen;

  SignupStepFour({Key? key, required this.isBillingScreen}) : super(key: key);

  @override
  State<SignupStepFour> createState() => _SignupStepFourState();
}

class _SignupStepFourState extends State<SignupStepFour> {
  @override
  bool c1 = false;
  bool c2 = false;

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    "Dayte plans",
                    style: TextStyle(
                      color: AppColor.red,
                      fontSize: 30.sp,
                      letterSpacing: 0.3,
                      fontFamily: 'Times',
                      fontWeight: FontWeight.w800,
                      wordSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(height: 27.h),
                GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   if (c2) {
                    //     c2 = false;
                    //   }
                    //   if (c1) {
                    //     c1 = false;
                    //   } else {
                    //     c1 = true;
                    //   }
                    // });
                    if (widget.isBillingScreen) {
                      handlePayment(9, SqueletteHomeScreen());
                    } else {
                      // handlePayment(9, FinishingAccountStepOne());
                    }
                  },
                  child: PriceCard(
                    packName: "Basic",
                    price: "\$9.99/mth",
                    text1: "3 x 3 grid",
                    text2: "2 possible Dayte’s monthly",
                    text3: "3 daily likes",
                    tick: c1
                        ? Icon(
                            FontAwesomeIcons.solidCircleCheck,
                            color: AppColor.red,
                          )
                        : SizedBox(),
                    borderColor: c1 ? AppColor.red : AppColor.grey,
                    borderWidth: c1 ? 2 : 1,
                  ),
                ),
                SizedBox(height: 25.h),
                GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   if (c1) {
                    //     c1 = false;
                    //   }
                    //   if (c2) {
                    //     c2 = false;
                    //   } else {
                    //     c2 = true;
                    //   }
                    // });
                    if (widget.isBillingScreen) {
                      handlePayment(14, SqueletteHomeScreen());
                    } else {
                      //  handlePayment(14, FinishingAccountStepOne());
                    }
                  },
                  child: PriceCard(
                    packName: "Premium",
                    price: "\$14.99/mth",
                    text1: "3 x 4 grid",
                    text2: "4 possible Dayte’s monthly",
                    text3: "5 daily likes",
                    tick: c2
                        ? Icon(
                            FontAwesomeIcons.solidCircleCheck,
                            color: AppColor.red,
                          )
                        : SizedBox(),
                    borderColor: c2 ? AppColor.red : AppColor.grey,
                    borderWidth: c2 ? 2 : 1,
                  ),
                ),
                SizedBox(height: 40.h),
                GestureDetector(
                  onTap: () {
                    // navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
                    //   context,
                    //   FinishingAccountStepOne(),
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ReusableText(
                        text: "Try before I pay ",
                        textSize: 14.0.sp,
                        textColor: AppColor.grey,
                        textFontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 8.h,
                        child: SvgPicture.string(littleArrow),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  Future<void> handlePayment(int amount, Widget widget) async {
    bool paymentSuccess = await PaymentManager.makePayment(amount, "USD");
    if (paymentSuccess) {
      // Navigate to the next screen
      navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
        context,
        widget,
      );
    } else {
      // Show an error message
      snackbar(context, 2, "Payment failed. Please try again.", Colors.amber);
    }
  }
}
