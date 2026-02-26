import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_updating/app/auth/api/auth_api.dart';
import 'package:price_updating/utils/global_widget/toast_message.dart';

class SignupController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isLoading = false.obs;

  Future<void> signup() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ToastMessage.error('Please fill all fields');
      return;
    }

    isLoading.value = true;

    final body = {
      "id": 0,
      "username": usernameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    };

    final created = await AuthApi.signup(body: body);

    isLoading.value = false;

    if (created) {
      // Go back to login page after successful signup
      Get.back();
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}



