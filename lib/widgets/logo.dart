import 'package:flutter/material.dart';
import '../template/theme.dart';

class Logo extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  Logo({this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        children: <Widget>[
          Text(
            'ماهور',
            style: TextStyle(
              color: green,
              fontWeight: FontWeight.w700,
              fontFamily: 'AdobeArabic',
              fontSize: 60,
            ),
            textAlign: TextAlign.center,
          ),
          Image.asset(
            'assets/images/IconMahoor.png',
            width: MediaQuery.of(context).size.width * 0.2,
          ),
        ],
      ),
    );
  }
}
