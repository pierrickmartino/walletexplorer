import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:walletexplorer/core/services/authentication.dart';
import 'package:walletexplorer/ui/pages/root_page.dart';
import 'package:walletexplorer/ui/screens/accounts.dart';
import 'package:walletexplorer/ui/screens/analysis.dart';
import 'package:walletexplorer/ui/screens/settings.dart';
import 'package:walletexplorer/ui/screens/transactions.dart';
import 'package:walletexplorer/ui/views/homeView.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => RootPage(auth: new Auth()));
      case '/overview':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/accounts':
        return MaterialPageRoute(builder: (_) => Accounts());
      case '/transactions':
        return MaterialPageRoute(builder: (_) => Transactions());
      case '/analysis':
        return MaterialPageRoute(builder: (_) => Analysis());
      case '/settings':
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
