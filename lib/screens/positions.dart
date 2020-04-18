import 'package:walletexplorer/util/data.dart';
import 'package:walletexplorer/widgets/position.dart';
import 'package:flutter/material.dart';



class Positions extends StatefulWidget {
  @override
  _PositionsState createState() => _PositionsState();
}

class _PositionsState extends State<Positions> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        itemCount: assets.length,
        itemBuilder: (BuildContext context, int index) {
          Map asset = assets[index];

          return Wallet(
            name: asset['name'],
            icon: asset['icon'],
            rate: asset['rate'],
            color: asset['color'],
          );
        },
      ),
    );
  }
}

