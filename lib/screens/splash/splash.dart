import 'package:flutter/material.dart';
import 'dart:async';
import '../../widgets/logo.dart';
import '../../services/services.dart';
import '../../template/routes.dart';
import '../../template/theme.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  String errorText;

  @override
  void initState() {
    // Timer for navigate from splash to home
    errorText = '';
    Timer(
      Duration(seconds: 2),
      () => _entranceStatus(),
    );
    super.initState();
  }

  _entranceStatus() async {
    try {
      await entranceStatus();

      if (accessToken == null) {
        // user authentication required
        Navigator.pushNamedAndRemoveUntil(
            context, SignupRoute, (route) => false);
      } else {
        // user currently authenticated
        var token = await getAccessToken(key, context);

        if (token == 'login')
          Navigator.pushNamedAndRemoveUntil(
              context, SignupRoute, (route) => false);
        else if (token)
          Navigator.pushNamedAndRemoveUntil(
              context, HomeRoute, (route) => false);
        else
          Navigator.pushNamedAndRemoveUntil(
              context, SignupRoute, (route) => false);
      }
    } catch (error) {
      setState(() {
        errorText = 'از اتصال اینترنت خود اطمینان حاصل کنید';
      });
      Timer(
        Duration(seconds: 2),
        () => _entranceStatus(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/Splash.png',
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
          ),
          Logo(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          Text(
            errorText,
            style: TextStyle(
              color: green,
              fontFamily: 'IranYekanFN',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
