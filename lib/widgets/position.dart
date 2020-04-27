import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Wallet extends StatefulWidget {
  final String name;
  final String icon;
  final String rate;
  final String currency;
  final charts.Color color;
  Wallet({Key key, this.name, this.icon, this.rate, this.color, this.currency})
      : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _WalletState extends State<Wallet> {
  static Random random = Random();
  final data = [
    LinearToken(0, random.nextInt(300)),
    LinearToken(1, random.nextInt(300)),
    LinearToken(2, random.nextInt(300)),
    LinearToken(3, random.nextInt(300)),
    LinearToken(4, random.nextInt(300)),
    LinearToken(5, random.nextInt(300)),
    LinearToken(6, random.nextInt(300)),
    LinearToken(7, random.nextInt(300)),
    LinearToken(8, random.nextInt(300)),
    LinearToken(9, random.nextInt(300)),
    LinearToken(10, random.nextInt(300)),
    LinearToken(11, random.nextInt(300)),
    LinearToken(12, random.nextInt(300)),
    LinearToken(13, random.nextInt(300)),
    LinearToken(14, random.nextInt(300)),
    LinearToken(15, random.nextInt(300)),
    LinearToken(16, random.nextInt(300)),
    LinearToken(17, random.nextInt(300)),
    LinearToken(18, random.nextInt(300)),
    LinearToken(19, random.nextInt(300)),
    LinearToken(20, random.nextInt(300)),
    LinearToken(21, random.nextInt(300)),
    LinearToken(22, random.nextInt(300)),
    LinearToken(23, random.nextInt(300)),
    LinearToken(24, random.nextInt(300)),
    LinearToken(25, random.nextInt(300)),
    LinearToken(26, random.nextInt(300)),
    LinearToken(27, random.nextInt(300)),
    LinearToken(28, random.nextInt(300)),
    LinearToken(29, random.nextInt(300)),
    LinearToken(30, random.nextInt(300)),
    LinearToken(31, random.nextInt(300)),
  ];

  @override
  Widget build(BuildContext context) {

    var dataBar = [
      new ClicksPerYear('2016', 12, Colors.red),
      new ClicksPerYear('2017', 42, Colors.yellow),
      new ClicksPerYear('2018', 33, Colors.green),
    ];

    var series = [
      new charts.Series(
        id: 'Clicks',
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        //colorFn: (ClicksPerYear clickData, _) => clickData.color,
        data: dataBar,
      ),
    ];

    var barchart = charts.BarChart(
      series,
      animate: true,
    );

    var piechart = charts.PieChart(
      series,
      animate: true,
      defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()])
    );

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      "${widget.icon}",
                      height: 25,
                      width: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${widget.name}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                //todo : align with other assets
                Row(
                  children: <Widget>[
                    Text(
                      "ISIN",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.currency}" " " "${widget.rate}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 200, //MediaQuery.of(context).size.width,
                  height: 45,
                  child: charts.LineChart(
                    <charts.Series<LinearToken, int>>[
                      charts.Series<LinearToken, int>(
                        id: '${widget.name}',
                        colorFn: (_, __) => widget.color,
                        domainFn: (LinearToken sales, _) => sales.day,
                        measureFn: (LinearToken sales, _) => sales.value,
                        data: data,
                      )
                    ],
                    defaultRenderer: charts.LineRendererConfig(
                      includeArea: true,
                      stacked: true,
                    ),
                    animate: true,
                    primaryMeasureAxis: charts.NumericAxisSpec(
                      renderSpec: charts.NoneRenderSpec(),
                    ),
                    domainAxis: charts.NumericAxisSpec(
//                showAxisLine: true,
                      renderSpec: charts.NoneRenderSpec(),
                    ),
                  ),
                ),
                Container(
                  width: 200, //MediaQuery.of(context).size.width,
                  height: 200,
                  child: barchart,
                ),
                Container(
                  width: 200, //MediaQuery.of(context).size.width,
                  height: 200,
                  child: piechart,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(" "),
                Text(
                  r"(0.3%) $21.67",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[400],
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

class LinearToken {
  final int day;
  final int value;

  LinearToken(this.day, this.value);
}
