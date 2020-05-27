import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../util/const.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;

  const CustomAppBar({
    Key key,
    @required this.height,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title != 'Overview'
                  ? IconButton(
                      iconSize: 24,
                      color: Theme.of(context).cursorColor,
                      icon: Icon(MaterialCommunityIcons.arrow_left),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  : Text(''),
              // Text(
              //   title,
              //   style: TextStyle(
              //       fontSize: 20, color: Theme.of(context).cursorColor),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title != 'Overview'
                      ? IconButton(
                          icon: Icon(MaterialCommunityIcons.table_search),
                          iconSize: 24,
                          color: Theme.of(context).cursorColor,
                          onPressed: () {},
                        )
                      : Text(''),
                  IconButton(
                    icon: Icon(MaterialCommunityIcons.settings),
                    iconSize: 24,
                    color: Theme.of(context).cursorColor,
                    onPressed: () {
                      Navigator.pushNamed(context, settingsRoute);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
