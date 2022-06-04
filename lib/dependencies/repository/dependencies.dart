import 'package:food_shop/views/auth/dependencies/auth.repository.dart';
import 'package:food_shop/views/history/dependencies/history.repository.dart';
import 'package:food_shop/views/home/dependencies/common_produtcts/popular_food.repo.dart';
import 'package:food_shop/views/home/dependencies/popular_product/recommended_food.repo.dart';
import 'package:food_shop/views/cart/dependencies/cart.repo.dart';
import 'package:food_shop/views/personal/dependencies/address/address.repository.dart';
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
    Get.lazyPut(() => AddressRepo(client: Get.find(), local: Get.find()),
        fenix: true);
  }
}
