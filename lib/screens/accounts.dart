import 'package:walletexplorer/widgets/account.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final accountsReference = Firestore.instance
      .collection("accounts")
      .orderBy("relation", descending: false);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: accountsReference.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator();
        else {
          List accountsItems = [];
          snapshot.data.documents.forEach((document) {
            accountsItems.add({"key": document.documentID, ...document.data});
          });

          return Scaffold(
            body: ListView.builder(
              primary: false,
              itemCount: accountsItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Account(
                  name: accountsItems[index]['relation'],
                  icon: "asset_icon.png",
                  rate: accountsItems[index]['balance'],
                  currency: accountsItems[index]['currency'],
                  depositary: accountsItems[index]['bank'],
                  color: charts.MaterialPalette.blue.shadeDefault,
                );
              },
            ),
          );
        }
      },
    );
  }
}
