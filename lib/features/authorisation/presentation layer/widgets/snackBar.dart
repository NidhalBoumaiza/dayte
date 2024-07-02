import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackbar(
    context, duration, messageText, color) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: duration),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(13),
      backgroundColor: color,
      content: Text(
        messageText,
        style: GoogleFonts.openSans(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
