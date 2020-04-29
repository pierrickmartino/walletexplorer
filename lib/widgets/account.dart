import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';

class Account extends StatefulWidget {
  final String name;
  final String icon;
  final String rate;
  final String currency;
  final charts.Color color;
  Account({Key key, this.name, this.icon, this.rate, this.color, this.currency})
      : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _AccountState extends State<Account> {
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

  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  @override
  Widget build(BuildContext context) {
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;

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
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
      ),
    );

    var piechart = charts.PieChart(series,
        animate: true,
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));

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
          Container(
            height: 300,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: ListView(
              //padding: const EdgeInsets.all(20.0),
              scrollDirection: Axis.horizontal,
              //shrinkWrap: true,
              children: <Widget>[
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  //color: const Color(0xff2c4260),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      //mainAxisAlignment: MainAxisAlignment.start,
                      //mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Transactions',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'state',
                              style: TextStyle(
                                  color: Color(0xff77839a), fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BarChart(
                              BarChartData(
                                maxY: 20,
                                barTouchData: BarTouchData(
                                    touchTooltipData: BarTouchTooltipData(
                                      tooltipBgColor: Colors.grey,
                                      getTooltipItem: (_a, _b, _c, _d) => null,
                                    ),
                                    touchCallback: (response) {
                                      if (response.spot == null) {
                                        setState(() {
                                          touchedGroupIndex = -1;
                                          showingBarGroups =
                                              List.of(rawBarGroups);
                                        });
                                        return;
                                      }

                                      touchedGroupIndex =
                                          response.spot.touchedBarGroupIndex;

                                      setState(() {
                                        if (response.touchInput
                                                is FlLongPressEnd ||
                                            response.touchInput is FlPanEnd) {
                                          touchedGroupIndex = -1;
                                          showingBarGroups =
                                              List.of(rawBarGroups);
                                        } else {
                                          showingBarGroups =
                                              List.of(rawBarGroups);
                                          if (touchedGroupIndex != -1) {
                                            double sum = 0;
                                            for (BarChartRodData rod
                                                in showingBarGroups[
                                                        touchedGroupIndex]
                                                    .barRods) {
                                              sum += rod.y;
                                            }
                                            final avg = sum /
                                                showingBarGroups[
                                                        touchedGroupIndex]
                                                    .barRods
                                                    .length;

                                            showingBarGroups[
                                                    touchedGroupIndex] =
                                                showingBarGroups[
                                                        touchedGroupIndex]
                                                    .copyWith(
                                              barRods: showingBarGroups[
                                                      touchedGroupIndex]
                                                  .barRods
                                                  .map((rod) {
                                                return rod.copyWith(y: avg);
                                              }).toList(),
                                            );
                                          }
                                        }
                                      });
                                    }),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: SideTitles(
                                    showTitles: true,
                                    textStyle: TextStyle(
                                        color: const Color(0xff7589a2),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    margin: 20,
                                    getTitles: (double value) {
                                      switch (value.toInt()) {
                                        case 0:
                                          return 'Mn';
                                        case 1:
                                          return 'Te';
                                        case 2:
                                          return 'Wd';
                                        case 3:
                                          return 'Tu';
                                        case 4:
                                          return 'Fr';
                                        case 5:
                                          return 'St';
                                        case 6:
                                          return 'Sn';
                                        default:
                                          return '';
                                      }
                                    },
                                  ),
                                  leftTitles: SideTitles(
                                    showTitles: true,
                                    textStyle: TextStyle(
                                        color: const Color(0xff7589a2),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    margin: 32,
                                    reservedSize: 14,
                                    getTitles: (value) {
                                      if (value == 0) {
                                        return '1K';
                                      } else if (value == 10) {
                                        return '5K';
                                      } else if (value == 19) {
                                        return '10K';
                                      } else {
                                        return '';
                                      }
                                    },
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                barGroups: showingBarGroups,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Graph 2'),
                    ),
                    Container(
                      width: 300,
                      height: 220,
                      child: barchart,
                    ),
                  ],
                )),
                Card(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Graph 3'),
                    ),
                    Container(
                      width: 300,
                      height: 220,
                      child: piechart,
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: leftBarColor,
        width: width,
      ),
      BarChartRodData(
        y: y2,
        color: rightBarColor,
        width: width,
      ),
    ]);
  }
}

class LinearToken {
  final int day;
  final int value;

  LinearToken(this.day, this.value);
}
