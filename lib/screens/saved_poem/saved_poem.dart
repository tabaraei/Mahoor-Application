import 'package:flutter/material.dart';
import 'poem_item.dart';
import '../../template/background_page.dart';
import '../../services/services.dart';

class SavedPoem extends StatefulWidget {
  @override
  _SavedPoemState createState() => _SavedPoemState();
}

class _SavedPoemState extends State<SavedPoem> {
  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  var savedPoems;

  @override
  void initState() {
    super.initState();
    _getSavedPoem();
  }

  _getSavedPoem() async {
    var poems = await getSavedPoem(key);
    print(poems);
    if (poems != null)
      setState(() {
        savedPoems = poems;
      });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      key: key,
      width: MediaQuery.of(context).size.width * 0.5,
      backgroundImage: 'assets/images/SavedPoem.png',
      alignment: Alignment.bottomLeft,
      title: 'شعرهای ذخیره شده',
      content: savedPoems == null
          ? Container()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: savedPoems['result'].length,
              itemBuilder: (context, index) {
                return PoemItem(
                  poemName: savedPoems['result'][index]['poet'] +
                      ' - ' +
                      savedPoems['result'][index]['format'] +
                      ' ' +
                      savedPoems['result'][index]['poem_number'].toString(),
                  date: savedPoems['result'][index]['date_saved'],
                  text: savedPoems['result'][index]['first_hemistich'],
                  id: savedPoems['result'][index]['poem_id'],
                );
              },
            ),
    );
  }
}
