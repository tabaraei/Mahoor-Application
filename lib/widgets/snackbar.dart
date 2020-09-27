import 'package:flutter/material.dart';
import '../template/theme.dart';

showSnack(context, text) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'IranYekanFN',
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: green,
      duration: Duration(seconds: 2),
    ),
  );
}

showSnackKey(GlobalKey<ScaffoldState> key, text) {
  key.currentState.showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'IranYekanFN',
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: green,
      duration: Duration(seconds: 2),
    ),
  );
}
