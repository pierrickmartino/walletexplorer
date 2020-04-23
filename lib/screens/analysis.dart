import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Analysis extends StatefulWidget {
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  TextEditingController editingController = TextEditingController();
  final transactionsReference = Firestore.instance.collection("transactions");

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
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/cm1.jpeg"),
                      radius: 25,
                    ),
                    title: Text(transactionsItems[index]['description1']),
                    subtitle: Text(transactionsItems[index]['description2']),
                    trailing: Text(
                      transactionsItems[index]['creditAmount'] == ""
                          ? "-${transactionsItems[index]['debitAmount']}"
                          : "+${transactionsItems[index]['creditAmount']}",
                      style: TextStyle(
                        color: transactionsItems[index]['creditAmount'] == ""
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
