import 'package:flutter/material.dart';
import '../../template/theme.dart';
import '../../template/routes.dart';

class PoetItem extends StatelessWidget {
  final String poetName, picture, id;

  PoetItem({
    @required this.poetName,
    @required this.picture,
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        PoetRoute,
        arguments: {'PoetID': id},
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // box decoration
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  blurRadius: 20, // has the effect of softening the shadow
                  spreadRadius: 1, // has the effect of extending the shadow
                  offset: Offset(
                    2, // horizontal, move right 10
                    5, // vertical, move down 10
                  ),
                )
              ],
            ),

            // content
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // poet name
                Flexible(
                  child: Text(
                    poetName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: greyMedium,
                      fontFamily: 'IranYekanFNMedium',
                      fontSize: 16,
                    ),
                  ),
                ),

                // Avatar Image
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: green,
                    ),
                    shape: BoxShape.circle,
                  ),
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: CircleAvatar(
                    backgroundImage: Image.network(picture).image,
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
