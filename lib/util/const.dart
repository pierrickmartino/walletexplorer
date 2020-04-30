import 'package:flutter/material.dart';

class Constants {
  static String appName = "Wallet Explorer";

  //Colors for theme
  static Color lightPrimary = Color(0xffB39C4D);
  static Color lightSecondary = Color(0xfffcb1a6);
  static Color lightAccent = Color(0xffB39C4D);
  static Color lightBG = Color(0xfff9f9fc);

  static Color darkPrimary = Color(0xff001513);
  static Color darkBG = Color(0xff001513);
  static Color darkSecondary = Color(0xffF7F7FF);
  static Color darkAccent = Color(0xff53fdd7); // 0xff23B5D3
  static Color darkBarColor = Color(0xffE0FF4F);
  static Color darkUnusedColor = Color(0xffff5182); // 0xffEA526F
  static Color darkCardColor = Color(0x1A23B5D3);
  static Color darkCardColorLight = Color(0x6623B5D3);

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Manrope',
    backgroundColor: lightBG,
    bottomAppBarColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    buttonColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Manrope',
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkSecondary,
    buttonColor: darkAccent,
    canvasColor: darkPrimary,
    dividerColor: darkCardColorLight,
    cardColor: darkCardColor,
    bottomAppBarColor: darkUnusedColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
  );
}
