import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/CRUDModel.dart';
import '../../core/models/transaction.dart';
import '../../core/models/account.dart';
import '../../core/models/statistic.dart';
import '../../ui/widgets/account_header.dart';
import '../../ui/widgets/customAppBar.dart';
import '../../ui/widgets/transaction_counter.dart';
import '../../ui/widgets/transaction_ui.dart';

class Transactions extends StatefulWidget {
  final String product;

  const Transactions({Key key, this.product}) : super(key: key);

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

  Statistic currentStatistic = Statistic();

  @override
  Widget build(BuildContext context) {
    final CRUDModel transactionProvider = Provider.of<CRUDModel>(context);
    final CRUDModel accountProvider = Provider.of<CRUDModel>(context);
    final CRUDModel firebaseProvider = Provider.of<CRUDModel>(context);

    firebaseProvider
        .getStatisticById('STAT_' + widget.product + '_YEAR_2019')
        .then((value) => currentStatistic = value)
        .catchError((error) {
      print(error);
    });

    accountProvider
        .getAccountById(widget.product)
        .then((value) => currentAccount = value)
        .catchError((error) {
      print(error);
    });

    return StreamBuilder(
      stream: transactionProvider.fetchTransactionsAsStreamByAccountByType(
          widget.product, ''),
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
              appBar: CustomAppBar(height: 50, title: 'Transactions'),
              body: Column(children: <Widget>[
                AccountHeader(
                  name: currentAccount.product,
                  icon: "asset_icon.png",
                  balance: currentAccount.balance,
                  currency: currentAccount.currency,
                  depositary: currentAccount.bank,
                  shortname: currentAccount.short,
                  totalInflow: currentStatistic.credit ?? 0.0,
                  totalOutflow: currentStatistic.debit ?? 0.0,
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
