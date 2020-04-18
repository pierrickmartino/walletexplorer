import 'package:walletexplorer/screens/home.dart';
import 'package:walletexplorer/util/const.dart';
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme: isDark ? Constants.darkTheme : Constants.lightTheme,

        //project in progress
        home: Home(),

        // home: Scaffold(
        //   resizeToAvoidBottomPadding: true,
        //   body: new Builder(
        //       builder: (context) => new Container(
        //             decoration: BoxDecoration(
        //                 gradient: LinearGradient(
        //                     begin: Alignment.topCenter,
        //                     end: Alignment.bottomCenter,
        //                     colors: [
        //                   Theme.of(context).primaryColor,
        //                   Theme.of(context).primaryColorLight
        //                 ])),
        //             child: Padding(
        //               padding: EdgeInsets.only(top: 40.0),
        //               //Sets the main padding all widgets has to adhere to.
        //               child: LogInPage(),
        //             ),
        //           )),
        // )
        );
  }

}

// class LogInPage extends StatefulWidget {
//   LogInPage({Key key}) : super(key: key);

  // @protected
  // @override
  // State<StatefulWidget> createState() => _LogInPageState();
//}