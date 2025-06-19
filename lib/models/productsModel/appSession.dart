import 'package:flutter_test_project/models/productsModel/products_response.dart';

class AppSession {
  static final AppSession _instance = AppSession._internal();

  factory AppSession() => _instance;

  AppSession._internal();

  String? token; // Bearer token
  ProductListResponse? productsResponse; // Store the products response globally

  /// Clear session data
  void clear() {
    token = null;
    productsResponse = null;
  }

  /// Set products response globally
  void setProductResponse(ProductListResponse response) {
    productsResponse = response;
  }

  /// Get all products
  List<Product>? getProducts() {
    return productsResponse?.products;
  }
}
