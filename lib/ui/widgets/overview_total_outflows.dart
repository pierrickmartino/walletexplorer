import 'package:flutter/material.dart';

class OverviewTotalOutflows extends StatefulWidget {
  @override
  _OverviewTotalOutflowsState createState() => _OverviewTotalOutflowsState();
}

class _OverviewTotalOutflowsState extends State<OverviewTotalOutflows> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
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
                      "Total outflows",
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
                  r"- $21.67",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).bottomAppBarColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
