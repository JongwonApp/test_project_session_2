import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project_session_2/style.dart' as style;
import 'package:test_project_session_2/viewmodel/delivery_model.dart';

Future<void> inputDialog(context, data) async {
  TextEditingController _contentController = TextEditingController();

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context_) {
      var deliveryModel = Provider.of<DeliveryModel>(context);
      late String titleText;
      late String holderText;
      DateTime date = DateTime.now();
      switch(data['currentDelivery']['deliveryStatus']) {
        case 1: titleText = "배송 시작"; holderText = "기사님이 지금 막! 배송을 시작했습니다."; break;
        case 2: titleText = "배송 중"; holderText = "기사님이 열심히 배송 중 입니다!"; break;
        case 3: titleText = "배송 완료"; holderText = "기사님이 귀하의 매장에 배송을 완료했습니다."; break;
        default: titleText = "배송 준비 중"; holderText = "상품 포장 후 배송 시작하겠습니다."; break;
      }
      return AlertDialog(
        title: Row(children: [
          Text(titleText, style: TextStyle(fontWeight: FontWeight.bold, color: style.primaryColor)),
          Text(' 상태 업데이트', style: TextStyle(fontWeight: FontWeight.bold))]),
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
                  Text(date.toString().substring(0,16).replaceAll('T', ' '), style: TextStyle(color: Color(0xFF1111aa), fontWeight: FontWeight.bold))
                ]),
                SizedBox(height: 16),
                Text("한 줄 Comment", style: TextStyle(fontSize: 14)),
                TextField(
                  controller: _contentController,
                  decoration: InputDecoration(hintText: holderText, hintStyle: TextStyle(fontSize: 14))
                ),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(onPressed: () async {
            var inputData = {
              "deliveryId": data['currentDelivery']['deliveryId'],
              "deliveryStatus": data['currentDelivery']['deliveryStatus'] + 1,
              "date": date.toIso8601String(),
              "content": _contentController.text == '' ? holderText : _contentController.text
            };
            await deliveryModel.setDeliveryHistory(inputData);
            Navigator.of(context).pop();
          }, style: ElevatedButton.styleFrom(backgroundColor: style.primaryColor), child: Text('업데이트')),
          ElevatedButton(onPressed: () => Navigator.of(context).pop(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: Text('닫기'))
        ],
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}