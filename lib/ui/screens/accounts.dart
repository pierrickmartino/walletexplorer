import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../core/viewmodels/CRUDModel.dart';
import '../../core/models/account.dart';
import '../widgets/account.dart';
import '../../ui/widgets/customAppBar.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    final CRUDModel accountProvider = Provider.of<CRUDModel>(context);

    return StreamBuilder(
      stream: accountProvider.fetchAccountsAsStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        } else {
          accounts = snapshot.data.documents
              .map<Account>((doc) => Account.fromMap(doc.data, doc.documentID))
              .toList();

          return Scaffold(
            appBar: CustomAppBar(height: 80, title: 'Accounts'),
            body: ListView.builder(
              primary: false,
              itemCount: accounts.length,
              itemBuilder: (BuildContext context, int index) {
                return AccountUI(
                  name: accounts[index].relation.toString(),
                  icon: "asset_icon.png",
                  balance: accounts[index].balance,
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
