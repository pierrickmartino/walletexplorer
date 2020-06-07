import 'package:flutter/material.dart';
import 'package:snack/snack.dart';

import '../../ui/widgets/overview_text_with_title.dart';
import '../../ui/widgets/overview_total_with_title.dart';
import '../../ui/widgets/customAppBar.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final SnackBar bar = SnackBar(
      content: Text('Firestore Database is now perfectly clean. Well done !'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(height: 50, title: 'Test Screen'),
      body: Theme(
        data: Theme.of(context).copyWith(),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Theme.of(context).textTheme.headline1.color,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Test de Headline 1',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      'Test de Headline 2',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      'Test de Headline 3',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      'Test de Headline 4',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      'Test de Headline 5',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      'Test de Headline 6',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      'Test de Subtitle 1',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      'Test de Subtitle 2',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      'Test de Body Text 1',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      'Test de Body Text 2',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    FlatButton(
                        onPressed: () {
                          bar.show(context);
                        },
                        child: Text('Snack Bar')),
                    IconButton(icon: Icon(Icons.computer), onPressed: null),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OverviewTextWithTitle(
                      text: 'Text',
                      title: 'Year',
                      subtitle: 'subtitle',
                      amountColor: Theme.of(context).cursorColor,
                    ),
                    OverviewTotalWithTitle(
                      amount: 999999.0,
                      evolution: -99.0,
                      title: 'Year',
                      subtitle: 'subtitle',
                      amountColor: Theme.of(context).cursorColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
