import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:snack/snack.dart';

import '../../util/const.dart';
import '../../ui/widgets/account_header.dart';
import '../../core/models/transaction.dart';
import '../../core/models/statistic.dart';
import '../../core/viewmodels/CRUDModel.dart';

class AccountUI extends StatefulWidget {
  final String name;
  final String icon;
  final double balance;
  final double totalInflow;
  final double totalOutflow;
  final String currency;
  final String depositary;
  final String shortname;
  final charts.Color color;
  AccountUI(
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

class LinearToken {
  final int day;
  final int value;

  LinearToken(this.day, this.value);
}

class _AccountState extends State<AccountUI> {
  static Random random = Random();
  final List<LinearToken> data = [
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

  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  final SnackBar bar =
      SnackBar(content: Text('Statistics data updated for this account !'));

  double findTotalInFlowByAccount(String name) {
    Future<List<Statistic>> statistics;

    final CRUDModel firebaseProvider =
        Provider.of<CRUDModel>(context, listen: false);

    double credit = 0.0;

    statistics = firebaseProvider.fetchStatisticsByAccountByCode(name, 'YEAR');
    statistics.then((value) {
      credit = value.singleWhere((element) => element.year == '2019').credit;
      print(name);
      print(credit);
      return credit;
    });

    print(credit);
    return credit;
    //return credit;
  }

  void initStatisticsData(String account) {
    Future<List<Transaction>> transactions;

    final int thisYear = DateTime.now().year;

    final CRUDModel firebaseProvider =
        Provider.of<CRUDModel>(context, listen: false);

    for (var i = thisYear; i > thisYear - nbYearForStatisticsDepth; i--) {
      transactions = firebaseProvider.fetchTransactionsByAccountByDateRange(
          account, DateTime(i, 1, 1), DateTime(i + 1, 1, 1));

      transactions.then((value) => value.forEach((element) {
            double creditCounterYear = 0.00;
            double debitCounterYear = 0.00;
            creditCounterYear = value.fold(
                0,
                (previousValue, element) =>
                    previousValue + element.creditAmount);

            debitCounterYear = value.fold(
                0,
                (previousValue, element) =>
                    previousValue + element.debitAmount);

            /* on last iteration */
            if (value.last.id == element.id) {
              print('total Credit ' +
                  i.toString() +
                  ': ' +
                  creditCounterYear.roundToDouble().toString());
              print('total Debit ' +
                  i.toString() +
                  ': ' +
                  debitCounterYear.roundToDouble().toString());

              String key = 'STAT_' + account + '_YEAR_' + i.toString();
              Statistic statistic = Statistic(
                  id: key,
                  code: 'YEAR',
                  bank: '',
                  credit: creditCounterYear.roundToDouble(),
                  debit: debitCounterYear.roundToDouble(),
                  currency: '',
                  month: '',
                  product: account,
                  quarter: '',
                  relation: '',
                  year: i.toString(),
                  lastUpdatedDate: DateTime.now());

              firebaseProvider.removeStatistic(key);
              firebaseProvider.setStatistic(statistic, key);
            }
          }));
    }

    bar.show(context);
  }

  Statistic currentStatistic = Statistic();

  @override
  Widget build(BuildContext context) {
    BarChartGroupData makeGroupData(int x, double y1, double y2) {
      return BarChartGroupData(barsSpace: 4, x: x, barRods: [
        BarChartRodData(
          y: y1,
          color: Theme.of(context).accentColor,
          width: width,
        ),
        BarChartRodData(
          y: y2,
          color: Theme.of(context).bottomAppBarColor,
          width: width,
        ),
      ]);
    }

    final BarChartGroupData barGroup1 = makeGroupData(0, 5, 12);
    final BarChartGroupData barGroup2 = makeGroupData(1, 16, 12);
    final BarChartGroupData barGroup3 = makeGroupData(2, 18, 5);
    final BarChartGroupData barGroup4 = makeGroupData(3, 20, 16);
    final BarChartGroupData barGroup5 = makeGroupData(4, 17, 6);
    final BarChartGroupData barGroup6 = makeGroupData(5, 19, 1.5);
    final BarChartGroupData barGroup7 = makeGroupData(6, 10, 1.5);
    final BarChartGroupData barGroup8 = makeGroupData(7, 5, 4);
    final BarChartGroupData barGroup9 = makeGroupData(8, 12, 4);
    final BarChartGroupData barGroup10 = makeGroupData(9, 20, 10);
    final BarChartGroupData barGroup11 = makeGroupData(10, 18, 12);
    final BarChartGroupData barGroup12 = makeGroupData(11, 4, 9);

    final List<BarChartGroupData> items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
      barGroup8,
      barGroup9,
      barGroup10,
      barGroup11,
      barGroup12,
    ];

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;

    final CRUDModel firebaseProvider = Provider.of<CRUDModel>(context);
    firebaseProvider
        .getStatisticById('STAT_' + widget.name + '_YEAR_2019')
        .then((value) => currentStatistic = value)
        .catchError((error) {
      print(error);
    });

    BarChart barchartpermonth = BarChart(
      BarChartData(
        maxY: 20,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey,
            getTooltipItem: (_a, _b, _c, _d) => null,
          ),
        ),
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
                  return 'j';
                case 1:
                  return 'f';
                case 2:
                  return 'm';
                case 3:
                  return 'a';
                case 4:
                  return 'm';
                case 5:
                  return 'j';
                case 6:
                  return 'j';
                case 7:
                  return 'a';
                case 8:
                  return 's';
                case 9:
                  return 'o';
                case 10:
                  return 'n';
                case 11:
                  return 'd';
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
    );

    return FutureBuilder(
        future: firebaseProvider
            .getStatisticById('STAT_' + widget.name + '_YEAR_2019'),
        builder: (context, snapshot) {
          return Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              children: <Widget>[
                AccountHeader(
                    name: widget.name,
                    icon: widget.icon,
                    balance: widget.balance,
                    currency: widget.currency,
                    depositary: widget.depositary,
                    shortname: widget.shortname,
                    totalInflow: currentStatistic.credit ?? 0.0,
                    totalOutflow: currentStatistic.debit ?? 0.0,
                    color: widget.color),
                Container(
                  height: 300,
                  padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    'Credit/Debit',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const Text(
                                    'per month',
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: barchartpermonth,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // FlatButton(
                    //     onPressed: () {
                    //       Navigator.pushNamed(
                    //         context,
                    //         transactionsRoute,
                    //         arguments: widget.name,
                    //       );
                    //     },
                    //     child: Text('see untyped transactions')),
                    FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            transactionsRoute,
                            arguments: widget.name,
                          );
                        },
                        child: Text('see all transactions')),
                    IconButton(
                      icon: Icon(MaterialCommunityIcons.refresh),
                      tooltip: 'Refresh statistics data',
                      onPressed: () {
                        initStatisticsData(widget.name);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
