import 'package:flutter/material.dart';
var app_bar = AppBar(
  title: Row(children: [
    Image.asset('assets/app_icon.png', height: 30),
    SizedBox(width: 8),
    Text('SU 편의점 물류')
  ]),
);