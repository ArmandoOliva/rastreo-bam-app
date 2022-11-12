import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  static const String _domain = 'rastreobam.deprueba.shop';

  static Future<http.Response?> getData(
      String endpoint, Map<String, dynamic> args) async {
    try {
      var url = Uri.https(_domain, endpoint, args);

      // Await the http get response, then decode the json-formatted response.
      final response = await http.get(url);
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response?> postData(
      String endpoint, Map<String, dynamic> body) async {
    try {
      var url = Uri.http(_domain, endpoint);

      // Await the http get response, then decode the json-formatted response.
      final response = await http.post(url, body: jsonEncode(body));
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response?> putData(
      String endpoint, Map<String, dynamic> body) async {
    try {
      var url = Uri.http(_domain, endpoint);

      // Await the http get response, then decode the json-formatted response.
      final response = await http.put(url, body: jsonEncode(body));
      return response;
    } catch (e) {
      return null;
    }
  }
}
