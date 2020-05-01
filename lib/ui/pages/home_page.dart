import 'package:flutter/material.dart';
import 'package:walletexplorer/ui/screens/analysis.dart';

import 'package:walletexplorer/core/services/authentication.dart';
import 'package:walletexplorer/ui/screens/transactions.dart';
import 'package:walletexplorer/ui/screens/overview.dart';
import 'package:walletexplorer/ui/screens/settings.dart';
import 'package:walletexplorer/ui/screens/accounts.dart';
import 'package:walletexplorer/util/data.dart';
import 'package:walletexplorer/util/navigation_rail.dart';

import 'dart:math';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      drawerFooterBuilder: (context) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("About"),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              onTap: signOut,
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
