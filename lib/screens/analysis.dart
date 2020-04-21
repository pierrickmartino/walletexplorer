import 'package:walletexplorer/util/data.dart';
import 'package:walletexplorer/widgets/position.dart';
import 'package:flutter/material.dart';

class Analysis extends StatefulWidget {
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
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
            currency: asset['currency'],
            color: asset['color'],
          );
        },
      ),
    );
  }
}
