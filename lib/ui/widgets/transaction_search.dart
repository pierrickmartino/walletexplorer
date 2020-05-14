import 'package:flutter/material.dart';

class SearchTransaction extends StatefulWidget {
  final TextEditingController editingController;

  const SearchTransaction({Key key, this.editingController}) : super(key: key);

  @override
  _SearchTransactionState createState() => _SearchTransactionState();
}

class _SearchTransactionState extends State<SearchTransaction> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        //onChanged: (value) {},
        onSubmitted: (value) {},
        controller: widget.editingController,
        decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      ),
    );
  }
}
