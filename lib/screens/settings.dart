import 'package:walletexplorer/util/data.dart';
import 'package:walletexplorer/widgets/account.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
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
