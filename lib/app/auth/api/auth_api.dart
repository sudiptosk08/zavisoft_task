import 'package:price_updating/backend/api_method/api_method.dart';
import 'package:price_updating/backend/api_urls/api_urls.dart';
import 'package:price_updating/backend/error_message/error_message.dart';
import 'package:price_updating/utils/global_widget/toast_message.dart';

class AuthApi {
  /// Fakestore login: returns a JWT token string on success, or null on failure.
  static Future<String?> login({required Map<String, dynamic> body}) async {
    try {
      final mapResponse = await ApiMethod(
        isBasic: true,
      ).post(ApiUrls.login, body: body, code: 201);
      if (mapResponse != null && mapResponse['token'] is String) {
        return mapResponse['token'] as String;
      }
    } catch (e) {
      ErrorMessage.message(apiName: 'Login', error: e);
      return null;
    }
    return null;
  }

  static Future<bool> signup({required Map<String, dynamic> body}) async {
    try {
      final mapResponse = await ApiMethod(
        isBasic: true,
      ).post(ApiUrls.users, body: body, code: 201);
      if (mapResponse != null) {
        // Fakestore returns the created user object here.
        ToastMessage.success('User created successfully');
        return true;
      }
    } catch (e) {
      ErrorMessage.message(apiName: 'Signup', error: e);
      return false;
    }
    return false;
  }
}
