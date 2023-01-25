import 'package:test_project_session_2/repository/api_manager.dart';

class ShopRepository {
  final BASE_URL = "http://221.147.131.71:9797";
  Future fetch(shopId) async {
    var res = await ApiManager.get('$BASE_URL/api/Convenience', 'shopId=$shopId');
    return res;
  }
}