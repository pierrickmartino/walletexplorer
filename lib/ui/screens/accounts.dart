import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../core/viewmodels/CRUDModel.dart';
import '../../core/models/account.dart';
import '../widgets/account.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<CRUDModel>(context);

    return StreamBuilder(
      stream: accountProvider.fetchAccountsAsStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator();
        else {
          accounts = snapshot.data.documents
              .map<Account>((doc) => Account.fromMap(doc.data, doc.documentID))
              .toList();

          return Scaffold(
            body: ListView.builder(
              primary: false,
              itemCount: accounts.length,
              itemBuilder: (BuildContext context, int index) {
                return AccountUI(
                  name: accounts[index].relation,
                  icon: "asset_icon.png",
                  rate: accounts[index].balance,
                  currency: accounts[index].currency,
                  depositary: accounts[index].bank,
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