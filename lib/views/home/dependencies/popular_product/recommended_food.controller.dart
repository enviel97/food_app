import 'package:food_shop/dependencies/controller/base.controller.dart';
import 'package:food_shop/helpers/widget_functions.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/models/pagination.dart';
import 'package:food_shop/views/home/dependencies/popular_product/recommended_food.repo.dart';

import 'recommended_food.repo.dart';

class RecommendedFoodConroller extends ApiControllerBase {
  final RecommendedFoodRepo repo;

  RecommendedFoodConroller({required this.repo});

  final List<Food> _recommendedFoodList = [];
  final Map<String, Food> _catche = {};

  List<Food> get recommendedFoodList => _recommendedFoodList;

  @override
  void onDispose() {
    _catche.clear();
  }

  Future<void> getRecommendedFoodList({bool isRestart = false}) async {
    try {
      if (isRestart) {
        restart();
        update();
      }
      final response = await request(repo.getRecommendedFoodList);
      if (response != null) {
        _recommendedFoodList.clear();
        _catche.clear();

        final pagination = Pagination.fromJson(response, Food.fromJson);
        _recommendedFoodList.addAll(pagination.datas);
        _catche.addAll({for (Food food in pagination.datas) food.id: food});
      }
    } on ResponseError catch (error) {
      showError(error.cause);
    }
  }

  Future<Food?> getRecommendedFood(String foodId) async {
    try {
      if (_catche.containsKey(foodId)) {
        return _catche[foodId];
      }
      final response = await request(() => repo.getRecommendedFood(foodId));
      if (response != null) {
        final food = Food.fromJson(response);
        return food;
      }
      return null;
    } on ResponseError catch (error) {
      showError(error.cause);
      return null;
    }
  }
}
