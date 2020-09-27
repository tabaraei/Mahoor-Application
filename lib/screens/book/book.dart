import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahoor/services/services.dart';
import '../../template/background_page.dart';
import '../../template/theme.dart';
import '../../template/routes.dart';
import '../../widgets/bullet_text.dart';

class Book extends StatefulWidget {
  final int id;
  Book({this.id});

  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  var bookDetails;

  @override
  void initState() {
    super.initState();
    _getBook();
  }

  _getBook() async {
    var book = await getBook(widget.id, key);
    if (book != null)
      setState(() {
        bookDetails = book;
      });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      key: key,
      width: MediaQuery.of(context).size.width * 0.7,
      title: bookDetails == null ? '' : bookDetails['name'],
      backgroundImage: 'assets/images/Poet.png',
      content: bookDetails == null
          ? Container()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: bookDetails['chapters'].length,
              itemBuilder: (context, index) {
                return BulletText(
                  text: bookDetails['chapters'][index]['name'],
                  id: bookDetails['chapters'][index]['id'].toString(),
                  argsName: 'chapterID',
                  route: ChapterRoute,
                );
              },
            ),
    );
  }
}
