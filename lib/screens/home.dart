import 'dart:math';

import 'package:walletexplorer/screens/buyandsell.dart';
import 'package:walletexplorer/screens/transactions.dart';
import 'package:walletexplorer/screens/positions.dart';
import 'package:walletexplorer/screens/wallets.dart';
import 'package:walletexplorer/screens/header.dart';
import 'package:walletexplorer/util/data.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static Random random = Random();
  String name = names[random.nextInt(10)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          SizedBox(
            height: 70.0,
            child: Header(),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: DefaultTabController(
              length: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TabBar(
                    isScrollable: false,
                    labelColor: Theme.of(context).accentColor,
                    unselectedLabelColor:
                        Theme.of(context).textTheme.caption.color,
                    tabs: <Widget>[
                      Tab(
                        text: "Wallets",
                      ),
                      Tab(
                        text: "Positions",
                      ),
                      Tab(
                        text: "Transactions",
                      ),
                      Tab(
                        text: "Buy/Sell",
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height * 2,
                    child: TabBarView(
                      children: <Widget>[
                        Wallets(),
                        Positions(),
                        Transactions(),
                        BuyandSell(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
