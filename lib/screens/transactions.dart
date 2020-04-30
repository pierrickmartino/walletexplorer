import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

enum Answers { YES, NO, MAYBE }

class _TransactionsState extends State<Transactions> {
  TextEditingController editingController = TextEditingController();
  final transactionsReference = Firestore.instance
      .collection("transactions")
      .orderBy("accountingDate", descending: true);

  String _value = '';

  void _setValue(String value) => setState(() => _value = value);

  Future _askUser() async {
    switch (await showDialog(
        context: context,
        /*it shows a popup with few options which you can select, for option we
        created enums which we can use with switch statement, in this first switch
        will wait for the user to select the option which it can use with switch cases*/
        child: new SimpleDialog(
          title: new Text('Do you like Flutter?'),
          children: <Widget>[
            new SimpleDialogOption(
              child: new Text('Yes!!!'),
              onPressed: () {
                Navigator.pop(context, Answers.YES);
              },
            ),
            new SimpleDialogOption(
              child: new Text('NO :('),
              onPressed: () {
                Navigator.pop(context, Answers.NO);
              },
            ),
            new SimpleDialogOption(
              child: new Text('Maybe :|'),
              onPressed: () {
                Navigator.pop(context, Answers.MAYBE);
              },
            ),
          ],
        ))) {
      case Answers.YES:
        _setValue('Yes');
        break;
      case Answers.NO:
        _setValue('No');
        break;
      case Answers.MAYBE:
        _setValue('Maybe');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: transactionsReference.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator();
        else {
          List transactionsItems = [];
          snapshot.data.documents.forEach((document) {
            transactionsItems
                .add({"key": document.documentID, ...document.data});
          });

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
              itemCount: transactionsItems.length,
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
                      onLongPress: _askUser,
                      child: CircleAvatar(
                        child: Text('?',
                            style: TextStyle(
                                color: Theme.of(context).accentColor)),
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                    ),
                    trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            transactionsItems[index]['creditAmount'] == ""
                                ? "- ${transactionsItems[index]['debitAmount']}"
                                : "+ ${transactionsItems[index]['creditAmount']}",
                            style: TextStyle(
                              color:
                                  transactionsItems[index]['creditAmount'] == ""
                                      ? Colors.red
                                      : Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          // PopupMenuButton(
                          //   itemBuilder: (context) {
                          //     var list = List<PopupMenuEntry<Object>>();
                          //     list.add(PopupMenuItem(
                          //       value: transactionTypes[0],
                          //       child: Text(transactionTypes[0]['label']),
                          //     ));
                          //     list.add(PopupMenuItem(
                          //       value: transactionTypes[1],
                          //       child: Text(transactionTypes[1]['label']),
                          //     ));
                          //     list.add(PopupMenuItem(
                          //       value: transactionTypes[2],
                          //       child: Text(transactionTypes[2]['label']),
                          //     ));
                          //     list.add(PopupMenuItem(
                          //       value: transactionTypes[3],
                          //       child: Text(transactionTypes[3]['label']),
                          //     ));
                          //     return list;
                          //   },
                          // ),
                          Text(transactionsItems[index]['accountingDate'],
                              style: TextStyle(
                                fontSize: 12,
                              )),
                        ]),
                    title: Text(transactionsItems[index]['description2'],
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    subtitle: Text(transactionsItems[index]['description1'],
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
                                Text(transactionsItems[index]['description1'],
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                                Text(transactionsItems[index]['description2'],
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                                Text(transactionsItems[index]['description3'],
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                                Text(""),
                                Text(
                                    "IBAN: " +
                                        transactionsItems[index]['refIBAN'],
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                                Text(
                                    "Accounting date: " +
                                        transactionsItems[index]
                                            ['accountingDate'],
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                                Text(
                                    "Value date: " +
                                        transactionsItems[index]['valueDate'],
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
