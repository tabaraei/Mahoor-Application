import 'package:flutter/material.dart';

const orange = Color(0xfff69f53);
const green = Color(0xff2c7265);
const red = Color(0xffd96459);
const greyDark = Color(0xff414141);
const greyMedium = Color(0xff515151);
const greyLight = Color(0xff979393);
const splashColor = Color(0xffeeeeee);

var theme = ThemeData(
  primaryColor: orange,
  splashColor: splashColor,
  textTheme: TextTheme(
    body1: TextStyle(
      fontSize: 14,
      fontFamily: 'IranYekanFNMedium',
      color: greyDark,
      height: 2,
    ),
  ),
);
