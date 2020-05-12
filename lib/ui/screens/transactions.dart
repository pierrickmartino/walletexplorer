import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as _firestore;

import '../../core/models/transaction_type.dart';
import '../../core/viewmodels/CRUDModel.dart';
import '../../core/models/transaction.dart';
import '../../core/models/account.dart';
import '../../ui/widgets/transaction_search.dart';
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
  List<TransactionType> transactionTypes;

  NumberFormat numberFormat =
      NumberFormat.currency(locale: 'de_CH', symbol: '', decimalDigits: 2);

  IconData getIconDataByName(String iconName) {
    switch (iconName) {
      case 'business_center':
        {
          return Icons.business_center;
        }
        break;
      case 'shopping_cart':
        {
          return Icons.shopping_cart;
        }
        break;
      case 'remove_from_queue':
        {
          return Icons.remove_from_queue;
        }
        break;
      case 'add_to_queue':
        {
          return Icons.add_to_queue;
        }
        break;
      case 'local_airport':
        {
          return Icons.local_airport;
        }
        break;
      case 'local_hospital':
        {
          return Icons.local_hospital;
        }
        break;
      case 'home':
        {
          return Icons.home;
        }
        break;
      case 'fastfood':
        {
          return Icons.restaurant;
        }
        break;
      case 'directions_car':
        {
          return Icons.directions_car;
        }
        break;
      case 'monetization_on':
        {
          return Icons.attach_money;
        }
        break;
      case 'phonelink':
        {
          return Icons.phonelink;
        }
        break;
      case 'swap_horiz':
        {
          return Icons.swap_horiz;
        }
        break;
      case 'money_off':
        {
          return Icons.money_off;
        }
        break;
      case 'terrain':
        {
          return Icons.terrain;
        }
        break;
      case 'fitness_center':
        {
          return Icons.fitness_center;
        }
        break;
      case 'person':
        {
          return Icons.person;
        }
        break;
      default:
        {
          return Icons.zoom_in;
        }
    }
  }

  Color getIconColorByName(String iconName) {
    switch (iconName) {
      case 'business_center':
        {
          return Color(0xff90D7FF);
        }
        break;
      case 'shopping_cart':
        {
          return Color(0xffC9F9FF);
        }
        break;
      case 'remove_from_queue':
        {
          return Color(0xffBFD0E0);
        }
        break;
      case 'add_to_queue':
        {
          return Color(0xffB8B3BE);
        }
        break;
      case 'local_airport':
        {
          return Color(0xffC1AE7C);
        }
        break;
      case 'local_hospital':
        {
          return Color(0xffCC4BC2);
        }
        break;
      case 'home':
        {
          return Color(0xff6C3A5C);
        }
        break;
      case 'fastfood':
        {
          return Color(0xff794C6B);
        }
        break;
      case 'directions_car':
        {
          return Color(0xffFFDAB9);
        }
        break;
      case 'monetization_on':
        {
          return Color(0xff7FB285);
        }
        break;
      case 'phonelink':
        {
          return Color(0xffA480CF);
        }
        break;
      case 'swap_horiz':
        {
          return Color(0xffE0FF4F); /* TODO */
        }
        break;
      case 'money_off':
        {
          return Color(0xffE0FF4F); /* TODO */
        }
        break;
      default:
        {
          return Color(0xffE0FF4F);
        }
    }
  }

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
    final CRUDModel transactionTypeProvider = Provider.of<CRUDModel>(context);
    final CRUDModel accountProvider = Provider.of<CRUDModel>(context);

    Transaction currentTransaction;

    accountProvider
        .getAccountById(widget.relation)
        .then((value) => currentAccount = value)
        .catchError((error) {
      print(error);
    });

    Stream<_firestore.QuerySnapshot> getSnapshotDependingOnCreditAmount(
        double creditAmount) {
      if (creditAmount > 0) {
        return transactionTypeProvider.fetchTransactionTypesAsStreamCredit();
      } else {
        return transactionTypeProvider.fetchTransactionTypesAsStreamDebit();
      }
    }

    return StreamBuilder(
      stream: transactionProvider.fetchTransactionsAsStream(),
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
                SizedBox(
                  height: 15,
                ),
                SearchTransaction(editingController: editingController),
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
                                        stream:
                                            getSnapshotDependingOnCreditAmount(
                                                currentTransaction
                                                    .creditAmount),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Scaffold(
                                                body: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ));
                                          } else {
                                            transactionTypes = snapshot
                                                .data.documents
                                                .map<TransactionType>((doc) =>
                                                    TransactionType.fromMap(
                                                        doc.data,
                                                        doc.documentID))
                                                .toList();
                                          }
                                          return Container(
                                            child: Wrap(
                                              spacing: 4.0,
                                              children: <Widget>[
                                                for (var i = 0;
                                                    i < transactionTypes.length;
                                                    i++)
                                                  ActionChip(
                                                      elevation: 4.0,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      avatar: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.black,
                                                          foregroundColor:
                                                              Color(0xffE0FF4F),
                                                          child: Icon(
                                                              getIconDataByName(
                                                                  transactionTypes[
                                                                          i]
                                                                      .icon),
                                                              size: 15)),
                                                      label: Text(
                                                          transactionTypes[i]
                                                              .label),
                                                      onPressed: () async {
                                                        if (currentTransaction
                                                                .type !=
                                                            transactionTypes[i]
                                                                .code) {
                                                          currentTransaction
                                                                  .type =
                                                              transactionTypes[
                                                                      i]
                                                                  .code;
                                                          currentTransaction
                                                                  .icon =
                                                              transactionTypes[
                                                                      i]
                                                                  .icon;
                                                          await transactionProvider
                                                              .updateTransaction(
                                                                  currentTransaction,
                                                                  currentTransaction
                                                                      .id);
                                                        }

                                                        Navigator.pop(context);
                                                      })
                                              ],
                                            ),
                                          );
                                        }));
                          },
                          child: IconButton(
                            iconSize: 30,
                            color: transactions[index].icon == ""
                                ? Color(0xffE0FF4F)
                                : transactions[index].debitAmount > 0
                                    ? Theme.of(context).bottomAppBarColor
                                    : Theme.of(context).accentColor,
                            icon: Icon(
                                getIconDataByName(transactions[index].icon)),
                            onPressed: () {},
                          ),
                        ),
                        title: Row(
                          children: <Widget>[
                            Text(
                                transactions[index].description2 == ""
                                    ? (transactions[index].description1.length <
                                            23
                                        ? transactions[index].description1
                                        : transactions[index]
                                            .description1
                                            .substring(0, 23))
                                    : (transactions[index].description2.length <
                                            23
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
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(10.0)),
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
