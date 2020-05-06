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
  //bool isDark = true;

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
        // ThemeThemeData(
        //       brightness: brightness,
        //       brightness ? Constants.darkTheme : Constants.lightTheme,
        //       //rest of the themeData
        //you can also use conditioning here based on the current
        //brightness mode (dark or light). For ex:
        // primarySwatch: brightness == Brighness.dark ? Colors.white : Colors.black
        //    ),
        themedWidgetBuilder: (context, theme) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => locator<CRUDModel>()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/login',
              title: Constants.appName,
              // themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
              // darkTheme: Constants.darkTheme,
              theme: theme,
              // Constants
              //     .lightTheme, //isDark ? Constants.darkTheme : Constants.lightTheme,
              onGenerateRoute: Router.generateRoute,
            ),
          );
        });
  }
}
