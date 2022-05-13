import 'package:food_shop/views/history/repositories/history.repository.dart';
import 'package:food_shop/views/home/repository/popular_food.repo.dart';
import 'package:food_shop/views/home/repository/recommended_food.repo.dart';
import 'package:food_shop/views/cart/repository/cart.repo.dart';
import 'package:get/get.dart';

class RepositoryDependencies {
  const RepositoryDependencies();

  static void inject() {
    // inject dependencies
    Get.lazyPut(() => CartRepo(localStorage: Get.find()), fenix: true);
    Get.lazyPut(() => HistoryRepo(localStorage: Get.find()), fenix: true);
    Get.lazyPut(() => PopularFoodRepo(client: Get.find()), fenix: true);
    Get.lazyPut(() => RecommendedFoodRepo(client: Get.find()), fenix: true);
  }
}
