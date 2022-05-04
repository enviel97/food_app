import 'package:food_shop/views/home/controllers/popular_product.controller.dart';
import 'package:food_shop/views/home/controllers/recommended_food.controller.dart';
import 'package:get/get.dart';

class ControllerDependencies {
  const ControllerDependencies();

  static void inject() {
    // inject dependencies
    Get.lazyPut(() => PopularFoodConroller(repo: Get.find()));
    Get.lazyPut(() => RecommendedFoodConroller(repo: Get.find()));
  }
}
