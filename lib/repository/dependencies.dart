import 'package:food_shop/src/home/repository/popular_food.repo.dart';
import 'package:food_shop/src/home/repository/recommended_food.repo.dart';
import 'package:get/get.dart';

class RepositoryDependencies {
  const RepositoryDependencies();

  static void inject() {
    // inject dependencies
    Get.lazyPut(() => PopularFoodRepo(client: Get.find()));
    Get.lazyPut(() => RecommendedFoodRepo(client: Get.find()));
  }
}
