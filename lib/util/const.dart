import 'package:flutter/material.dart';
class Constants{

  static String appName = "Wallet Explorer";

  //Colors for theme
  static Color lightPrimary = Color(0xffB39C4D);
  static Color lightSecondary = Color(0xfffcb1a6);
  static Color lightAccent = Color(0xffB39C4D);
  static Color lightBG = Color(0xfff9f9fc);
  
  static Color darkPrimary = Color(0xff001817);
  static Color darkSecondary = Color(0xffE7ECEF);
  static Color darkAccent = Color(0xff768948);
  static Color darkBG = Color(0xff001817);
  static Color darkBarColor = Color(0xff34623F);
  static Color darkUnusedColor = Color(0xffb39c4d);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    bottomAppBarColor: lightBG,
    primaryColor: lightPrimary,
    accentColor:  lightAccent,
    cursorColor: lightAccent,
    buttonColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkSecondary,
    buttonColor: darkAccent,
    canvasColor: darkPrimary,
    dividerColor: darkPrimary,
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
  );


}