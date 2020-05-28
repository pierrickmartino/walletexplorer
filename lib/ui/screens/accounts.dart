import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../core/viewmodels/CRUDModel.dart';
import '../../core/models/account.dart';
import '../widgets/account_ui.dart';
import '../../ui/widgets/customAppBar.dart';

class Accounts extends StatefulWidget {
  final String year;

  const Accounts({Key key, this.year}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  List<Account> accounts;
  String settingYear;

  _updateSettingYear(String year) {
    setState(() {
      settingYear = year;
    });
  }

  @override
  void initState() {
    super.initState();
    settingYear = widget.year;
  }

  @override
  Widget build(BuildContext context) {
    final CRUDModel accountProvider = Provider.of<CRUDModel>(context);
    //settingYear = widget.year;

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
            appBar: CustomAppBar(
                height: 70,
                title: 'Accounts',
                parentAction: _updateSettingYear,
                year: settingYear),
            body: ListView.builder(
              primary: false,
              itemCount: accounts.length,
              itemBuilder: (BuildContext context, int index) {
                return AccountUI(
                  name: accounts[index].product,
                  icon: "asset_icon.png",
                  balance: accounts[index].balance,
                  currency: accounts[index].currency,
                  depositary: accounts[index].bank,
                  shortname: accounts[index].short,
                  color: charts.MaterialPalette.blue.shadeDefault,
                  year: widget.year,
                );
              },
            ),
          );
        }
      },
    );
  }
}
