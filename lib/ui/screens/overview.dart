import 'package:flutter/material.dart';

import '../../util/data.dart';
import '../widgets/position.dart';
import '../../ui/widgets/overview_total_inflows.dart';
import '../../ui/widgets/overview_total_outflows.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            OverviewTotalInflows(),
            OverviewTotalOutflows(),
          ],
        ),
        Expanded(
          child: ListView.builder(
            //physics: NeverScrollableScrollPhysics(),
            primary: false,
            itemCount: coins.length,
            itemBuilder: (BuildContext context, int index) {
              Map coin = coins[index];

              return Wallet(
                name: coin['name'],
                icon: coin['icon'],
                rate: coin['rate'],
                color: coin['color'],
              );
            },
          ),
        )
      ],
    ));
  }
}
