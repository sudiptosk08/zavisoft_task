import 'dart:convert';

import 'package:price_updating/app/product_listing/model/product_model.dart';
import 'package:price_updating/app/product_listing/model/user_model.dart';
import 'package:price_updating/backend/api_method/api_method.dart';
import 'package:price_updating/backend/api_urls/api_urls.dart';

/// Simple Fakestore API client built on the existing [ApiMethod].
class FakestoreApi {
  final ApiMethod _client = ApiMethod(isBasic: true);

  Future<String?> login({
    required String username,
    required String password,
  }) async {
    final response = await _client.post(
      ApiUrls.login,
      body: {
        'username': username,
        'password': password,
      },
      code: 200,
    );

    if (response == null) return null;
    // Fakestore returns: { "token": "..." }
    return response['token'] as String?;
  }

  Future<FakestoreUser?> fetchUserProfile({int userId = 1}) async {
    final raw = await _client.get(ApiUrls.userById(userId), code: 200);
    if (raw == null) return null;
    return FakestoreUser.fromJson(raw as Map<String, dynamic>);
  }

  Future<List<Product>> fetchAllProducts() async {
    final raw = await _client.get(ApiUrls.products, code: 200);
    if (raw == null) return [];
    final list = raw as List<dynamic>;
    return list
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Product>> fetchProductsByCategory(String category) async {
    final raw =
        await _client.get('${ApiUrls.products}/category/$category', code: 200);
    if (raw == null) return [];
    final list = raw as List<dynamic>;
    return list
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}


