import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';

class OverviewTotalWithTitle extends StatefulWidget {
  final double amount;
  final double evolution;
  final String title;
  final String subtitle;
  final Color amountColor;

  OverviewTotalWithTitle(
      {Key key,
      this.amount,
      this.title,
      this.subtitle,
      this.amountColor,
      this.evolution})
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
                  style: Theme.of(context).textTheme.headline6,
                  // style: TextStyle(
                  //     color: Theme.of(context).cursorColor, fontSize: 18),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  "${widget.subtitle}",
                  style: Theme.of(context).textTheme.subtitle1,
                  //style: TextStyle(color: Color(0xff77839a), fontSize: 14),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${numberFormat.format(widget.amount)}",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: widget.amountColor,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Row(
                    children: [
                      Text(
                        "${numberFormat.format(widget.evolution)}%",
                        style: TextStyle(
                          fontSize: 14,
                          //fontWeight: FontWeight.bold,
                          color: widget.amountColor,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Feather.trending_up,
                        size: 16,
                        color: widget.amountColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
            // const SizedBox(
            //   height: 12,
            // ),
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Text(
            //       "Compared to (0000 last year)",
            //       style: TextStyle(
            //         fontSize: 12,
            //         //fontWeight: FontWeight.bold,
            //         //color: widget.amountColor,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
