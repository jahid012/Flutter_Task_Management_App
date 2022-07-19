import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color blueishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color primaryClr = blueishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    backgroundColor: Colors.white,
    primarySwatch: Colors.grey,
    appBarTheme: AppBarTheme(
      backgroundColor: blueishClr,
    ),
  );

  static final dark = ThemeData(
      colorScheme: const ColorScheme.dark(), backgroundColor: darkGreyClr);
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.grey[400] : Colors.grey));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600]));
}
