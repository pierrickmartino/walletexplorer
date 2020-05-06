import 'package:flutter/material.dart';
import 'dart:math';

import '../screens/analysis.dart';
import '../screens/transactions.dart';
import '../screens/overview.dart';
import '../screens/settings.dart';
import '../screens/accounts.dart';
import '../../util/data.dart';
import '../../util/navigation_rail.dart';
import '../../core/services/authentication.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  static Random random = Random();
  String name = names[random.nextInt(10)];
  AssetImage userAccountPicture = AssetImage(
    "assets/cm${random.nextInt(10)}.jpeg",
  );

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavRail(
      hideTitleBar: true,
      //bottomNavigationBarColor: Theme.of(context).dividerColor,
      drawerHeaderBuilder: (context) {
        return Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(name),
              accountEmail:
                  Text(name.toLowerCase().replaceAll(" ", ".") + "@gmail.com"),
              currentAccountPicture:
                  CircleAvatar(backgroundImage: userAccountPicture),
            ),
          ],
        );
      },
      currentIndex: _currentIndex,
      onTap: (val) {
        if (mounted)
          setState(() {
            _currentIndex = val;
          });
      },
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Overview(),
          Accounts(),
          Transactions(),
          Analysis(),
          Settings(),
        ],
      ),
      tabs: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text("Overview"),
          icon: Icon(Icons.pie_chart),
        ),
        BottomNavigationBarItem(
          title: Text("Accounts"),
          icon: Icon(Icons.account_balance_wallet),
        ),
        BottomNavigationBarItem(
          title: Text("Transactions"),
          icon: Icon(Icons.history),
        ),
        BottomNavigationBarItem(
          title: Text("Analysis"),
          icon: Icon(Icons.multiline_chart),
        ),
        BottomNavigationBarItem(
          title: Text("Settings"),
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}
