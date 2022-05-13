import 'package:food_shop/views/cart/controllers/cart.controller.dart';
import 'package:food_shop/views/history/controllers/history.controller.dart';
import 'package:food_shop/views/home/controllers/popular_product.controller.dart';
import 'package:food_shop/views/home/controllers/recommended_food.controller.dart';
import 'package:get/get.dart';

class ControllerDependencies {
  const ControllerDependencies();

  static void inject() {
    // inject dependencies
    Get.lazyPut(() => CartController(repo: Get.find()), fenix: true);
    Get.lazyPut(() => HistoryController(repo: Get.find()), fenix: true);
    Get.lazyPut(() => PopularFoodConroller(repo: Get.find()), fenix: true);
    Get.lazyPut(() => RecommendedFoodConroller(repo: Get.find()), fenix: true);
  }
}
