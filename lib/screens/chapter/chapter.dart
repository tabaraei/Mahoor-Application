import 'package:flutter/material.dart';
import 'package:mahoor/services/services.dart';
import '../../template/routes.dart';
import '../../template/background_page.dart';
import '../../widgets/bullet_text.dart';

class Chapter extends StatefulWidget {
  final String id;
  Chapter({this.id});

  @override
  _ChapterState createState() => _ChapterState();
}

class _ChapterState extends State<Chapter> {
  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  var chapterDetails;

  @override
  void initState() {
    super.initState();
    _getChapter();
  }

  _getChapter() async {
    var chapter = await getChapter(widget.id, key);
    if (chapter != null)
      setState(() {
        chapterDetails = chapter;
      });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      key: key,
      width: MediaQuery.of(context).size.width * 0.7,
      title: chapterDetails == null ? '' : chapterDetails['name'],
      backgroundImage: 'assets/images/Poet.png',
      content: chapterDetails == null
          ? Container()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: chapterDetails['poems'].length,
              itemBuilder: (context, index) {
                return BulletText(
                  text: chapterDetails['poems'][index]['format'],
                  id: chapterDetails['poems'][index]['id'].toString(),
                  argsName: 'PoemID',
                  route: PoemRoute,
                );
              },
            ),
    );
  }
}
