import 'package:flutter/material.dart';

import '../../util/data.dart';
import '../widgets/account.dart';

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

          return AccountUI(
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
