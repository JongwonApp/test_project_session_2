import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project_session_2/repository/api_manager.dart';

class OrderRepository {
  final BASE_URL = "http://221.147.131.71:9797";
  Future fetch() async {
    var res = await ApiManager.get('$BASE_URL/api/Orders');
    return res;
  }

  Future setOrder(orderId) async {
    var prefs = await SharedPreferences.getInstance();
    var driver = jsonDecode(prefs.getString('user')!);
    var data = {"orderId" : orderId, "driverId" : driver['id']};
    var res = await ApiManager.post('$BASE_URL/api/Orders', data);
    return res;
  }
}