import 'package:flutter/material.dart';

class OverviewTextWithTitle extends StatefulWidget {
  final String text;
  final String title;
  final String subtitle;
  final Color amountColor;

  OverviewTextWithTitle(
      {Key key, this.text, this.title, this.subtitle, this.amountColor})
      : super(key: key);

  @override
  _OverviewTextWithTitleState createState() => _OverviewTextWithTitleState();
}

class _OverviewTextWithTitleState extends State<OverviewTextWithTitle> {
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
                  //style: TextStyle(

                  //color: Theme.of(context).cursorColor, fontSize: 18),
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
            Text(
              "${widget.text}",
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
