import 'package:food_shop/models/food.dart';
import 'package:food_shop/src/popular_food/repository/popular_products.repo.dart';
import 'package:get/get.dart';

class PopularFoodConroller extends GetxController {
  final PopularFoodRepo repo;

  PopularFoodConroller(this.repo);

  final List<Food> _popularProductList = const [];

  List<Food> get popularProductList => _popularProductList;

  Future<void> getPopularProductList() async {
    final res = await repo.getPopularProductList();
    if (res.status.isOk) {
      _popularProductList.clear();
      _popularProductList.addAll([]);

      update();
    }
  }

  factory PopularFoodConroller.init() {
    return PopularFoodConroller(Get.find());
  }
}
