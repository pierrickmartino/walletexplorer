import 'package:flutter/material.dart';

class Constants {
  static String appName = "Wallet Explorer";

  //Colors for theme
  static Color lightPrimary = Color(0xffff5182);
  static Color lightSecondary = Color(0xfffcb1a6);
  static Color lightBG = Color(0xfff9f9fc);

  static Color mainFirstColor = Color(0xff53fdd7);
  static Color mainSecondColor = Color(0xffff5182);

  static Color darkPrimary = Color(0xff001513);
  static Color darkBG = Color(0xff001513);
  static Color darkSecondary = Color(0xffF7F7FF);
  static Color darkBarColor = Color(0xffE0FF4F);
  static Color darkCardColor = Color(0x1A23B5D3);
  static Color darkCardColorLight = Color(0x6623B5D3);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Manrope',
    backgroundColor: lightBG,
    bottomAppBarColor: mainSecondColor,
    primaryColor: lightPrimary,
    accentColor: mainFirstColor,
    scaffoldBackgroundColor: lightBG,
    cursorColor: lightSecondary,
    buttonColor: mainFirstColor,
    dividerColor: darkCardColorLight,
    cardColor: darkCardColor,
    canvasColor: darkCardColorLight,
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Manrope',
    backgroundColor: darkBG,
    bottomAppBarColor: mainSecondColor,
    primaryColor: darkPrimary,
    accentColor: mainFirstColor,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkSecondary,
    buttonColor: mainFirstColor,
    canvasColor: darkPrimary,
    dividerColor: darkCardColorLight,
    cardColor: darkCardColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
  );
}
