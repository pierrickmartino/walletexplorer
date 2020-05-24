import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OverviewTotalWithTitle extends StatefulWidget {
  final double amount;
  final String title;
  final String subtitle;
  final Color amountColor;

  OverviewTotalWithTitle(
      {Key key, this.amount, this.title, this.subtitle, this.amountColor})
      : super(key: key);

  @override
  _OverviewTotalWithTitleState createState() => _OverviewTotalWithTitleState();
}

class _OverviewTotalWithTitleState extends State<OverviewTotalWithTitle> {
  NumberFormat numberFormat =
      NumberFormat.currency(locale: 'de_CH', symbol: '', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${widget.title}",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  "${widget.subtitle}",
                  style: TextStyle(color: Color(0xff77839a), fontSize: 14),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "${numberFormat.format(widget.amount)}",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: widget.amountColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
