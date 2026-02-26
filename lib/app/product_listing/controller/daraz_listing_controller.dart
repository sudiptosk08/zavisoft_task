import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_updating/app/product_listing/api/fakestore_api.dart';
import 'package:price_updating/app/product_listing/model/product_model.dart';
import 'package:price_updating/app/product_listing/model/user_model.dart';

class DarazListingController extends GetxController {
  final FakestoreApi _api = FakestoreApi();

  // Tabs (Daraz-style categories)
  final List<String> tabs = ['All', 'Electronics', 'Jewelery'];

  // Single vertical scroll owner
  final ScrollController scrollController = ScrollController();

  // Tab index
  final RxInt currentTabIndex = 0.obs;

  // Data for each tab
  final RxList<Product> allProducts = <Product>[].obs;
  final RxList<Product> electronicsProducts = <Product>[].obs;
  final RxList<Product> jeweleryProducts = <Product>[].obs;

  // Fakestore user profile
  final Rxn<FakestoreUser> user = Rxn<FakestoreUser>();

  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  Future<void> _initData() async {
    isLoading.value = true;
    try {
      // 1) Login to Fakestore (demo credentials from docs)
      await _api.login(username: 'mor_2314', password: '83r5^_');

      // 2) Load a sample user profile
      user.value = await _api.fetchUserProfile(userId: 1);

      // 3) Load products for all tabs
      await _loadAllTabs();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadAllTabs() async {
    final all = await _api.fetchAllProducts();
    final electronics = await _api.fetchProductsByCategory('electronics');
    final jewelery = await _api.fetchProductsByCategory('jewelery');

    allProducts.assignAll(all);
    electronicsProducts.assignAll(electronics);
    jeweleryProducts.assignAll(jewelery);
  }

  List<Product> get productsForCurrentTab {
    switch (currentTabIndex.value) {
      case 1:
        return electronicsProducts;
      case 2:
        return jeweleryProducts;
      default:
        return allProducts;
    }
  }

  void onTabChanged(int index) {
    currentTabIndex.value = index;
    // NOTE: we deliberately do NOT change scrollController offset here
    // so that switching tabs does not reset or jump the vertical position.
  }

  Future<void> onRefresh() async {
    await _loadAllTabs();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}


