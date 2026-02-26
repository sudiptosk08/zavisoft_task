import 'package:get/get.dart';
import 'package:price_updating/app/auth/binding/login_binding.dart';
import 'package:price_updating/app/auth/binding/signup_binding.dart';
import 'package:price_updating/app/auth/view/login_page.dart';
import 'package:price_updating/app/auth/view/signup_page.dart';
import 'package:price_updating/app/product_listing/binding/daraz_listing_binding.dart';
import 'package:price_updating/app/product_listing/view/daraz_listing_page.dart';

class Routes {
  static const getStartPage = '/getStartPage';
  static const loginPage = '/loginPage';
  static const signupPage = '/signupPage';
  static const darazListingPage = '/darazListingPage';

  static var routeList = [
    GetPage(
      name: loginPage,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: signupPage,
      page: () => const SignupPage(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: darazListingPage,
      page: () => const DarazListingPage(),
      binding: DarazListingBinding(),
    ),
  ];
}
