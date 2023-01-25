import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project_session_2/view/widget/app_bar.dart';
import 'package:test_project_session_2/view/widget/drawer.dart';
import 'package:test_project_session_2/viewmodel/delivery_model.dart';
import 'package:test_project_session_2/viewmodel/order_model.dart';

class ViewOrderScreen extends StatelessWidget {
  const ViewOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderModel = Provider.of<OrderModel>(context);
    var deliveryModel = Provider.of<DeliveryModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavDrawer(),
      appBar: app_bar,
      body: RefreshIndicator(
        onRefresh: () async {
          await orderModel.fetch();
        },
        child: Column(children: [
          Expanded(child: orderModel.isLoading ? Center(child: CircularProgressIndicator())
              : ListView.builder(shrinkWrap: true, itemCount: orderModel.orderList.length, itemBuilder: (c, i) {
            return Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Icon(Icons.calendar_today_rounded, size: 14), Text(' req. Date: '),
                    Text((orderModel.orderList[i]['reqDate'].substring(0,16)).replaceAll('T', ' '), style: TextStyle(color: Colors.blue))
                  ]),
                  Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text(orderModel.orderList[i]['shop']['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                  Row(children: [Icon(Icons.vaccines_outlined, size: 11), SizedBox(width: 8), Text(orderModel.orderList[i]['shop']['address'], style: TextStyle(fontSize: 11))]),
                  Row(children: [Icon(Icons.maps_home_work, size: 11), SizedBox(width: 8), Text(orderModel.orderList[i]['shop']['contact'], style: TextStyle(fontSize: 11))]),
                  SizedBox(height: 16),
                  Text(orderModel.orderList[i]['memo'], style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ElevatedButton(onPressed: () {
                      if(!deliveryModel.deliveryCheck) return;
                      showDialog(context: context, builder: (BuildContext context_) {
                        return AlertDialog(
                          content: Text("정말로 ${orderModel.orderList[i]['shop']['name']}의 발주 요청건을 진행하시겠습니까?"),
                          actions: [
                            TextButton(onPressed: () async {
                              deliveryModel.setOrder(orderModel.orderList[i]['orderId']);
                              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                            }, child: Text('진행')),
                            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('닫기', style: TextStyle(color: Colors.grey),))
                          ],
                        );
                      });
                    }, style: ElevatedButton.styleFrom(padding: EdgeInsets.fromLTRB(30, 15, 30, 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text('GET!'))
                  ]),
                ]),
              ),
            );
          })),
        ]),
      ),
    );
  }
}
