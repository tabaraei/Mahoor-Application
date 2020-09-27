import 'package:flutter/material.dart';
import 'package:share/share.dart';
import '../../services/services.dart';
import '../../template/theme.dart';
import '../../template/background_page.dart';

class Poem extends StatefulWidget {
  final String id;
  Poem({this.id});

  @override
  _PoemState createState() => _PoemState();
}

class _PoemState extends State<Poem> {
  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  var poem;

  @override
  void initState() {
    super.initState();
    if (widget.id != null)
      _getPoem();
    else
      _getPoemOfDay();
  }

  _getPoem() async {
    var p = await getPoem(widget.id, key);
    if (p != null)
      setState(() {
        poem = p;
      });
  }

  _getPoemOfDay() async {
    var p = await getPoemOfDay(key);
    if (p != null)
      setState(() {
        poem = p;
      });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      key: key,
      width: MediaQuery.of(context).size.width * 0.7,
      title: widget.id == null ? 'شعر روز' : '',
      backgroundImage: 'assets/images/SavedPoem.png',
      content: poem == null
          ? Container()
          : ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                // poet title
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(30, 50, 30, 20),
                  child: Text(
                    poem['poet']['nickname'] +
                        ' - ' +
                        poem['format'] +
                        ' ' +
                        poem['number'].toString(),
                    style: TextStyle(
                      fontFamily: 'AdobeArabic',
                      color: red,
                      fontSize: 30,
                    ),
                  ),
                ),

                // sections
                Column(
                  children: List.generate(poem['sections'].length, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        poem['sections'][index]['text'],
                        style: TextStyle(
                          fontFamily: 'IranYekanFN',
                          fontSize: 16,
                          color: greyDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }),
                ),

                // buttons
                Container(
                  height: 45,
                  margin: EdgeInsets.only(bottom: 50, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 55,
                        child: Builder(
                          builder: (context) => FlatButton(
                            onPressed: () => savePoem(
                                (widget.id != null) ? widget.id : poem['id'],
                                context),
                            color: green,
                            child: Text(
                              'ذخیره شعر',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'IranYekanFNMedium',
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 55,
                        child: FlatButton(
                          onPressed: () {
                            String text = '';
                            for (var section in poem['sections']) {
                              text += section['text'] + '\n';
                            }
                            Share.share(text);
                          },
                          color: green,
                          child: Text(
                            'اشتراک گذاری',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'IranYekanFNMedium',
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
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
