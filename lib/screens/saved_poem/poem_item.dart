import 'package:flutter/material.dart';
import '../../template/theme.dart';
import '../../template/routes.dart';

class PoemItem extends StatelessWidget {
  final String poemName, date, text, id;

  PoemItem({
    @required this.poemName,
    @required this.date,
    @required this.text,
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        PoemRoute,
        arguments: {'PoemID': id},
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // box decoration
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  blurRadius: 20, // has the effect of softening the shadow
                  spreadRadius: 1, // has the effect of extending the shadow
                  offset: Offset(
                    4, // horizontal, move right 10
                    10, // vertical, move down 10
                  ),
                )
              ],
            ),

            // content
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // poem name
                    Text(
                      poemName,
                      style: TextStyle(
                        color: green,
                        fontFamily: 'IranYekanFN',
                        fontSize: 14,
                      ),
                    ),
                    // date
                    Text(
                      date,
                      style: TextStyle(
                        color: greyLight,
                        fontFamily: 'IranYekanFN',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                // poem text
                Text(
                  text,
                  style: TextStyle(
                    color: greyDark,
                    fontFamily: 'IranYekanFN',
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
