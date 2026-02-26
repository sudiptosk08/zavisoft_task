import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_updating/app/auth/controller/login_controller.dart';
import 'package:price_updating/routes/routes.dart';
import 'package:price_updating/utils/colors/app_colors.dart';
import 'package:price_updating/utils/global_widget/custom_loading.dart';
import 'package:price_updating/utils/global_widget/custom_text_form_field.dart';
import 'package:price_updating/utils/sizes/k_sizes.dart';
import 'package:price_updating/utils/text_styles/text_font_style.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: KColors.white,
        body: Stack(
          children: [
            Container(
              // Background color (light blue gradient like the screenshot)
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: KSizes.vGapExtraLarge),
                  Text(
                    "Please Login",
                    style: TextFontStyle.headline41w700BlackStyleManrope,
                  ),
                  SizedBox(height: KSizes.kScreenHeight * 0.05),
                  CustomTextField(
                    title: "UserName",
                    controller: controller.emailTextController,
                    filled: false,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    hintText: "Enter your user name",
                  ),
                  SizedBox(height: KSizes.vGapLarge),
                  CustomTextField(
                    title: "Password",
                    controller: controller.passwordTextController,
                    filled: false,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    hintText: " Enter your password",
                  ),
                  SizedBox(height: KSizes.vGapExtraLarge),
                  TextButton(
                    onPressed: () {
                      controller.login();
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ), // 👈 set border radius
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all(KColors.primary),
                      maximumSize: WidgetStateProperty.all(
                        Size(double.infinity, 54),
                      ),
                      minimumSize: WidgetStateProperty.all(
                        Size(double.infinity, 54),
                      ),
                    ),

                    child: controller.isLoading.value
                        ? const CustomLoading()
                        : Text(
                            "Login",
                            style: TextFontStyle
                                .headline16w600CFFFFFFFFStyleManropee,
                          ),
                  ),
                  SizedBox(height: KSizes.vGapLarge),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.signupPage),
                    child: const Text("Don't have an account? Sign up"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
