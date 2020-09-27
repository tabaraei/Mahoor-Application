import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../template/routes.dart';
import '../../template/theme.dart';
import '../../widgets/logo.dart';
import '../../template/background_page.dart';
import '../../widgets/textformfield.dart';
import '../../services/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  _login(context) async {
    bool result = await login(
      phoneController.text,
      context,
    );
    if (result) Navigator.pushNamed(context, VerificationRoute);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      backgroundImage: 'assets/images/Account.png',
      title: '',
      width: MediaQuery.of(context).size.width * 0.8,
      alignment: Alignment.bottomRight,
      content: Column(
        children: <Widget>[
          Expanded(
            child: Logo(),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MyTextField(
                  label: 'شماره تلفن',
                  controller: phoneController,
                  type: TextInputType.phone,
                  icon: FontAwesomeIcons.phone,
                ),
              ],
            ),
          ),
          Expanded(
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
                        onPressed: () => _login(context),
                        color: green,
                        child: Text(
                          'ثبت‌نام',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
