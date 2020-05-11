import 'package:flutter/material.dart';

import '../screens/overview.dart';
import '../../core/services/authentication.dart';
import '../screens/header.dart';
import '../widgets/customAppBar.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(height: 80, title: 'Overview'),
      body: Column(
        children: <Widget>[
          Container(
            height: 60,
            child: Header(),
          ),
          Divider(
            height: 20,
            thickness: 1,
          ),
          Expanded(
            child: Overview(),
          )
        ],
      ),
    );
  }
}
