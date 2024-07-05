import 'dart:io';

import "package:flutter/material.dart";

Widget checkPlatform(
    {required Widget iphoneWidget, required Widget androidWidget}) {
  if (Platform.isAndroid) {
    // Code specific to Android platform
    return androidWidget;
  } else if (Platform.isIOS) {
    // Code specific to iOS platform
    return iphoneWidget;
  } else {
    return androidWidget;
  }
}
