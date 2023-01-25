import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project_session_2/view/widget/alert_dialog.dart';
import 'package:test_project_session_2/view/widget/app_bar.dart';
import 'package:test_project_session_2/view/widget/drawer.dart';
import 'package:test_project_session_2/view/widget/input_dialog.dart';
import 'package:test_project_session_2/viewmodel/delivery_model.dart';
import 'package:test_project_session_2/style.dart' as style;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var deliveryModel = Provider.of<DeliveryModel>(context);
    return Scaffold(
      drawer: NavDrawer(),
      appBar: app_bar,
      body: deliveryModel.isLoading ? Center(child: CircularProgressIndicator()) : Column(children: [
        currentDelivery(context),
        deliveryList(deliveryModel.currentDelivery, deliveryModel.deliveryCheck),
      ],),
    );
  }

  Widget currentDelivery(context) {
    var deliveryModel = Provider.of<DeliveryModel>(context);
    var data = deliveryModel.currentDelivery;

    void openDialog(int type) async {
      var historyData = await deliveryModel.getDeliveryHistory(type);
      historyData['type'] == "view" ? viewDialog(context, data, historyData['history']) : inputDialog(context, data);
    }

    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: deliveryModel.deliveryCheck ? Center(child: Column(children: [
              Text("배송 정보가 없습니다."),
              GestureDetector(onTap: () => Navigator.pushNamed(context, '/view/order'), child: Text("배송 업무 할당 받기", style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline))),
            ])) : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(data['shopData']['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 4),
            Row(children: [Icon(Icons.icecream, size: 13), Text(' ${data['shopData']['address']},', style: TextStyle(fontSize: 12))]),
            Row(children: [Icon(Icons.phone, size: 13), Text(' ${data['shopData']['contact']}', style: TextStyle(fontSize: 12))]),
            SizedBox(height: 16),
            Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                onTap: () => openDialog(1),
                child: CircleAvatar(radius: 24, backgroundColor: data['currentDelivery']['deliveryStatus'] >= 1 ? style.primaryColor : Colors.grey, child: data['currentDelivery']['deliveryStatus'] >= 1 ? Icon(Icons.check, color: Colors.white) : null),
              ),

              Flexible(fit: FlexFit.loose, child: Container(width: 60, height: 2, color: data['currentDelivery']['deliveryStatus'] >= 2 ? style.primaryColor : Colors.grey)),
              GestureDetector(
                onTap: () => openDialog(2),
                child: CircleAvatar(radius: 24, backgroundColor: data['currentDelivery']['deliveryStatus'] >= 2 ? style.primaryColor : Colors.grey, child: data['currentDelivery']['deliveryStatus'] >= 2 ? Icon(Icons.check, color: Colors.white) : null),
              ),

              Flexible(fit: FlexFit.loose, child: Container(width: 60, height: 2, color: data['currentDelivery']['deliveryStatus'] >= 3 ? style.primaryColor : Colors.grey)),
              GestureDetector(
                onTap: () => openDialog(3),
                child: CircleAvatar(radius: 24, backgroundColor: data['currentDelivery']['deliveryStatus'] >= 3 ? style.primaryColor : Colors.grey, child: data['currentDelivery']['deliveryStatus'] >= 3 ? Icon(Icons.check, color: Colors.white) : null),
              ),

              Flexible(fit: FlexFit.loose, child: Container(width: 60, height: 2, color: data['currentDelivery']['deliveryStatus'] >= 4 ? style.primaryColor : Colors.grey)),
              GestureDetector(
                onTap: () => openDialog(4),
                child: CircleAvatar(radius: 24, backgroundColor: data['currentDelivery']['deliveryStatus'] >= 4 ? style.primaryColor : Colors.grey, child: data['currentDelivery']['deliveryStatus'] >= 4 ? Icon(Icons.check, color: Colors.white) : null),
              ),
            ],),
            SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("배송\n준비중", textAlign: TextAlign.center, style: TextStyle(height: 1.125)),
              Text("배송 시작", textAlign: TextAlign.center),
              Text("배송 중", textAlign: TextAlign.center),
              Text("배송 완료", textAlign: TextAlign.center),
            ],),
          ]),
        )
      ),
    );
  }

  Widget deliveryList(data, deliveryCheck) {
    final ScrollController _scrollController = ScrollController();
    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        padding: EdgeInsets.fromLTRB(8,0,8,8),
        child: Card(
            elevation: 5,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: deliveryCheck ? Center(child: Text('배송 정보가 없습니다.')) : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("배송 제품 목록", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 8),
                  Flexible(
                    fit: FlexFit.loose,
                    child: SizedBox(height: 1000, child: Scrollbar(
                      controller: _scrollController,
                      isAlwaysShown: true,
                      interactive: true,
                      trackVisibility: true,
                      radius: Radius.circular(4),
                      thickness:15,
                      child: ListView.builder(shrinkWrap:true, controller: _scrollController, itemCount: data['productData'].length, itemBuilder: (c, i) {
                        return ListTile(
                          leading: Text('No\n${i + 1}', textAlign: TextAlign.center),
                          title: Text(data['productData'][i]['name']),
                          subtitle: Text(data['productData'][i]['model']),
                        );
                      }),
                    )),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}

