import 'dart:math';

import 'package:flutter/material.dart';
import 'package:walletexplorer/util/data.dart';

class Header extends StatefulWidget {
  @override
  _Header createState() => _Header();
}

class _Header extends State<Header> {
  static Random random = Random();
  String name = names[random.nextInt(10)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(
            "assets/cm${random.nextInt(10)}.jpeg",
          ),
          radius: 25,
        ),
        title: Text(name),
        subtitle: Text(name.toLowerCase().replaceAll(" ", ".") + "@gmail.com"),
        isThreeLine: true,
      ),
    );
  }
}
