import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../core/services/authentication.dart';
import './pages/root_page.dart';
import './screens/accounts.dart';
import './screens/analysis.dart';
import './screens/settings.dart';
import './screens/transactions.dart';
import './views/homeView.dart';
import '../util/const.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => RootPage(auth: new Auth()));
      case homeRoute:
        var data = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => HomeView(year: data));
      case accountsRoute:
        var data = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => Accounts(year: data));
      case transactionsRoute:
        var data = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => Transactions(product: data));
      case analysisRoute:
        return MaterialPageRoute(builder: (_) => Analysis());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => Settings());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
