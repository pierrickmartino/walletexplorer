import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:walletexplorer/ui/widgets/transaction_counter.dart';
import 'package:walletexplorer/ui/widgets/transaction_ui.dart';

import '../../core/viewmodels/CRUDModel.dart';
import '../../core/models/transaction.dart';
import '../../core/models/account.dart';
import '../../ui/widgets/account_header.dart';
import '../../ui/widgets/customAppBar.dart';

class Transactions extends StatefulWidget {
  final String relation;

  const Transactions({Key key, this.relation}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  TextEditingController editingController = TextEditingController();
  List<Transaction> transactions;

  Account currentAccount = Account(
      active: true,
      balance: 0,
      bank: '-',
      currency: '-',
      description: '-',
      evaluationDate: '-',
      product: '-',
      refIBAN: '-',
      relation: '-');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CRUDModel transactionProvider = Provider.of<CRUDModel>(context);
    final CRUDModel accountProvider = Provider.of<CRUDModel>(context);

    accountProvider
        .getAccountById(widget.relation)
        .then((value) => currentAccount = value)
        .catchError((error) {
      print(error);
    });

    return StreamBuilder(
      stream: transactionProvider.fetchTransactionsAsStreamByAccountByType(
          widget.relation, ''),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        } else {
          transactions = snapshot.data.documents
              .map<Transaction>(
                  (doc) => Transaction.fromMap(doc.data, doc.documentID))
              .toList();

          return Scaffold(
              appBar: CustomAppBar(height: 80, title: 'Transactions'),
              body: Column(children: <Widget>[
                AccountHeader(
                  name: currentAccount.relation,
                  icon: "asset_icon.png",
                  balance: currentAccount.balance,
                  currency: currentAccount.currency,
                  depositary: currentAccount.bank,
                ),
                TransactionCounter(
                    numberOfTransactions: transactions.length.toString()),
                //SearchTransaction(editingController: editingController),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return TransactionUI(
                      transaction: transactions[index],
                      transactionProvider: transactionProvider,
                    );
                  },
                ))
              ]));
        }
      },
    );
  }
}
