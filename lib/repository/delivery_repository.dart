import 'package:test_project_session_2/repository/api_manager.dart';

class DeliveryRepository {
  final BASE_URL = "http://221.147.131.71:9797";

  Future fetch(driverId) async {
    var res = await ApiManager.get("$BASE_URL/api/Delivery", "driverId=$driverId");
    return res;
  }

  Future productData(deliveryId) async {
    var res = await ApiManager.get('$BASE_URL/api/Delivery/products', 'deliveryId=$deliveryId');
    return res;
  }

  Future historyData(driverId, deliveryStatus) async {
    var res = await ApiManager.get('$BASE_URL/api/DeliveryHistory', 'driverId=$driverId&deliveryStatus=$deliveryStatus');
    return res;
  }

  Future setDeliveryHistory(data) async {
    var res = await ApiManager.post('$BASE_URL/api/DeliveryHistory', data);
    return res;
  }
}