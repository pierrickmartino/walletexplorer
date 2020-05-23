import 'package:flutter/material.dart';

const String homeRoute = '/';
const String loginRoute = '/login';
const String accountsRoute = '/accounts';
const String transactionsRoute = '/transactions';
const String settingsRoute = '/settings';
const String analysisRoute = '/analysis';

const int nbYearForStatisticsDepth = 5;

class Constants {
  static String appName = "Wallet Explorer";

  // This file contains all the routing constants used within the app
  static const String homeRoute = '/';
  static const String accountsRoute = '/accounts';
  static const String transactionsRoute = '/transactions';
  static const String settingsRoute = '/settings';
  static const String analysisRoute = '/analysis';

  //Colors for theme
  static Color lightPrimary = Color(0xFFF9F9F9);
  static Color lightBG = Color(0xFFF9F9F9);
  static Color lightFirstColor = Colors.green[400];
  static Color lightSecondColor = Color(0xffff5182);
  static Color lightSecondary = Color(0xff3D3B8E);
  static Color lightBarColor = Color(0xffE0FF4F);
  static Color lightCardColor = Color(0x1A6883BA);
  static Color lightCardColorLight = Color(0xFF6883BA);

  static Color darkPrimary = Color(0xff001513);
  static Color darkBG = Color(0xff001513);
  static Color darkFirstColor = Color(0xff53fdd7);
  static Color darkSecondColor = Color(0xffff5182);
  static Color darkSecondary = Color(0xffF7F7FF);
  static Color darkBarColor = Color(0xffE0FF4F);
  static Color darkCardColor = Color(0x1A23B5D3);
  static Color darkCardColorLight = Color(0x3323B5D3);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Manrope',
    backgroundColor: lightBG,
    bottomAppBarColor: lightSecondColor,
    primaryColor: lightPrimary,
    accentColor: lightFirstColor,
    scaffoldBackgroundColor: lightBG,
    cursorColor: lightSecondary,
    buttonColor: lightFirstColor,
    dividerColor: lightCardColorLight,
    cardColor: lightCardColor,
    canvasColor: lightCardColorLight,
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Manrope',
    backgroundColor: darkBG,
    bottomAppBarColor: darkSecondColor,
    primaryColor: darkPrimary,
    accentColor: darkFirstColor,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkSecondary,
    buttonColor: darkFirstColor,
    canvasColor: darkPrimary,
    dividerColor: darkCardColorLight,
    cardColor: darkCardColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
  );
}
