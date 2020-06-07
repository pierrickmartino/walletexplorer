import 'package:flutter/material.dart';
import 'package:walletexplorer/ui/screens/accounts.dart';
import 'package:walletexplorer/ui/screens/settings.dart';
import 'package:walletexplorer/ui/screens/test_screen.dart';
import 'package:walletexplorer/ui/screens/transactions.dart';
import 'package:walletexplorer/util/data.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../screens/overview.dart';
// import '../screens/header.dart';
// import '../widgets/customAppBar.dart';
import '../../util/const.dart';
import '../../core/services/authentication.dart';
// import '../../ui/router.dart';

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
  int _selectedIndex = 0;

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    settingYear = widget.year ?? defaultYeartoDisplay;
  }

  Widget _showContent(int _selectedIndex) {
    switch (_selectedIndex) {
      case 0:
        return Overview(
          year: '2019',
        );
        break;
      case 1:
        return Accounts();
      case 2:
        return Transactions();
      case 3:
        return Settings();
      case 4:
        return TestScreen();
      default:
        return Overview(
          year: '2019',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //     height: 100,
      //     title: 'Overview',
      //     parentAction: _updateSettingYear,
      //     year: settingYear),
      body: Row(
        children: <Widget>[
          NavigationRail(
            elevation: 8.0,
            leading: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/cm${random.nextInt(10)}.jpeg",
                  ),
                  radius: 35,
                ),
              ),
            ),

            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(
                  Feather.bar_chart_2,
                  size: 30,
                ),
                selectedIcon: Icon(
                  Feather.bar_chart_2,
                  size: 30,
                ),
                label: Text('Overview'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Feather.credit_card,
                  size: 30,
                ),
                selectedIcon: Icon(
                  Feather.credit_card,
                  size: 30,
                ),
                label: Text('Account'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Feather.list,
                  size: 30,
                ),
                selectedIcon: Icon(
                  Feather.list,
                  size: 30,
                ),
                label: Text('Transaction'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Feather.settings,
                  size: 30,
                ),
                selectedIcon: Icon(
                  Feather.settings,
                  size: 30,
                ),
                label: Text('Settings'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Feather.code,
                  size: 30,
                ),
                selectedIcon: Icon(
                  Feather.code,
                  size: 30,
                ),
                label: Text('Test'),
              ),
            ],
            // trailing: Expanded(
            //   child: Column(
            //     children: [
            //       IconButton(
            //           icon: Icon(MaterialCommunityIcons.logout),
            //           onPressed: signOut),
            //     ],
            //   ),
            // ),
          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: _showContent(
                _selectedIndex), //Text('selectedIndex: $_selectedIndex'),
          )
        ],
      ),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: <Widget>[
      //     Container(
      //       height: 60,
      //       child: Header(),
      //     ),
      //     Expanded(
      //       child: Overview(
      //         year: settingYear,
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
