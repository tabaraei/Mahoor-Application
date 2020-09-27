import 'package:flutter/material.dart';
import 'package:mahoor/screens/saved_poem/saved_poem.dart';
import 'package:share/share.dart';
import '../template/theme.dart';
import '../template/routes.dart';
import '../widgets/logo.dart';

var drawerItems = [
  {
    'title': 'صفحه اصلی',
    'icon': 'assets/images/IconHome.png',
    'route': null,
  },
  {
    'title': 'حساب کاربری',
    'icon': 'assets/images/IconAccount.png',
    'route': EditProfileRoute,
  },
  {
    'title': 'شعر روز',
    'icon': 'assets/images/IconDailyPoem.png',
    'route': PoemRoute,
  },
  {
    'title': 'شعرهای مورد علاقه',
    'icon': 'assets/images/IconSavedPoem.png',
    'route': SavedPoemRoute,
  },
  {
    'title': 'درباره ما',
    'icon': 'assets/images/IconAboutUs.png',
    'route': AboutUsRoute,
  },
  {
    'title': 'معرفی برنامه به دوستان',
    'icon': 'assets/images/IconShare.png',
    'route': 'share',
  }
];

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: drawerItems.length + 1,
        itemBuilder: (context, index) {
          return index == 0
              ? DrawerHeader(
                  child: Logo(
                    margin: EdgeInsets.all(0),
                  ),
                )
              : DrawerItem(
                  title: drawerItems[index - 1]['title'],
                  icon: drawerItems[index - 1]['icon'],
                  route: drawerItems[index - 1]['route'],
                );
        },
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title, icon, route;

  DrawerItem({
    @required this.title,
    @required this.icon,
    @required this.route,
  });

  share() {
    Share.share('check out our application https://example.com');
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'IRANYekanFNMedium',
          fontSize: 18,
          color: greyDark,
        ),
      ),
      leading: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        child: Image.asset(
          icon,
          height: 26,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        if (route == 'share')
          share();
        else if (route == PoemRoute)
          Navigator.pushNamed(context, PoemRoute, arguments: {'PoemID': null});
        else if (route != null) Navigator.pushNamed(context, route);
      },
    );
  }
}

// the one with background

// Stack(
//   children: <Widget>[
//     Align(
//       alignment: Alignment.bottomLeft,
//       child: Image.asset(
//         'assets/images/Menu.png',
//         height: MediaQuery.of(context).size.height * 0.6,
//       ),
//     ),
//     ListView.builder(
//       physics: BouncingScrollPhysics(),
//       itemCount: drawerItems.length + 1,
//       itemBuilder: (context, index) {
//         return index == 0
//             ? DrawerHeader(
//                 child: Logo(
//                   margin: EdgeInsets.all(0),
//                 ),
//               )
//             : DrawerItem(
//                 title: drawerItems[index - 1]['title'],
//                 icon: drawerItems[index - 1]['icon'],
//                 route: drawerItems[index - 1]['route'],
//               );
//       },
//     ),
//   ],
// ),
