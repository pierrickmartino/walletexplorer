import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as _firestore;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:snack/snack.dart';

import '../../core/models/transaction.dart';
import '../../core/viewmodels/CRUDModel.dart';
import '../../core/models/transaction_type.dart';
import '../../ui/widgets/transaction_header_ui.dart';

class TransactionUI extends StatefulWidget {
  final Transaction transaction;
  final CRUDModel transactionProvider;

  TransactionUI({this.transaction, this.transactionProvider});

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<TransactionUI> {
  List<TransactionType> transactionTypes;

  final SnackBar bar = SnackBar(content: Text('Transaction type updated !'));

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
      case 'familyChildren':
        {
          return MaterialCommunityIcons.human_child;
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

  NumberFormat numberFormat =
      NumberFormat.currency(locale: 'de_CH', symbol: '', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    final CRUDModel transactionTypeProvider = Provider.of<CRUDModel>(context);

    Transaction currentTransaction;

    Stream<_firestore.QuerySnapshot> getSnapshotDependingOnCreditAmount(
        double creditAmount) {
      if (creditAmount > 0) {
        return transactionTypeProvider.fetchTransactionTypesAsStreamCredit();
      } else {
        return transactionTypeProvider.fetchTransactionTypesAsStreamDebit();
      }
    }

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
              currentTransaction = widget.transaction;
            });
            showMaterialModalBottomSheet(
                elevation: 4.0,
                useRootNavigator: true,
                bounce: true,
                context: context,
                barrierColor: Theme.of(context).backgroundColor,
                builder: (context, scrollController) => StreamBuilder(
                    stream: getSnapshotDependingOnCreditAmount(
                        currentTransaction.creditAmount),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Scaffold(
                            body: Center(
                          child: CircularProgressIndicator(),
                        ));
                      } else {
                        transactionTypes = snapshot.data.documents
                            .map<TransactionType>((doc) =>
                                TransactionType.fromMap(
                                    doc.data, doc.documentID))
                            .toList();
                      }
                      return Container(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TransactionHeaderUI(
                            transaction: widget.transaction,
                          ),
                          Wrap(
                            spacing: 4.0,
                            children: <Widget>[
                              for (var i = 0; i < transactionTypes.length; i++)
                                ActionChip(
                                    elevation: 4.0,
                                    padding: const EdgeInsets.all(8.0),
                                    avatar: CircleAvatar(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        child: Icon(
                                            getIconDataByCode(
                                                transactionTypes[i].code),
                                            size: 15)),
                                    label: Text(transactionTypes[i].label),
                                    onPressed: () async {
                                      if (currentTransaction.type !=
                                          transactionTypes[i].code) {
                                        currentTransaction.type =
                                            transactionTypes[i].code;

                                        await widget.transactionProvider
                                            .updateTransaction(
                                                currentTransaction,
                                                currentTransaction.id);
                                      }
                                      Navigator.pop(context);
                                    })
                            ],
                          ),
                        ],
                      ));
                    }));
          },
          child: IconButton(
            iconSize: 30,
            color: widget.transaction.type == ""
                ? Color(0xffE0FF4F)
                : widget.transaction.debitAmount > 0
                    ? Theme.of(context).bottomAppBarColor
                    : Theme.of(context).accentColor,
            icon: Icon(getIconDataByCode(widget.transaction.type)),
            onPressed: () {},
          ),
        ),
        title: Row(
          children: <Widget>[
            Text(
                widget.transaction.description2 == ""
                    ? (widget.transaction.description1.length < 23
                        ? widget.transaction.description1
                        : widget.transaction.description1.substring(0, 23))
                    : (widget.transaction.description2.length < 23
                        ? widget.transaction.description2
                        : widget.transaction.description2.substring(0, 23)),
                style: TextStyle(
                  fontSize: 12,
                )),
            Spacer(),
            Text(
              widget.transaction.debitAmount > 0
                  ? "- ${numberFormat.format(widget.transaction.debitAmount)}"
                  : "+ ${numberFormat.format(widget.transaction.creditAmount)}",
              style: TextStyle(
                color: widget.transaction.debitAmount > 0
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
            Text(widget.transaction.description1,
                style: TextStyle(
                  fontSize: 12,
                )),
            Spacer(),
            Text(
                widget.transaction.accountingDate +
                    ' - ' +
                    widget.transaction.currency,
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
                  borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.transaction.description1,
                        style: TextStyle(
                          fontSize: 12,
                        )),
                    Text(widget.transaction.description2,
                        style: TextStyle(
                          fontSize: 12,
                        )),
                    Text(widget.transaction.description3,
                        style: TextStyle(
                          fontSize: 12,
                        )),
                    Text(""),
                    Text("Type: " + widget.transaction.type,
                        style: TextStyle(
                          fontSize: 12,
                        )),
                    Text("IBAN: " + widget.transaction.refIBAN,
                        style: TextStyle(
                          fontSize: 12,
                        )),
                    Text(
                        "Accounting date: " + widget.transaction.accountingDate,
                        style: TextStyle(
                          fontSize: 12,
                        )),
                    Text("Value date: " + widget.transaction.valueDate,
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
  }
}
