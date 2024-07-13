import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NodeApi{
  static const int timeout = 20;
  static const String url="http://192.168.1.16:3000";

  static Future<Map<String, dynamic>> addDistance(Map<String,dynamic> data)async{
    return await _sendRequest("post","add-travel", data);
  }

  static Future<Map<String, dynamic>> getUserData(String uid)async{
    return await _sendRequest("get","user/$uid", {});
  }


  static Future<Map<String, dynamic>> _sendRequest(
      String method, String endpoint, Map<String, dynamic> data) async {
    try {
      //var token = await LocalStorage.getToken();
      var link = Uri.parse('$url/$endpoint');
      var jsonData = jsonEncode(data);
      var headers = {
        'Content-Type': 'application/json',
        //'Authorization': token == null ? "" : "Bearer ${token.toString()}"
      };
      late http.Response response;
      switch (method.toLowerCase()) {
        case "post":
          response = await http
              .post(link, headers: headers, body: jsonData)
              .timeout(const Duration(seconds: timeout));
          break;
        case "get":
          response = await http
              .get(
            link,
            headers: headers,
          )
              .timeout(const Duration(seconds: timeout));
          break;
        case "put":
          response = await http
              .put(link, headers: headers, body: jsonData)
              .timeout(const Duration(seconds: timeout));
          break;
        case "delete":
          response = await http
              .delete(link, headers: headers, body: jsonData)
              .timeout(const Duration(seconds: timeout));
          break;
        default:
          throw Exception('NOT SUPPORTED METHOD : $method');
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body.toString());
      } else {
        return jsonDecode(response.body.toString());
      }
    } on FormatException catch (e) {
      print('Erreur de format: $e');
      return {"type": "error", "message": "FormatException: ${e.message}"};
    } on TimeoutException catch (e) {
      print('Erreur de timeout: $e');
      return {"type": "error", "message": "Erreur de serveur"};
    } catch (e) {
      print('Autre erreur: $e');
      return {"type": "error", "message": e.toString()};
    }
  }
}