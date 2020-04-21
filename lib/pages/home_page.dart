import 'package:flutter/material.dart';

import 'package:walletexplorer/services/authentication.dart';
import 'package:walletexplorer/screens/transactions.dart';
import 'package:walletexplorer/screens/positions.dart';
import 'package:walletexplorer/screens/accounts.dart';
import 'package:walletexplorer/util/data.dart';
import 'package:walletexplorer/util/navigation_rail.dart';

import 'dart:async';
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
      hideTitleBar : true,
      actions: <Widget>[
        new FlatButton(
            child: new Text('Logout',
                style: new TextStyle(fontSize: 17.0, color: Colors.red)),
            onPressed: signOut)
      ],
      drawerHeaderBuilder: (context) {
        return Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(name),
              accountEmail: Text(name.toLowerCase().replaceAll(" ", ".") + "@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/cm${random.nextInt(10)}.jpeg",
                )
              ),
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
              leading: Icon(Icons.info_outline),
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
          Positions(),
          Accounts(),
          Transactions(),
          Positions(),
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
      ],
    );
  }
}