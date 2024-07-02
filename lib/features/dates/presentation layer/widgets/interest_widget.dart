import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constant.dart';
import '../../../../core/widgets/reusable_text.dart';

class InterestWidget extends StatelessWidget {
  IconData icon;

  String interest;

  InterestWidget({super.key, required this.icon, required this.interest});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      width: SizeScreen.width * 0.33,
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(color: Color(0xffF5DDE4), width: 1.0), // Top border
        bottom:
            BorderSide(color: Color(0xffF5DDE4), width: 1.0), // Bottom border
        right: BorderSide(color: Color(0xffF5DDE4), width: 1.0), // Left border
        // No border on the right side
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(icon,
          //    color: AppColor.red , size: 20,),
          Image.asset('${interestImage(interest)}'),
          SizedBox(width: 4.w),
          ReusableText(
            text: interest,
            textSize: 10.sp,
            textColor: AppColor.grey,
            textFontWeight: FontWeight.w900,
          ),
        ],
      ),
    );
  }
}

String interestImage(interest) {
  String image = '';
  switch (interest) {
    case 'music':
      image = 'images/music.png';
      break;
    case 'sports':
      image = 'images/sport.png';
      break;
    case 'travelling' || 'Travelling' || "traveling" || "Traveling":
      image = 'images/travel.png';
      break;
    case 'Food':
      image = 'images/food.png';
      break;
    case 'modeling':
      image = 'images/model.png';
      break;
    case 'Art':
      image = 'images/art.png';
      break;
    case 'dancing':
      image = 'images/dancin.png';
      break;
    case 'photography':
      image = 'images/photography.png';
      break;
    case 'books':
      image = 'images/books.png';
      break;
    case 'reading' || 'Reading':
      image = 'images/books.png';
      break;
    case 'baking':
      image = 'images/baking.png';
      break;
    case 'painting':
      image = 'images/painting.png';
      break;
    case 'cooking':
      image = 'images/baking.png';
      break;
    case 'gym':
      image = 'images/sport.png';
      break;
    case 'animals':
      image = 'images/animal.png';
      break;
    case 'shopping':
      image = 'images/shopping.png';
      break;
    case 'writing':
      image = 'images/writing.png';
      break;
    case 'Animals':
      image = 'images/animals.png';
      break;
    case 'drawing':
      image = 'images/drawing.png';
      break;
    case 'Cars':
      image = 'images/cars';
      break;
    default:
      image = 'images/model.png';
  }
  return image;
}
