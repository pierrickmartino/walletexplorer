import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import './core/viewmodels/CRUDModel.dart';
import './locator.dart';
import './ui/router.dart';
import './util/const.dart';

void main() async {
  //Not working in web environment
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: isDark ? Constants.darkPrimary : Constants.lightPrimary,
    //   statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => brightness == Brightness.dark
            ? Constants.darkTheme
            : Constants.lightTheme,
        themedWidgetBuilder: (context, theme) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => locator<CRUDModel>()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/login',
              title: Constants.appName,
              theme: theme,
              onGenerateRoute: Router.generateRoute,
            ),
          );
        });
  }
}
