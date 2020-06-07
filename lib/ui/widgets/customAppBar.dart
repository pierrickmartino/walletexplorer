import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

//import '../../util/const.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  final String year;

  final ValueChanged<String> parentAction;

  CustomAppBar({
    Key key,
    @required this.height,
    this.title,
    this.year,
    this.parentAction,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    String _value = widget.year ?? '';

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          color: Theme.of(context).backgroundColor,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.title != 'Overview'
                      ? IconButton(
                          iconSize: 24,
                          color: Theme.of(context).cursorColor,
                          icon: Icon(
                            MaterialCommunityIcons.arrow_left,
                            size: 24,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      : Text(''),

                  // IconButton(
                  //   icon: Icon(MaterialCommunityIcons.alpha_w_circle_outline),
                  //   iconSize: 24,
                  //   color: Theme.of(context).dividerColor,
                  //   onPressed: () {},
                  // ),
                ],
              ),
              widget.title == 'Overview'
                  ? DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                      value: _value,
                      items: <DropdownMenuItem<String>>[
                        new DropdownMenuItem(
                          child: new Text('2020'),
                          value: '2020',
                        ),
                        new DropdownMenuItem(
                          child: new Text('2019'),
                          value: '2019',
                        ),
                        new DropdownMenuItem(
                          child: new Text('2018'),
                          value: '2018',
                        ),
                      ],
                      onChanged: (String value) {
                        setState(() {
                          _value = value;
                          widget.parentAction(value);
                        });
                      },
                    ))
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      child: Text(
                        _value,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
              // Text(
              //   title,
              //   style: TextStyle(
              //       fontSize: 20, color: Theme.of(context).cursorColor),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  (widget.title != 'Overview' && widget.title != 'Settings')
                      ? IconButton(
                          icon: Icon(MaterialCommunityIcons.table_search),
                          iconSize: 24,
                          color: Theme.of(context).cursorColor,
                          onPressed: () {},
                        )
                      : Text(''),
                  // widget.title != 'Settings'
                  //     ? IconButton(
                  //         icon: Icon(MaterialCommunityIcons.settings),
                  //         iconSize: 24,
                  //         color: Theme.of(context).cursorColor,
                  //         onPressed: () {
                  //           Navigator.pushNamed(context, settingsRoute);
                  //         },
                  //       )
                  //     : Text(''),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
