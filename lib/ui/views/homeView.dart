import 'package:flutter/material.dart';

import '../screens/overview.dart';
import '../screens/header.dart';
import '../widgets/customAppBar.dart';
import '../../util/const.dart';
import '../../core/services/authentication.dart';

class HomeView extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String year;

  HomeView({Key key, this.auth, this.userId, this.logoutCallback, this.year})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String settingYear = '2019';

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  _updateSettingYear(String year) {
    setState(() {
      settingYear = year;
    });
  }

  @override
  void initState() {
    super.initState();
    settingYear = widget.year ?? defaultYeartoDisplay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          height: 50,
          title: 'Overview',
          parentAction: _updateSettingYear,
          year: settingYear),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50,
            child: Header(),
          ),
          Divider(
            height: 20,
            thickness: 1,
          ),
          Expanded(
            child: Overview(
              year: settingYear,
            ),
          )
        ],
      ),
    );
  }
}
