import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
          image: NetworkImage("${dotenv.env['URLIMAGE']}$img"),
          // AssetImage(img), //NetworkImage("${dotenv.env['URL']}$img"),
          fit: BoxFit.cover,
          width: widthProfilePic,
          height: heightProfilePic,
        ),
      ),
    );
  }
}
