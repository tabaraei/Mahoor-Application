import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../template/theme.dart';
import '../../widgets/logo.dart';
import 'poet_item.dart';
import '../../template/background_page.dart';
import '../../widgets/textformfield.dart';
import '../../services/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  var filteredPoets;

  @override
  void initState() {
    filteredPoets = [];
    (poets.length > 0) ? filteredPoets.addAll(poets) : filteredPoets = [];
    super.initState();
  }

  filterPoets(value) {
    print(value);
    var dummySearchList = [];
    dummySearchList.addAll(poets);
    if (value.isNotEmpty) {
      var dummyListData = [];
      dummySearchList.forEach((item) {
        if (item['name'].startsWith(value)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredPoets.clear();
        filteredPoets.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredPoets.clear();
        filteredPoets.addAll(poets);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      backgroundImage: 'assets/images/HomePage.png',
      title: '',
      drawer: true,
      width: double.infinity,
      content: Column(
        children: <Widget>[
          // mahoor logo
          Logo(
            margin: EdgeInsets.only(bottom: 20),
          ),

          // search textfield
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: MyTextField(
              label: 'جستجو',
              icon: FontAwesomeIcons.search,
              controller: searchController,
              type: TextInputType.text,
              onChanged: (value) => filterPoets(value),
            ),
          ),

          // orange Logo
          Image.asset(
            'assets/images/IconMahoorOrange.png',
            height: MediaQuery.of(context).size.height / 20,
          ),

          // header text poet
          Align(
            alignment: Alignment.center,
            child: Text(
              'شاعران',
              style: TextStyle(
                fontFamily: 'IranYekanFNBold',
                fontSize: 20,
                color: orange,
              ),
            ),
          ),

          // poet name
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: filteredPoets.length,
              itemBuilder: (context, index) {
                if (filteredPoets.length > 0) {
                  return PoetItem(
                    id: filteredPoets[index]['id'].toString(),
                    poetName: filteredPoets[index]['name'],
                    picture: filteredPoets[index]['image_url'],
                  );
                } else
                  return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
