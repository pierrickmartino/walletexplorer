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
        primary: false,
        itemCount: assets.length,
        itemBuilder: (BuildContext context, int index) {
          Map asset = assets[index];

          return Account(
            name: asset['name'],
            icon: asset['icon'],
            rate: asset['rate'],
            currency: asset['currency'],
            color: asset['color'],
          );
        },
      ),
    );
  }
}
