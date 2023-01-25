import 'package:test_project_session_2/repository/api_manager.dart';

class LoginApi {
  final BASE_URL = "http://221.147.131.71:9797";

  Future loginAction(String uid, String pwd) async {
    var res = await ApiManager.post("$BASE_URL/api/Driver/Login", {"uid": uid, "pwd": pwd});
    print(res);
    return res;
  }
}