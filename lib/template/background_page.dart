import 'package:flutter/material.dart';
import '../services/services.dart';
import 'menu.dart';
import 'theme.dart';

class BackgroundPage extends StatelessWidget {
  final Widget content;
  final String title;
  final bool secondImage;
  final String backgroundImage, secondBackgroundImage;
  final Alignment alignment, secondAlignment;
  final double width;
  final bool drawer;
  final GlobalKey<ScaffoldState> key;

  BackgroundPage({
    @required this.content,
    @required this.backgroundImage,
    @required this.width,
    @required this.title,
    this.alignment = Alignment.topLeft,
    this.secondImage = false,
    this.secondBackgroundImage = 'assets/images/AboutUsBottom.png',
    this.secondAlignment = Alignment.bottomRight,
    this.drawer = false,
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => keyboardUnfocus(context),
      child: Scaffold(
        key: key,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,

        // app bar preference
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: greyMedium),
          title: Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'IranYekanFNMedium',
                fontSize: 14,
                color: greyMedium,
              ),
            ),
          ),
        ),

        // drawer prefernce
        drawer: drawer ? Menu() : null,

        // body
        body: Stack(
          children: <Widget>[
            // background image
            Align(
              alignment: alignment,
              child: Image.asset(
                backgroundImage,
                width: width,
              ),
            ),

            secondImage
                ? Align(
                    alignment: secondAlignment,
                    child: Image.asset(
                      secondBackgroundImage,
                      width: width,
                    ),
                  )
                : Container(),

            SafeArea(child: content),
          ],
        ),
      ),
    );
  }
}
