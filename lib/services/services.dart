import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../widgets/snackbar.dart';

const url = "https://mahur.tempserver.ir";
String userName;
String phoneNumber;
String accessToken;
String refreshToken;
var poets;

keyboardUnfocus(context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  print(currentFocus);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

getLocalData(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

setLocalData(key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

deleteLocalData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

getAccessToken(key, context) async {
  try {
    var response = await http
        .post(url + "/api/token/refresh/", body: {"refresh": refreshToken});
    var result = jsonDecode(utf8.decode(response.bodyBytes));

    if (result["code"] == "token_not_valid") {
      return 'login';
    } else {
      accessToken = result['access'];
      print('token after refreshing:');
      print(accessToken);
      await setLocalData('accessToken', accessToken);
      return true;
    }
  } catch (error) {
    showSnackKey(key, "خطا در ارتباط با سرور");
    return false;
  }
}

getUserInfo() async {
  userName = await getLocalData('userName');
  phoneNumber = await getLocalData('phoneNumber');
  print(userName);
  print(phoneNumber);
}

entranceStatus() async {
  print('entered');
  await getUserInfo();
  await getPoets();
  print('in poetse');
  print(poets);

  accessToken = await getLocalData('accessToken');
  print('access: ');
  print(accessToken);
  refreshToken = await getLocalData('refreshToken');
  print('refresh: ');
  print(refreshToken);
}

// ---------------------------------------------------------------
register(name, phone, context) async {
  if (name == "" || phone == "") {
    showSnack(context, "لطفا نام و شماره تلفن خود را وارد کنید");
    return false;
  } else {
    try {
      var response = await http.post(url + "/api/users/register/",
          body: {"first_name": name, "phone_number": phone});
      var result = jsonDecode(utf8.decode(response.bodyBytes));
      print(result);

      if (result == "Verification code was sent successfully") {
        userName = name;
        phoneNumber = phone;
        return true;
      } else if (result == "User with this phone number already exists") {
        showSnack(context, "کاربری با این شماره تلفن در سیستم ثبت شده‌است");
        return false;
      } else {
        showSnack(context, "شماره وارد شده صحیح نیست");
        return false;
      }
    } catch (error) {
      showSnack(context, "خطا در ارتباط با سرور");
      return false;
    }
  }
}

login(phone, context) async {
  if (phone == "") {
    showSnack(context, "لطفا شماره تلفن خود را وارد کنید");
    return false;
  } else {
    try {
      var response = await http
          .post(url + "/api/users/login/", body: {"phone_number": phone});

      var result = jsonDecode(utf8.decode(response.bodyBytes));
      print("LOGIN" + result);
      if (result == "Verification code was sent successfully") {
        phoneNumber = phone;
        return true;
      } else if (result == "There is no user with this phone number") {
        showSnack(context, "کاربری با این شماره تلفن پیدا نشد");
        return false;
      } else {
        showSnack(context, "شماره وارد شده صحیح نیست");
        return false;
      }
    } catch (error) {
      showSnack(context, "خطا در ارتباط با سرور");
      return false;
    }
  }
}

editProfile(name, context) async {
  if (name == "") {
    showSnack(context, "لطفا نام خود را وارد کنید");
  } else {
    try {
      var response = await http.post(
        url + "/api/users/edit-profile/",
        body: {"first_name": name},
        headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
      );

      var result = jsonDecode(utf8.decode(response.bodyBytes));
      print('EDIT_PROFILE');
      print(result);
      if (result == 'User profile edited successfully') {
        showSnack(context, "نام کاربری با موفقیت تغییر یافت");
        await setLocalData('userName', name);
        userName = name;
      } else if (result['detail'] ==
          'Given token not valid for any token type') {
        showSnack(context, "خطا در تغییر نام کاربری");
        Key key;
        getAccessToken(key, context);
      } else {
        showSnack(context, "خطا در تغییر نام کاربری");
      }
    } catch (error) {
      showSnack(context, "خطا در ارتباط با سرور");
    }
  }
}

verify(otp, context) async {
  if (otp == "") {
    showSnack(context, "لطفا کد تایید را وارد کنید");
    return false;
  } else {
    try {
      var response = await http.post(url + "/api/users/verify/",
          body: {"otp": otp, "phone_number": phoneNumber});
      var result = jsonDecode(utf8.decode(response.bodyBytes));

      if (result == "Invalid OTP code") {
        showSnack(context, "کد وارد شده صحیح نیست");
        return false;
      } else {
        userName = result['first_name'];
        phoneNumber = result['phone_number'];
        accessToken = result['token']['access'];
        refreshToken = result['token']['refresh'];

        await setLocalData('userName', userName);
        await setLocalData('phoneNumber', phoneNumber);
        await setLocalData('accessToken', accessToken);
        await setLocalData('refreshToken', refreshToken);

        return true;
      }
    } catch (error) {
      showSnack(context, "خطا در ارتباط با سرور");
      return false;
    }
  }
}

// ---------------------------------------------------------------------
getPoets() async {
  try {
    var response = await http.get(url + "/api/poets/");
    var result = jsonDecode(utf8.decode(response.bodyBytes));
    poets = result['result'];
  } catch (error) {
    poets = [];
  }
}

getPoet(id, key) async {
  try {
    var response = await http.get(url + "/api/poets/$id/");
    var result = jsonDecode(utf8.decode(response.bodyBytes));
    return result;
  } catch (error) {
    showSnackKey(key, "خطا در ارتباط با سرور");
    return null;
  }
}

getBook(id, key) async {
  try {
    var response = await http.get(url + "/api/books/$id/");
    var result = jsonDecode(utf8.decode(response.bodyBytes));
    return result;
  } catch (error) {
    showSnackKey(key, "خطا در ارتباط با سرور");
    return null;
  }
}

getChapter(id, key) async {
  try {
    var response = await http.get(url + "/api/chapters/$id/");
    var result = jsonDecode(utf8.decode(response.bodyBytes));
    print(result);
    return result;
  } catch (error) {
    showSnackKey(key, "خطا در ارتباط با سرور");
    return null;
  }
}

getPoem(id, key) async {
  try {
    var response = await http.get(url + "/api/poems/$id/");
    var result = jsonDecode(utf8.decode(response.bodyBytes));
    print(result);
    return result;
  } catch (error) {
    showSnackKey(key, "خطا در ارتباط با سرور");
    return null;
  }
}

getPoemOfDay(key) async {
  try {
    var response = await http.get(url + "/api/poem-of-day/");
    var result = jsonDecode(utf8.decode(response.bodyBytes));
    print(result);
    return result;
  } catch (error) {
    showSnackKey(key, "خطا در ارتباط با سرور");
    return null;
  }
}

savePoem(id, context) async {
  try {
    print(id);
    var response = await http.post(
      url + "/api/users/add-saved-poem/",
      body: {"id": id.toString()},
      headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
    );

    print(response);

    var result = jsonDecode(utf8.decode(response.bodyBytes));
    print('savePoem');
    print(result);
    if (result == 'Poem successfully added to user saved poem') {
      showSnack(context, "به شعرهای ذخیره‌شده افزوده شد");
    } else if (result == 'Poem with this id has already saved for this user') {
      showSnack(context, 'این شعر قبلا ذخیره شده‌است');
    } else if (result['detail'] == 'Given token not valid for any token type') {
      showSnack(context, "خطا در ذخیره شعر");
      Key key;
      getAccessToken(key, context);
    } else {
      showSnack(context, "خطا در ذخیره شعر");
    }
  } catch (error) {
    showSnack(context, "خطا در ارتباط با سرور");
  }
}

getSavedPoem(key) async {
  try {
    var response = await http.get(
      url + "/api/users/saved-poems",
      headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
    );
    var result = jsonDecode(utf8.decode(response.bodyBytes));
    print(result);
    return result;
  } catch (error) {
    showSnackKey(key, "خطا در ارتباط با سرور");
    return null;
  }
}
