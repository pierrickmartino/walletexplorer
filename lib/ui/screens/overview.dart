import 'package:walletexplorer/util/data.dart';
import 'package:walletexplorer/ui/widgets/position.dart';
import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        itemCount: coins.length,
        itemBuilder: (BuildContext context, int index) {
          Map coin = coins[index];

          return Wallet(
            name: coin['name'],
            icon: coin['icon'],
            rate: coin['rate'],
            color: coin['color'],
          );
        },
      ),
    );
  }
}
