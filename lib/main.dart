import 'package:provider/provider.dart';
import 'package:walletexplorer/core/viewmodels/CRUDModel.dart';
import 'package:walletexplorer/locator.dart';
import 'package:walletexplorer/ui/router.dart';
import 'package:walletexplorer/util/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  //Not working in web environment
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
  setupLocator();
  runApp(MyApp());
  //});
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = true;

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<CRUDModel>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        title: Constants.appName,
        theme: isDark ? Constants.darkTheme : Constants.lightTheme,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
