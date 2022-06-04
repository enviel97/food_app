import 'package:food_shop/views/auth/dependencies/auth.controller.dart';
import 'package:food_shop/views/cart/dependencies/cart.controller.dart';
import 'package:food_shop/views/history/dependencies/history.controller.dart';
import 'package:food_shop/views/home/dependencies/common_produtcts/popular_product.controller.dart';
import 'package:food_shop/views/home/dependencies/popular_product/recommended_food.controller.dart';
import 'package:food_shop/views/personal/dependencies/address/address.controllers.dart';
import 'package:get/get.dart';

class ControllerDependencies {
  const ControllerDependencies._();

  static void inject() {
    // inject dependencies
    Get.lazyPut(() => CartController(repo: Get.find()), fenix: true);
    Get.lazyPut(() => HistoryController(repo: Get.find()), fenix: true);
    Get.lazyPut(() => PopularFoodConroller(repo: Get.find()), fenix: true);
    Get.lazyPut(() => RecommendedFoodConroller(repo: Get.find()), fenix: true);
    Get.lazyPut(() => AuthController(repo: Get.find()), fenix: true);
    Get.lazyPut(() => AddressController(repo: Get.find()), fenix: true);
  }
}
