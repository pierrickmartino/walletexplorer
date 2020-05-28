import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:snack/snack.dart';
import 'package:date_format/date_format.dart';

import '../../util/const.dart';
import '../../util/data.dart';
import '../widgets/position.dart';
import '../widgets/overview_total_with_title.dart';
import '../widgets/overview_text_with_title.dart';
import '../../core/models/statistic.dart';
import '../../core/viewmodels/CRUDModel.dart';

class Overview extends StatefulWidget {
  final String year;

  const Overview({Key key, this.year}) : super(key: key);

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final SnackBar bar =
      SnackBar(content: Text('Statistics data updated for this account !'));

  Statistic currentStatistic =
      Statistic(lastUpdatedDate: DateTime(1900, 1, 1), credit: 0.0, debit: 0.0);

  void initAggregatedStatisticsData() {
    //Future<List<Transaction>> transactions;
    Future<List<Statistic>> statistics;

    final int thisYear = DateTime.now().year;

    final CRUDModel firebaseProvider =
        Provider.of<CRUDModel>(context, listen: false);

    for (int i = thisYear; i > thisYear - nbYearForStatisticsDepth; i--) {
      String key = 'STAT_ALL_YEAR_' + i.toString();
      firebaseProvider.removeStatistic(key);
    }

    for (int i = thisYear; i > thisYear - nbYearForStatisticsDepth; i--) {
      statistics = firebaseProvider.fetchStatisticsByYear(i.toString());

      statistics.then((value) => value.forEach((element) {
            double creditCounterYear = 0.00;
            double debitCounterYear = 0.00;
            creditCounterYear = value.fold(
                0, (previousValue, element) => previousValue + element.credit);

            debitCounterYear = value.fold(
                0, (previousValue, element) => previousValue + element.debit);

            /* on last iteration */
            if (value.last.id == element.id) {
              // print('total Credit ' +
              //     i.toString() +
              //     ': ' +
              //     creditCounterYear.roundToDouble().toString());
              // print('total Debit ' +
              //     i.toString() +
              //     ': ' +
              //     debitCounterYear.roundToDouble().toString());

              String key = 'STAT_ALL_YEAR_' + i.toString();
              Statistic statistic = Statistic(
                  id: key,
                  code: 'YEAR',
                  bank: '',
                  credit: creditCounterYear.roundToDouble(),
                  debit: debitCounterYear.roundToDouble(),
                  currency: '',
                  month: '',
                  product: '',
                  quarter: '',
                  relation: '',
                  year: i.toString(),
                  lastUpdatedDate: DateTime.now());

              firebaseProvider.setStatistic(statistic, key);
            }
          }));
    }

    bar.show(context);
  }

  @override
  Widget build(BuildContext context) {
    final CRUDModel firebaseProvider = Provider.of<CRUDModel>(context);
    firebaseProvider
        .getStatisticById('STAT_ALL_YEAR_' + widget.year)
        .then((value) => currentStatistic = value)
        .catchError((error) {
      print(error);
    });

    return FutureBuilder(
        future:
            firebaseProvider.getStatisticById('STAT_ALL_YEAR_' + widget.year),
        builder: (context, snapshot) {
          return Scaffold(
              body: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: OverviewTextWithTitle(
                      text: widget.year,
                      title: 'Year',
                      subtitle: '',
                      amountColor: Theme.of(context).cursorColor,
                      /* TODO */
                    ),
                  ),
                  Expanded(
                    child: OverviewTotalWithTitle(
                      amount: (currentStatistic.credit ?? 0.0) -
                          (currentStatistic.debit ?? 0.0),
                      title: 'Evolution',
                      subtitle: 'per year',
                      amountColor: ((currentStatistic.credit ?? 0.0) -
                                  (currentStatistic.debit ?? 0.0) >
                              0.0)
                          ? (Theme.of(context).accentColor)
                          : (Theme.of(context).bottomAppBarColor),
                      /* TODO */
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: OverviewTotalWithTitle(
                      amount: currentStatistic.credit ?? 0.0,
                      title: 'Total in',
                      subtitle: 'per year',
                      amountColor: Theme.of(context).accentColor,
                    ),
                  ),
                  Expanded(
                    child: OverviewTotalWithTitle(
                      amount: currentStatistic.debit ?? 0.0,
                      title: 'Total out',
                      subtitle: 'per year',
                      amountColor: Theme.of(context).bottomAppBarColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        formatDate(currentStatistic.lastUpdatedDate, [
                          yyyy,
                          '-',
                          mm,
                          '-',
                          dd,
                          ' ',
                          HH,
                          ':',
                          nn,
                          ':',
                          ss
                        ]),
                        style: TextStyle(
                            fontSize: 12, color: const Color(0xff7589a2)),
                      ),
                    ),
                  ),
                  FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          accountsRoute,
                          arguments: widget.year,
                        );
                      },
                      child: Text('see all accounts')),
                  IconButton(
                    icon: Icon(MaterialCommunityIcons.refresh),
                    tooltip: 'Refresh statistics data',
                    onPressed: () {
                      initAggregatedStatisticsData();
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
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
        });
  }
}
