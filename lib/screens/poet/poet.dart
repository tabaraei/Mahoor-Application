import 'package:flutter/material.dart';
import '../../template/background_page.dart';
import '../../template/theme.dart';
import '../../services/services.dart';
import '../../template/routes.dart';

class Poet extends StatefulWidget {
  final String id;
  Poet({this.id});

  @override
  _PoetState createState() => _PoetState();
}

class _PoetState extends State<Poet> {
  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  var poetDetails;

  @override
  void initState() {
    super.initState();
    _getPoet();
  }

  _getPoet() async {
    var poet = await getPoet(widget.id, key);
    if (poet != null)
      setState(() {
        poetDetails = poet;
      });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      key: key,
      width: MediaQuery.of(context).size.width * 0.7,
      title: poetDetails == null ? '' : poetDetails['name'],
      backgroundImage: 'assets/images/Poet.png',
      content: poetDetails == null
          ? Container()
          : ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                // Avatar Image
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width * 0.4,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: CircleAvatar(
                          backgroundImage:
                              Image.network(poetDetails['image_url']).image,
                        ),
                      ),
                    ],
                  ),
                ),

                // Text poet details
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    poetDetails['description'],
                    style: TextStyle(
                      fontFamily: 'IRANYekanFN',
                      fontSize: 16,
                      color: greyDark,
                    ),
                  ),
                ),

                // books list
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  child: Column(
                    children:
                        List.generate(poetDetails['books'].length, (index) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          BookRoute,
                          arguments: {
                            'BookID': poetDetails['books'][index]['id']
                          },
                        ),
                        child: Container(
                          margin: EdgeInsets.only(right: 30, top: 20),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Image.asset(
                                  'assets/images/flower.png',
                                  width: 20,
                                ),
                              ),
                              Text(
                                poetDetails['books'][index]['name'],
                                style: TextStyle(
                                  color: red,
                                  fontSize: 18,
                                  fontFamily: 'IRANYekanFNBold',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
    );
  }
}
