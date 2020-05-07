import 'package:flutter/material.dart';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';

import '../../core/models/transaction_type.dart';
import '../../core/viewmodels/CRUDModel.dart';
import '../../core/models/transaction.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  TextEditingController editingController = TextEditingController();
  List<Transaction> transactions;
  List<TransactionType> transactionTypes;

  NumberFormat numberFormat =
      NumberFormat.currency(locale: 'de_CH', symbol: '', decimalDigits: 2);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CRUDModel transactionProvider = Provider.of<CRUDModel>(context);
    final CRUDModel transactionTypeProvider = Provider.of<CRUDModel>(context);

    Transaction currentTransaction;

    return StreamBuilder(
      stream: transactionProvider.fetchTransactionsAsStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          transactions = snapshot.data.documents
              .map<Transaction>(
                  (doc) => Transaction.fromMap(doc.data, doc.documentID))
              .toList();

          return Container(
              child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                onChanged: (value) {},
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
            ),
            Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ExpansionTile(
                    leading: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          currentTransaction = transactions[index];
                        });
                        showMaterialModalBottomSheet(
                            elevation: 4.0,
                            useRootNavigator: true,
                            bounce: true,
                            context: context,
                            builder: (context, scrollController) =>
                                StreamBuilder(
                                    stream: transactionTypeProvider
                                        .fetchTransactionTypesAsStream(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return LinearProgressIndicator();
                                      } else {
                                        transactionTypes = snapshot
                                            .data.documents
                                            .map<TransactionType>((doc) =>
                                                TransactionType.fromMap(
                                                    doc.data, doc.documentID))
                                            .toList();
                                      }
                                      return Container(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  transactionTypes.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ListTile(
                                                  enabled: true,
                                                  onTap: () async {
                                                    if (currentTransaction
                                                            .type !=
                                                        transactionTypes[index]
                                                            .code) {
                                                      currentTransaction.type =
                                                          transactionTypes[
                                                                  index]
                                                              .code;
                                                      currentTransaction.icon =
                                                          transactionTypes[
                                                                  index]
                                                              .icon;
                                                      await transactionProvider
                                                          .updateTransaction(
                                                              currentTransaction,
                                                              currentTransaction
                                                                  .id);
                                                    }

                                                    Navigator.pop(context);
                                                  },
                                                  title: Text(
                                                      transactionTypes[index]
                                                          .label),
                                                );
                                              }));
                                    }));
                      },
                      child: CircularProfileAvatar(
                        '',
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        borderWidth: 10,
                        initialsText: Text(transactions[index].icon,
                            style: TextStyle(
                              fontSize: 18,
                              color: transactions[index].debitAmount > 0
                                  ? Theme.of(context).bottomAppBarColor
                                  : Theme.of(context).accentColor,
                            )),
                        borderColor: Theme.of(context).cardColor,
                        elevation: 4.0,
                        foregroundColor:
                            Theme.of(context).cardColor.withOpacity(0.5),
                        showInitialTextAbovePicture: true,
                      ),
                    ),
                    title: Row(
                      children: <Widget>[
                        Text(
                            transactions[index].description2 == ""
                                ? (transactions[index].description1.length < 23
                                    ? transactions[index].description1
                                    : transactions[index]
                                        .description1
                                        .substring(0, 23))
                                : (transactions[index].description2.length < 23
                                    ? transactions[index].description2
                                    : transactions[index]
                                        .description2
                                        .substring(0, 23)),
                            style: TextStyle(
                              fontSize: 12,
                            )),
                        Spacer(),
                        Text(
                          transactions[index].debitAmount > 0
                              ? "- ${numberFormat.format(transactions[index].debitAmount)}"
                              : "+ ${numberFormat.format(transactions[index].creditAmount)}",
                          style: TextStyle(
                            color: transactions[index].debitAmount > 0
                                ? Theme.of(context).bottomAppBarColor
                                : Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Text(transactions[index].description1,
                            style: TextStyle(
                              fontSize: 12,
                            )),
                        Spacer(),
                        Text(
                            transactions[index].accountingDate +
                                ' - ' +
                                transactions[index].currency,
                            style: TextStyle(
                              fontSize: 12,
                            ))
                      ],
                    ),
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            //height: 100.0,
                            margin: const EdgeInsets.all(4.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(transactions[index].description1,
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                                Text(transactions[index].description2,
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                                Text(transactions[index].description3,
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                                Text(""),
                                Text("IBAN: " + transactions[index].refIBAN,
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                                Text(
                                    "Accounting date: " +
                                        transactions[index].accountingDate,
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                                Text(
                                    "Value date: " +
                                        transactions[index].valueDate,
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ))
          ]));
        }
      },
    );
  }
}
