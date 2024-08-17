import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constant.dart';

class ProfileWidget extends StatelessWidget {
  double? height, width, borderRadious;
  String image;
  String? age, name;
  Color? borderColor;

  ProfileWidget({
    Key? key,
    this.name,
    required this.image,
    this.age,
    this.borderColor,
    this.height,
    this.width,
    this.borderRadious,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadious ?? 3),
        border: Border.all(
          color: borderColor ?? Color(0xff398416),
          width: 2.8,
        ),
        image: DecorationImage(
          image: NetworkImage("$image"),
          // AssetImage(image), //AssetImage(image),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 3.0, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            name != null
                ? Text(
                    "$name, $age",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
