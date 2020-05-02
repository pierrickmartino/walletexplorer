import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart' as _firestore;
import 'package:provider/provider.dart';
import 'package:walletexplorer/core/models/transaction_type.dart';
import 'package:walletexplorer/core/viewmodels/CRUDModel.dart';
import 'package:walletexplorer/core/models/transaction.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

//enum Answers { YES, NO, MAYBE }

class _TransactionsState extends State<Transactions> {
  TextEditingController editingController = TextEditingController();
  List<Transaction> transactions;
  List<TransactionType> transactionTypes;

// String _value = '';

// void _setValue(String value) => setState(() => _value = value);

// @override
// void initState() {
//   super.initState();
// }

// Get all the available transaction types from firestore
// Future<_firestore.QuerySnapshot> getAllTransactionTypes() {
//   final transactionTypesReference = _firestore.Firestore.instance
//       .collection("transactionTypes")
//       .orderBy("label", descending: true);
//   return transactionTypesReference.getDocuments();
// }

// Future _askUser() async {
//   switch (await showDialog(
//       context: context,
//       /*it shows a popup with few options which you can select, for option we
//       created enums which we can use with switch statement, in this first switch
//       will wait for the user to select the option which it can use with switch cases*/
//       child: SimpleDialog(
//         title: Text('New transaction type :'),
//         children: <Widget>[
//           SimpleDialogOption(
//             child: Text('Unknown'),
//             onPressed: () {
//               Navigator.pop(context, Answers.YES);
//             },
//           ),
//           SimpleDialogOption(
//             child: Text('Tax'),
//             onPressed: () {
//               Navigator.pop(context, Answers.NO);
//             },
//           ),
//           SimpleDialogOption(
//             child: Text('Consumer goods'),
//             onPressed: () {
//               Navigator.pop(context, Answers.MAYBE);
//             },
//           ),
//         ],
//       ))) {
//     case Answers.YES:
//       _setValue('Yes');
//       break;
//     case Answers.NO:
//       _setValue('No');
//       break;
//     case Answers.MAYBE:
//       _setValue('Maybe');
//       break;
//   }
// }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<CRUDModel>(context);

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
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ExpansionTile(
                    leading: GestureDetector(
                      //onLongPress: _askUser,
                      child: CircularProfileAvatar(
                        '',
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        borderWidth: 10,
                        initialsText: Text(
                          "?",
                          style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).accentColor),
                        ),
                        borderColor: Theme.of(context).cardColor,
                        elevation: 5.0,
                        foregroundColor:
                            Theme.of(context).cardColor.withOpacity(0.5),
                        showInitialTextAbovePicture: true,
                      ),
                    ),
                    trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            transactions[index].creditAmount == ""
                                ? "- ${transactions[index].debitAmount}"
                                : "+ ${transactions[index].creditAmount}",
                            style: TextStyle(
                              color: transactions[index].creditAmount == ""
                                  ? Theme.of(context).bottomAppBarColor
                                  : Theme.of(context).cardColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(transactions[index].accountingDate,
                              style: TextStyle(
                                fontSize: 12,
                              )),
                        ]),
                    title: Text(transactions[index].description2,
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    subtitle: Text(transactions[index].description1,
                        style: TextStyle(
                          fontSize: 12,
                        )),
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
