import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project_session_2/user/login_api.dart';

class LoginModel with ChangeNotifier {
  bool loginCheck = false;
  bool loginFail = false;
  final loginApi = LoginApi();

  LoginModel() {
    login();
  }

  static logout() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('uid');
    prefs.remove('user');
  }


  void login() async {
    var prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('uid');
    if(id != null) {
      loginCheck = true;
    }
    notifyListeners();
  }

  Future loginAction(uid, pwd) async {
    var driver = await loginApi.loginAction(uid, pwd);
    print(driver);
    if(driver == null) {
      loginFail = true;
      notifyListeners();
      return;
    }
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
    prefs.setString('user', jsonEncode(driver));
    login();
  }

}