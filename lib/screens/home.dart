import 'dart:math';

import 'package:walletexplorer/screens/transactions.dart';
import 'package:walletexplorer/screens/positions.dart';
import 'package:walletexplorer/screens/wallets.dart';
import 'package:walletexplorer/util/data.dart';
import 'package:walletexplorer/util/navigation_rail.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  static Random random = Random();
  String name = names[random.nextInt(10)];
  @override
  Widget build(BuildContext context) {
    return NavRail(
      hideTitleBar : true,
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
          Wallets(),
          Positions(),
          Transactions(),
        ],
      ),
      tabs: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text("Wallets"),
          icon: Icon(Icons.account_balance_wallet),
        ),
        BottomNavigationBarItem(
          title: Text("Positions"),
          icon: Icon(Icons.history),
        ),
        BottomNavigationBarItem(
          title: Text("Transactions"),
          icon: Icon(Icons.photo_library),
        ),
      ],
    );
  }
}
