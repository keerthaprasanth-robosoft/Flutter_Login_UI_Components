import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'https://dummyjson.com';

  // Define all endpoints here
  static const String loginEndpoint = '/auth/login';
  static const String productsListEndpoint = '/products';
  static const String productsDetailsEndpoint = '/users';

  // Token storage
  static String? _authToken;

  static void setAuthToken(String token) {
    _authToken = token;
  }

  static String? getAuthToken() {
    return _authToken;
  }

  static Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to connect to API: ${response.statusCode}');
    }
  }
}
