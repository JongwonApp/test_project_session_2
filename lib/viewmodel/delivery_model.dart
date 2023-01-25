import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project_session_2/repository/delivery_repository.dart';
import 'package:test_project_session_2/repository/order_repository.dart';
import 'package:test_project_session_2/repository/shop_repository.dart';

class DeliveryModel with ChangeNotifier {
  var currentDelivery;
  bool isLoading = false;
  bool deliveryCheck = false;
  final _deliveryRepository = DeliveryRepository();
  final _orderRepository = OrderRepository();
  final _shopRepository = ShopRepository();

  DeliveryModel() {
    fetch();
  }

  driverData() async {
    var prefs = await SharedPreferences.getInstance();
    var driver = jsonDecode(prefs.getString('user')!);
    return driver;
  }

  fetch() async {
    isLoading = true;
    notifyListeners();

    var driver = await driverData();
    try {
      var cd = await _deliveryRepository.fetch(driver['id']);
      var shopData = await _shopRepository.fetch(cd['shopId']);
      var productData = await _deliveryRepository.productData(cd['deliveryId']);
      var historyData = cd['deliveryStatus'] == 0 ? {} : await _deliveryRepository.historyData(driver['id'], cd['deliveryStatus']);
      currentDelivery =     {
        "driver": driver,
        "currentDelivery": cd,
        "shopData": shopData,
        "shop": shopData['name'],
        "productData": productData,
        "historyData": historyData
      };
    } catch (e) {
      deliveryCheck = true;
    }

    isLoading = false;
    notifyListeners();
  }

  setDeliveryHistory(data) async {
    await _deliveryRepository.setDeliveryHistory(data);
    fetch();
  }

  getDeliveryHistory(int status) async {
    var driver = await driverData();
    var currentStatus = currentDelivery["currentDelivery"]["deliveryStatus"];
    if(currentStatus >= status) {
      var historyData = await _deliveryRepository.historyData(driver['id'], status);
      switch(status) {
        case 1: historyData['status'] = "배송 준비 중"; break;
        case 2: historyData['status'] = "배송 시작"; break;
        case 3: historyData['status'] = "배송 중"; break;
        case 4: historyData['status'] = "배송 완료"; break;
        default: historyData['status'] = '';
      }
      return {"type": "view", "history": historyData};
    } else if(currentStatus + 1 == status) {
      return {"type": "input"};
    } else {
      return {"type": false};
    }
  }

  setOrder(orderId) async {
    deliveryCheck = false;
    await _orderRepository.setOrder(orderId);
    fetch();
  }
}