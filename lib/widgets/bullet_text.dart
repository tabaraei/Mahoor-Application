import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../template/theme.dart';

class BulletText extends StatelessWidget {
  final String text;
  final String id;
  final String argsName;
  final String route;
  BulletText({this.text, this.id, this.argsName, this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        route,
        arguments: {argsName: id},
      ),
      child: Container(
        height: 45,
        margin: EdgeInsets.fromLTRB(30, 5, 30, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 16, top: 4),
                  child: Icon(
                    FontAwesomeIcons.solidCircle,
                    color: green,
                    size: 10,
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: greyDark,
                    fontFamily: 'IranYekanFN',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Icon(
                FontAwesomeIcons.chevronLeft,
                color: greyLight,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
