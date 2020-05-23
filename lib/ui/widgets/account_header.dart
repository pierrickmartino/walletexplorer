import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class AccountHeader extends StatefulWidget {
  final String name;
  final String icon;
  final double balance;
  final double totalInflow;
  final double totalOutflow;
  final String currency;
  final String depositary;
  final String shortname;
  final charts.Color color;
  AccountHeader(
      {Key key,
      this.name,
      this.icon,
      this.balance,
      this.totalInflow,
      this.totalOutflow,
      this.color,
      this.currency,
      this.depositary,
      this.shortname})
      : super(key: key);

  @override
  _AccountHeaderState createState() => _AccountHeaderState();
}

class _AccountHeaderState extends State<AccountHeader> {
  NumberFormat numberFormat =
      NumberFormat.currency(locale: 'de_CH', symbol: '', decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.account_balance_wallet,
                    size: 25,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "${widget.shortname}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.currency}"
                " "
                "${numberFormat.format(widget.balance)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 35),
                  Text(
                    "${widget.name}",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.currency} ${numberFormat.format(widget.totalInflow)}",
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 35),
                  Text(
                    "${widget.depositary}",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.currency} ${numberFormat.format(widget.totalOutflow)}",
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).bottomAppBarColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
