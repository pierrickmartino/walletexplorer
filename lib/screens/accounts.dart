import 'package:walletexplorer/util/data.dart';
import 'package:walletexplorer/widgets/account.dart';
import 'package:flutter/material.dart';



class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        itemCount: coins.length,
        itemBuilder: (BuildContext context, int index) {
          Map coin = coins[index];

          return Account(
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

