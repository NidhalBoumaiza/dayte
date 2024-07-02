import 'package:flutter/material.dart';

class profilePictureWidget extends StatelessWidget {
  late double? widthProfilePic;
  late double? heightProfilePic;
  dynamic img;

  profilePictureWidget({this.widthProfilePic, this.heightProfilePic, this.img});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: AssetImage(img), //NetworkImage("${dotenv.env['URL']}$img"),
          fit: BoxFit.cover,
          width: widthProfilePic,
          height: heightProfilePic,
        ),
      ),
    );
  }
}
