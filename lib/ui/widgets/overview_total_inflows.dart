import 'package:flutter/material.dart';

class OverviewTotalInflows extends StatefulWidget {
  @override
  _OverviewTotalInflowsState createState() => _OverviewTotalInflowsState();
}

class _OverviewTotalInflowsState extends State<OverviewTotalInflows> {
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
                const Text(
                  "Total inflows",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  'per year',
                  style: TextStyle(color: Color(0xff77839a), fontSize: 14),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              r"+ $21.67",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
