import 'package:flutter/material.dart';
import 'package:test_project_session_2/style.dart' as style;

Future<void> viewDialog(context, data, history) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(children: [Text(history['status'], style: TextStyle(fontWeight: FontWeight.bold, color: style.primaryColor)), Text(' 상태 보기', style: TextStyle(fontWeight: FontWeight.bold))]),
        content: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(data['shopData']['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 4),
                Row(children: [Icon(Icons.icecream, size: 10), Text(' ${data['shopData']['address']},', style: TextStyle(fontSize: 10))]),
                Row(children: [Icon(Icons.phone, size: 10), Text(' ${data['shopData']['contact']},', style: TextStyle(fontSize: 10))]),
                SizedBox(height: 16),
                Row(children: [
                  Icon(Icons.calendar_today_rounded, color: Color(0xFF1111aa)),
                  SizedBox(width: 8),
                  Text(history['date'].substring(0,16).replaceAll('T', ' '), style: TextStyle(color: Color(0xFF1111aa), fontWeight: FontWeight.bold))
                ]),
                SizedBox(height: 16),
                Text("한 줄 Comment", style: TextStyle(fontSize: 14)),
                Text(history['content'], style: TextStyle(color: Color(0xFF1111aa)))
              ],
            ),
          ),
        ),
        actions: [ElevatedButton(onPressed: () => Navigator.of(context).pop(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: Text('닫기'))],
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}