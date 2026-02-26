import 'package:get/get.dart';
import 'package:price_updating/app/product_listing/controller/daraz_listing_controller.dart';

class DarazListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DarazListingController>(() => DarazListingController());
  }
}


