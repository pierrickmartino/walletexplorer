import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:snack/snack.dart';

import '../../util/const.dart';
import '../../util/data.dart';
import '../widgets/position.dart';
import '../widgets/overview_total_inflows.dart';
import '../widgets/overview_total_outflows.dart';
import '../../core/models/statistic.dart';
import '../../core/viewmodels/CRUDModel.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final SnackBar bar =
      SnackBar(content: Text('Statistics data updated for this account !'));

  void initAggregatedStatisticsData() {
    //Future<List<Transaction>> transactions;
    Future<List<Statistic>> statistics;

    final int thisYear = DateTime.now().year;

    final CRUDModel firebaseProvider =
        Provider.of<CRUDModel>(context, listen: false);

    for (var i = thisYear; i > thisYear - nbYearForStatisticsDepth; i--) {
      statistics = firebaseProvider.fetchStatisticsByYear(i.toInt().toString());

      statistics.then((value) => value.forEach((element) {
            double creditCounterYear = 0.00;
            double debitCounterYear = 0.00;
            creditCounterYear = value.fold(
                0, (previousValue, element) => previousValue + element.credit);

            debitCounterYear = value.fold(
                0, (previousValue, element) => previousValue + element.debit);

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
    final CRUDModel firebaseProvider = Provider.of<CRUDModel>(context);
    firebaseProvider
        .getStatisticById('STAT_ALL_YEAR_2019')
        .then((value) => currentStatistic = value)
        .catchError((error) {
      print(error);
    });

    return FutureBuilder(
        future: firebaseProvider.getStatisticById('STAT_ALL_YEAR_2019'),
        builder: (context, snapshot) {
          return Scaffold(
              body: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  OverviewTotalInflows(
                    totalInflow: currentStatistic.credit ?? 0.0,
                  ),
                  OverviewTotalOutflows(
                    totalOutflow: currentStatistic.debit ?? 0.0,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          accountsRoute,
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
