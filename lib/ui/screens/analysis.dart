import 'package:flutter/material.dart';

import '../../util/data.dart';
import '../widgets/transactionTest.dart';

class Analysis extends StatefulWidget {
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  TextEditingController editingController = TextEditingController();

  // Add a duplicate list for transactions to use the search engine
  List<ObjecTest> transactionsItems = new List<ObjecTest>();

  @override
  void initState() {
    transactionsItems.addAll(transactions);

    super.initState();
  }

  void filterSearchResults(String query) {
    List<ObjecTest> transactionSearchList = List<ObjecTest>();
    transactionSearchList.addAll(transactionsItems);
    if (query.isNotEmpty) {
      List<ObjecTest> transactionListData = List<ObjecTest>();
      transactionSearchList.forEach((item) {
        if (item.name.toLowerCase().contains(query)) {
          transactionListData.add(item);
        }
      });
      setState(() {
        transactionsItems.clear();
        transactionsItems.addAll(transactionListData);
      });
      return;
    } else {
      setState(() {
        transactionsItems.clear();
        transactionsItems.addAll(transactions);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value.toLowerCase());
              },
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
                ObjecTest transaction = transactionsItems[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        transaction.dp,
                      ),
                      radius: 25,
                    ),
                    title: Text(transaction.name),
                    subtitle: Text(transaction.date),
                    trailing: Text(
                      transaction.type == "sent"
                          ? "-${transaction.amount}"
                          : "+${transaction.amount}",
                      style: TextStyle(
                        color: transaction.type == "sent"
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
