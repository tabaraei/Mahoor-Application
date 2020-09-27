import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../template/theme.dart';
import '../../template/background_page.dart';
import '../../widgets/textformfield.dart';
import '../../services/services.dart';
import '../../template/routes.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController, phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: userName);
    phoneController = TextEditingController(text: phoneNumber);
  }

  _editProfile(context) async {
    keyboardUnfocus(context);
    await editProfile(
      nameController.text,
      context,
    );
  }

  _exit(context) async {
    keyboardUnfocus(context);
    await deleteLocalData();
    Navigator.pushNamedAndRemoveUntil(context, SplashRoute, (route) => false);
  }

  _showAlertDialog(context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        'برگشت',
        style: TextStyle(
          color: green,
          fontSize: 14,
          fontFamily: 'IranYekanFNMedium',
        ),
      ),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = FlatButton(
      child: Text(
        'ادامه',
        style: TextStyle(
          color: green,
          fontSize: 14,
          fontFamily: 'IranYekanFNMedium',
        ),
      ),
      onPressed: () => _exit(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      elevation: 0,
      contentPadding: EdgeInsets.all(30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        'خروج از حساب کاربری',
        style: TextStyle(
          color: green,
          fontSize: 16,
          fontFamily: 'IranYekanFNMedium',
        ),
      ),
      content: Text(
        'آیا می‌خواهید از اکانت خود خارج شوید؟',
        style: TextStyle(
          color: greyMedium,
          fontSize: 14,
          fontFamily: 'IranYekanFNMedium',
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      backgroundImage: 'assets/images/Account.png',
      title: 'ویرایش حساب کاربری',
      width: MediaQuery.of(context).size.width * 0.8,
      alignment: Alignment.bottomRight,
      content: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MyTextField(
                  label: 'نام',
                  controller: nameController,
                  type: TextInputType.text,
                  icon: FontAwesomeIcons.user,
                ),
                MyTextField(
                  label: 'شماره تلفن',
                  controller: phoneController,
                  type: TextInputType.phone,
                  icon: FontAwesomeIcons.phone,
                  enabled: false,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 55,
                    child: Builder(
                      builder: (context) => FlatButton(
                        onPressed: () => _editProfile(context),
                        color: green,
                        child: Text(
                          'ثبت تغییرات',
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
                    child: FlatButton(
                      onPressed: () => _showAlertDialog(context),
                      child: Text(
                        'خروج از حساب کاربری',
                        style: TextStyle(
                          color: greyMedium,
                          fontSize: 14,
                          fontFamily: 'IranYekanFNMedium',
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      splashColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
