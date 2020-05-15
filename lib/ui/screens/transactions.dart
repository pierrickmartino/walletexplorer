import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as _firestore;
import 'package:flutter_icons/flutter_icons.dart';

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

  IconData getIconDataByCode(String transactionTypeCode) {
    switch (transactionTypeCode) {
      case 'bankFees':
        {
          return MaterialCommunityIcons.bank_minus;
        }
        break;
      case 'carTransport':
        {
          return MaterialCommunityIcons.car_back;
        }
        break;
      case 'communicationMedia':
        {
          return MaterialCommunityIcons.cellphone_link;
        }
        break;
      case 'health':
        {
          return MaterialCommunityIcons.pharmacy;
        }
        break;
      case 'household':
        {
          return MaterialCommunityIcons.cart;
        }
        break;
      case 'housingEnergy':
        {
          return MaterialCommunityIcons.home_city;
        }
        break;
      case 'leisureSport':
        {
          return MaterialCommunityIcons.soccer;
        }
        break;
      case 'otherExpenses':
        {
          return MaterialCommunityIcons.credit_card_minus;
        }
        break;
      case 'personalExpenses':
        {
          return MaterialCommunityIcons.account;
        }
        break;
      case 'savingsInvestments':
        {
          return MaterialCommunityIcons.piggy_bank;
        }
        break;
      case 'taxesCharges':
        {
          return MaterialCommunityIcons.book_minus_multiple;
        }
        break;
      case 'vacationTravel':
        {
          return MaterialCommunityIcons.beach;
        }
        break;
      case 'withdrawal':
        {
          return MaterialCommunityIcons.minus_circle;
        }
        break;
      case 'capitalIncome':
        {
          return MaterialCommunityIcons.note_plus;
        }
        break;
      case 'deposit':
        {
          return MaterialCommunityIcons.plus_circle;
        }
        break;
      case 'donationInheritance':
        {
          return MaterialCommunityIcons.wallet_giftcard;
        }
        break;
      case 'familyAllowances':
        {
          return MaterialCommunityIcons.account_group;
        }
        break;
      case 'loan':
        {
          return MaterialCommunityIcons.swap_vertical_variant;
        }
        break;
      case 'otherIncome':
        {
          return MaterialCommunityIcons.filter_plus;
        }
        break;
      case 'refund':
        {
          return MaterialCommunityIcons.cash_refund;
        }
        break;
      case 'salesThings':
        {
          return MaterialCommunityIcons.sale;
        }
        break;
      case 'wagesIncome':
        {
          return MaterialCommunityIcons.briefcase_plus;
        }
        break;
      case 'internalTransfer':
        {
          return MaterialCommunityIcons.swap_horizontal;
        }
      case 'unknown':
        {
          return Icons.zoom_in;
        }
        break;
      default:
        {
          return Icons.zoom_in;
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
                SizedBox(
                  height: 15,
                ),
                //SearchTransaction(editingController: editingController),
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
                                                              Colors.white,
                                                          child: Icon(
                                                              getIconDataByCode(
                                                                  transactionTypes[
                                                                          i]
                                                                      .code),
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
                            color: transactions[index].type == ""
                                ? Color(0xffE0FF4F)
                                : transactions[index].debitAmount > 0
                                    ? Theme.of(context).bottomAppBarColor
                                    : Theme.of(context).accentColor,
                            icon: Icon(
                                getIconDataByCode(transactions[index].type)),
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
                                    Text("Type: " + transactions[index].type,
                                        style: TextStyle(
                                          fontSize: 12,
                                        )),
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
