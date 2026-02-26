import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_updating/app/auth/api/auth_api.dart';
import 'package:price_updating/local_storage/local_storage.dart';
import 'package:price_updating/routes/routes.dart';

class LoginController extends GetxController {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isObscure = true.obs;

  Future<void> login() async {
    isLoading.value = true;
    Map<String, dynamic> body = {
      "username": emailTextController.text,
      "password": passwordTextController.text,
    };

    final String? token = await AuthApi.login(body: body);
    print("hogar token $token");

    if (token != null) {
      print("hogar token $token");
      await LocalStorage.saveApiToken(token: token);
      Get.offAllNamed(Routes.darazListingPage);
    }
    isLoading.value = false;
  }
}
