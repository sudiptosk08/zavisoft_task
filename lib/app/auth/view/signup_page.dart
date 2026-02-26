import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_updating/app/auth/controller/signup_controller.dart';
import 'package:price_updating/utils/colors/app_colors.dart';
import 'package:price_updating/utils/global_widget/custom_loading.dart';
import 'package:price_updating/utils/global_widget/custom_text_form_field.dart';
import 'package:price_updating/utils/sizes/k_sizes.dart';
import 'package:price_updating/utils/text_styles/text_font_style.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: KColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: KSizes.vGapExtraLarge),
                Text(
                  "Create Account",
                  style: TextFontStyle.headline41w700BlackStyleManrope,
                ),
                SizedBox(height: KSizes.kScreenHeight * 0.03),
                CustomTextField(
                  title: "Username",
                  controller: controller.usernameController,
                  filled: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  hintText: "Enter your username",
                ),
                SizedBox(height: KSizes.vGapLarge),
                CustomTextField(
                  title: "Email",
                  controller: controller.emailController,
                  filled: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  hintText: "Enter your email",
                ),
                SizedBox(height: KSizes.vGapLarge),
                CustomTextField(
                  title: "Password",
                  controller: controller.passwordController,
                  filled: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  hintText: "Enter your password",
                ),
                SizedBox(height: KSizes.vGapExtraLarge),
                TextButton(
                  onPressed: controller.signup,
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    backgroundColor:
                        WidgetStateProperty.all(KColors.primary),
                    maximumSize: WidgetStateProperty.all(
                      const Size(double.infinity, 54),
                    ),
                    minimumSize: WidgetStateProperty.all(
                      const Size(double.infinity, 54),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const CustomLoading()
                      : Text(
                          "Sign Up",
                          style: TextFontStyle
                              .headline16w600CFFFFFFFFStyleManropee,
                        ),
                ),
                SizedBox(height: KSizes.vGapLarge),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



