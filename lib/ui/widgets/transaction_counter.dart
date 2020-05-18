import 'package:flutter/material.dart';

class TransactionCounter extends StatefulWidget {
  final String numberOfTransactions;
  TransactionCounter({Key key, this.numberOfTransactions}) : super(key: key);

  @override
  _TransactionCounterState createState() => _TransactionCounterState();
}

class _TransactionCounterState extends State<TransactionCounter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                widget.numberOfTransactions.toString() +
                    " transactions (limit:50)",
                style: TextStyle(
                  color: Theme.of(context).cursorColor,
                  fontSize: 12,
                ),
              ),
            ]));
  }
}
