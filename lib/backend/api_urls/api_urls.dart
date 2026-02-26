import 'package:price_updating/backend/api_config/api_config.dart';

/// Fakestore API endpoints built on top of [ApiConfig.baseUrl].
///
/// Reference: https://fakestoreapi.com/docs
class ApiUrls {
  // 🔒 Auth
  static const String login = "${ApiConfig.baseUrl}/auth/login";

  // 🛒 Products
  static const String products = "${ApiConfig.baseUrl}/products";
  static String productById(int id) => "${ApiConfig.baseUrl}/products/$id";

  // 👤 Users
  static const String users = "${ApiConfig.baseUrl}/users";
  static String userById(int id) => "${ApiConfig.baseUrl}/users/$id";

  // 🛍️ Carts
  static const String carts = "${ApiConfig.baseUrl}/carts";
  static String cartById(int id) => "${ApiConfig.baseUrl}/carts/$id";
}
