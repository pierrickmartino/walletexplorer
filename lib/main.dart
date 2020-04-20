import 'package:walletexplorer/util/const.dart';
import 'package:walletexplorer/services/authentication.dart';
import 'package:walletexplorer/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  //Not working in web environment
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
  runApp(MyApp());
  //});
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDark ? Constants.darkPrimary : Constants.lightPrimary,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme: isDark ? Constants.darkTheme : Constants.lightTheme,

        home: new RootPage(auth: new Auth()),

        );
  }
}
