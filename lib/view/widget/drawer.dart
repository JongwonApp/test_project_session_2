import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project_session_2/style.dart' as style;
import 'package:test_project_session_2/viewmodel/login_model.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  var driver;

  @override
  void initState() {
    super.initState();
    getDriver();
  }

  getDriver() async {
    var prefs = await SharedPreferences.getInstance();
    driver = jsonDecode(prefs.getString('user')!);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220,
      backgroundColor: style.primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(driver?['name'] ?? '', style: TextStyle(fontSize: 22, color: Colors.yellow)), SizedBox(width: 4), Text('기사님,', style: TextStyle(fontSize: 16))]),
              Text('오늘도 안전운전! 하세요.', style: TextStyle(fontSize: 16))
            ],),
          ),
          GestureDetector(onTap:() => Navigator.pushNamed(context, '/'), child: ListTile(leading: Icon(Icons.edit, color: Colors.white), title: Text('현재 배송 현황', style: TextStyle(color: Colors.white, fontSize: 18)))),
          GestureDetector(onTap:() => Navigator.pushNamed(context, '/view/order'), child: ListTile(leading: Icon(Icons.list_alt, color: Colors.white), title: Text('배송 요청 목록', style: TextStyle(color: Colors.white, fontSize: 18)))),
          GestureDetector(onTap:() {
            LoginModel.logout();
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          }, child: ListTile(leading: Icon(Icons.not_interested, color: Colors.white), title: Text('로그아웃', style: TextStyle(color: Colors.white, fontSize: 18)))),
          GestureDetector(onTap:() {exit(0);}, child: ListTile(leading: Icon(Icons.window, color: Colors.white), title: Text('종료', style: TextStyle(color: Colors.white, fontSize: 18)))),
        ],
      ),
    );
  }
}
