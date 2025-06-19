import 'package:flutter/material.dart';
import 'package:flutter_test_project/components/api_client.dart';
import 'package:flutter_test_project/common/SharedPrefsHelper.dart';
import 'package:flutter_test_project/components/api_service.dart';
import 'package:flutter_test_project/models/loginModel/login_response.dart';
import 'package:flutter_test_project/models/productsModel/products_response.dart';
import 'package:flutter_test_project/models/productsModel/appSession.dart';

class LoginViewModel with ChangeNotifier {
  String? _errorMessage; // Stores error messages
  bool _isLoading = false; // Indicates if a login operation is in progress
  bool _isLoggedIn = false; // Tracks login status

  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  /// Products List
  Future<void> getProducts() async {
    _setLoading(true); // Update loading state
    try {
      // Call the API and get the parsed JSON response
      final response = await ApiService.get(ApiClient.ticketsListEndpoint);

      // Parse the response into ProductsResponse
      final ProductListResponse ticketsResponse =
          ProductListResponse.fromJson(response);

      // Store the products in the AppSession
      AppSession().setProductResponse(ticketsResponse);

      print('Products saved: ${AppSession().getProducts()?.length}');
    } catch (e) {
      print('Failed to fetch products: $e');
      _setError('Failed to fetch products: $e');
    } finally {
      _setLoading(false); // Reset loading state
    }
  }

  /// Login method
  Future<LoginResponse> login(String email, String password) async {
  _setLoading(true);
  _clearError();
  _setLoggedIn(false); // Reset login status before starting

  try {
    final response = await ApiService.post(
      ApiClient.loginEndpoint,
      {'username': email, 'password': password},
    );

    // Adjust this condition based on your actual API structure
    if (response != null && response['accessToken'] != null) {
      final token = response['accessToken'];
      ApiClient.setAuthToken(token);
      await SharedPrefsHelper.saveToken(token);

      _setLoggedIn(true);
      return LoginResponse.fromJson(response);
    } else {
      _setError(response['error'] ?? 'Login failed. Invalid credentials.');
      _setLoggedIn(false);
    }
  } catch (e) {
    _setError(e.toString());
    _setLoggedIn(false);
  } finally {
    _setLoading(false);
  }

  return Future.error(errorMessage ?? 'Login failed');
}

  /// Updates the loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Updates the login status
  void _setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  /// Updates the error message
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Clears the error message
  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
