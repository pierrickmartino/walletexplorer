import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';
import 'package:snack/snack.dart';

import '../../core/models/transaction.dart';
import '../../core/viewmodels/CRUDModel.dart';
import '../../ui/widgets/customAppBar.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<String> avatars = [
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F4.jpg?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F6.jpg?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F7.jpg?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2Fdev_damodar.jpg?alt=media&token=aaf47b41-3485-4bab-bcb6-2e472b9afee6',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2Fdev_sudip.jpg?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2Fdev_sid.png?alt=media',
  ];

  final SnackBar bar = SnackBar(
      content: Text('Firestore Database is now perfectly clean. Well done !'));

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  void cleanDateFormatInDatabase() {
    Future<List<Transaction>> transactions;

    final CRUDModel transactionProvider =
        Provider.of<CRUDModel>(context, listen: false);

    transactions = transactionProvider.fetchTransactions();

    transactions.then((value) => value.forEach((element) async {
          element.sortAccountingDate = DateTime.parse(
              element.accountingDate.substring(6, 10) +
                  '-' +
                  element.accountingDate.substring(3, 5) +
                  '-' +
                  element.accountingDate.substring(0, 2));
          await transactionProvider.updateTransaction(element, element.id);
        }));

    /* TODO - Bug on bar snap display (Scaffold.of) */
    //transactions.whenComplete(() => bar.show(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(height: 70, title: 'Settings'),
      body: Theme(
        data: Theme.of(context).copyWith(),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Theme.of(context).textTheme.headline1.color,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(avatars[1]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Jane Doe",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            "Nepal",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline2.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ListTile(
                  title: Text(
                    "Languages",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline2.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "English US",
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Profile Settings",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline2.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Jane Doe",
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                  ),
                  onTap: () {},
                ),
                SwitchListTile(
                  title: Text(
                    "Enable Dark Mode",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline2.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "On",
                  ),
                  value: Theme.of(context).brightness == Brightness.dark
                      ? true
                      : false,
                  onChanged: (val) {
                    changeBrightness();
                  },
                ),
                SwitchListTile(
                  title: Text(
                    "Email Notifications",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline2.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "On",
                  ),
                  value: true,
                  onChanged: (val) {},
                ),
                ListTile(
                  title: Text(
                    "Clean up data",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline2.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    cleanDateFormatInDatabase();
                  },
                ),
                ListTile(
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline2.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
