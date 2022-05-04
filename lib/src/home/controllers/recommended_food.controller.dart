import 'package:food_shop/controller/base.controller.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/models/pagination.dart';
import 'package:food_shop/src/home/repository/recommended_food.repo.dart';

class RecommendedFoodConroller extends BaseController {
  final RecommendedFoodRepo repo;

  RecommendedFoodConroller({required this.repo});

  final List<Food> _recommendedFoodList = [];

  List<Food> get recommendedFoodList => _recommendedFoodList;

  Future<void> getRecommendedFoodList() async {
    await connect(
      await repo.getRecommendedFoodList(),
      onSuccess: (res) {
        _recommendedFoodList.clear();
        final paginate = Pagination<Food>.fromJson(res.body, Food.fromJson);
        _recommendedFoodList.addAll(paginate.datas);
      },
    );
  }

  Food? getRecommendedFodd(String foodId) {
    try {
      final food = _recommendedFoodList.firstWhere((food) => food.id == foodId);
      return food;
    } catch (error) {
      return null;
    }
  }
}
