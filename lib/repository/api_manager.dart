import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiManager {
  static Future get(String url, [parameter]) async {
    url = '$url?$parameter';
    final response = await http.get(Uri.parse(url));
    if(response.statusCode != 200) return null;
    var result = jsonDecode(utf8.decode(response.bodyBytes));
    return result;
  }

  static Future post(String url, data) async {
    final response = await http.post(
      Uri.parse(url),
      headers: { "Content-Type": "application/json" },
      body: jsonEncode(data),
    );
    if(response.statusCode != 200) return null;
    var res = jsonDecode(utf8.decode(response.bodyBytes));
    return res;
  }
}