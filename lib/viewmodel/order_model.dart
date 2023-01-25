import 'package:flutter/material.dart';
import 'package:test_project_session_2/repository/order_repository.dart';
import 'package:test_project_session_2/repository/shop_repository.dart';

class OrderModel with ChangeNotifier {
  var orderList = [];
  bool isLoading = false;
  final _orderRepository = OrderRepository();
  final _shopRepository = ShopRepository();
  OrderModel() {
    fetch();
  }

  fetch() async {
    isLoading = true;
    notifyListeners();

    var orders = await _orderRepository.fetch();
    for(var i = 0; i < orders.length; i++) {
      var shop = await _shopRepository.fetch(orders[i]['shopId']);
      orders[i]['shop'] = shop;
    }
    orderList = orders;
    isLoading = false;
    notifyListeners();
  }
}