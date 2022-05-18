import 'package:food_shop/controller/base.controller.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/models/pagination.dart';
import 'package:food_shop/views/home/repository/popular_food.repo.dart';

class PopularFoodConroller extends ApiControllerBase {
  final PopularFoodRepo repo;

  PopularFoodConroller({required this.repo});

  @override
  void onDispose() {
    _catche.clear();
  }

  final List<Food> _popularFoodList = [];
  final Map<String, Food> _catche = {};

  List<Food> get popularFoodList => _popularFoodList;

  Future<void> getPopularFoodList() async {
    final response = await request(repo.getPopularFoodList);
    if (response != null) {
      _popularFoodList.clear();
      _catche.clear();

      final pagination = Pagination.fromJson(response, Food.fromJson);
      _popularFoodList.addAll(pagination.datas);
      _catche.addAll({for (Food food in pagination.datas) food.id: food});
    }
  }

  Future<Food?> getPopularFood(String foodId) async {
    try {
      if (_catche.containsKey(foodId)) {
        return _catche[foodId];
      }
      final response = await request(() => repo.getPopularFood(foodId));
      if (response != null) {
        final food = Food.fromJson(response);
        return food;
      }
      return null;
    } catch (error) {
      return null;
    }
  }
}
