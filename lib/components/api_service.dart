import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_test_project/common/SharedPrefsHelper.dart';
import 'package:http/http.dart' as http;
import 'api_client.dart';

class ApiService {
  // GET Request
  static Future<dynamic> get(String endpoint, {bool headerLoaded = false}) async {
    final url = Uri.parse('${ApiClient.baseUrl}$endpoint');
    final token = await SharedPrefsHelper.getToken();

    final headers = {
      'Content-Type': 'application/json',
      if (token != null && (headerLoaded)) 'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body); // Return parsed JSON
    } else {
      final error = json.decode(response.body);
      throw Exception(
          'Error ${response.statusCode}: ${error['message'] ?? 'Unknown error'}');
    }
  }

  // POST Request
  static Future<dynamic> post(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('${ApiClient.baseUrl}$endpoint');
    final token = await SharedPrefsHelper.getToken();

    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response =
        await http.post(url, headers: headers, body: json.encode(body));
    return _handleResponse(response);
  }

  // Handle Response
  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
}
