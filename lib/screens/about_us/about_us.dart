import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../template/theme.dart';
import '../../template/background_page.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      width: MediaQuery.of(context).size.width * 0.9,
      title: 'درباره ما',
      backgroundImage: 'assets/images/AboutUsTop.png',
      alignment: Alignment.topLeft,
      secondImage: true,
      secondBackgroundImage: 'assets/images/AboutUsBottom.png',
      secondAlignment: Alignment.bottomRight,
      content: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // arash web logo
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Image.asset(
                'assets/images/ArashWeb.png',
                width: MediaQuery.of(context).size.width / 4,
              ),
            ),

            // about us text
            Text(
              'شرکـــت «آرش وب»، فـعالیت خـود را از ســال 1395 در حــوزه‌ی طـراحی وب و اپـلیکیشن آغـــاز کــرد.',
              style: TextStyle(
                fontFamily: 'IranYekanFNMedium',
                color: greyMedium,
                fontSize: 16,
              ),
            ),
            Text(
              'در اپلیکیشن «ماهـور» تلاش کردیم تمامی نیازهای افـراد عــلاقه‌مند به حــوزه‌ی شـعر کلاسیک فـارسی را فــراهم کنیم.',
              style: TextStyle(
                fontFamily: 'IranYekanFNMedium',
                color: greyMedium,
                fontSize: 16,
              ),
            ),
            Text(
              'بـرای پیــشرفت و بـهبود هـر چه بـیشتر این بــرنامه مـنتظر پیـشنهادهای شما خواهیم بود.',
              style: TextStyle(
                fontFamily: 'IranYekanFNMedium',
                color: greyMedium,
                fontSize: 16,
              ),
            ),

            // ways to communicate
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'راه های ارتباط با ما',
                style: TextStyle(
                  fontFamily: 'IranYekanFNBold',
                  color: green,
                  fontSize: 18,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'info@arashweb.ir',
                      style: TextStyle(
                        fontFamily: 'IranYekanFNBold',
                        fontSize: 16,
                        color: greyMedium,
                      ),
                    ),
                    Text(
                      'www.arashweb.com',
                      style: TextStyle(
                        fontFamily: 'IranYekanFNBold',
                        fontSize: 16,
                        color: greyMedium,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 8),
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.at,
                        color: green,
                        size: 18,
                      ),
                      Icon(
                        FontAwesomeIcons.globeAsia,
                        color: green,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //  version
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Text(
                'نسخه: 1.11.9',
                style: TextStyle(
                  fontFamily: 'IranYekanFN',
                  fontSize: 14,
                  color: green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
