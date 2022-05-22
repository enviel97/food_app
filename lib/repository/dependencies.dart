import 'package:food_shop/views/auth/repository/auth.repository.dart';
import 'package:food_shop/views/history/repositories/history.repository.dart';
import 'package:food_shop/views/home/repository/popular_food.repo.dart';
import 'package:food_shop/views/home/repository/recommended_food.repo.dart';
import 'package:food_shop/views/cart/repository/cart.repo.dart';
import 'package:get/get.dart';

class RepositoryDependencies {
  const RepositoryDependencies._();

  static void inject() {
    // inject dependencies
    Get.lazyPut(() => PopularFoodRepo(client: Get.find()), fenix: true);
    Get.lazyPut(() => RecommendedFoodRepo(client: Get.find()), fenix: true);
    Get.lazyPut(() => AuthRepo(client: Get.find(), local: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => CartRepo(localStorage: Get.find(), authController: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => HistoryRepo(localStorage: Get.find(), authController: Get.find()),
        fenix: true);
  }
}
