import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';
import 'package:mahoor/widgets/snackbar.dart';
import '../../template/routes.dart';
import '../../template/background_page.dart';
import '../../template/theme.dart';
import '../../services/services.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  String otp;
  Timer timer;
  int time;
  bool boolean;

  @override
  void initState() {
    super.initState();
    boolean = true;
    time = 60;
  }

  _verify(context) async {
    bool result = await verify(otp, context);
    if (result)
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeRoute,
        (route) => false,
      );
  }

  _requestCodeAgain(context) async {
    bool result = await login(
      phoneNumber,
      context,
    );
    if (!result)
      showSnack(context, 'خطا در ارسال کد فعال‌سازی');
    else {
      showSnack(context, 'کد فعال‌سازی مجددا ارسال شد');
      setState(() {
        boolean = false;
      });
      timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) => setState(() {
          if (time < 1) {
            timer.cancel();
            boolean = true;
            time = 60;
          } else {
            time = time - 1;
          }
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      backgroundImage: 'assets/images/Account.png',
      width: MediaQuery.of(context).size.width * 0.8,
      alignment: Alignment.bottomRight,
      title: '',
      content: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 60),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/verification.png',
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.035),
                          child: Image.asset(
                            'assets/images/IconMahoor.png',
                            width: MediaQuery.of(context).size.width * 0.15,
                            color: greyLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'کد تایید ارسال‌شده به شماره تلفن\n$phoneNumber\nرا در زیر وارد کنید',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'IranYekanFN',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: VerificationCodeInput(
                        length: 4,
                        keyboardType: TextInputType.number,
                        onCompleted: (code) {
                          FocusScope.of(context).unfocus();
                          otp = code;
                        },
                        textStyle: TextStyle(
                          color: orange,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 55,
                    child: Builder(
                      builder: (context) => FlatButton(
                        onPressed: () => _verify(context),
                        color: orange,
                        child: Text(
                          'تایید',
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
                    margin: EdgeInsets.only(top: 10),
                    child: !boolean
                        ? Text(
                            'بعد از $time ثانیه دوباره امتحان کنید',
                            style: TextStyle(
                              color: greyMedium,
                              fontSize: 14,
                              fontFamily: 'IranYekanFNMedium',
                            ),
                          )
                        : Builder(
                            builder: (context) => FlatButton(
                              onPressed: () => _requestCodeAgain(context),
                              child: Text(
                                'درخواست دوباره کد',
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
