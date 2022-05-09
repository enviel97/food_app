import 'package:food_shop/controller/base.controller.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/views/home/repository/recommended_food.repo.dart';
import 'package:get/get.dart';

class RecommendedFoodConroller extends BaseController {
  final RecommendedFoodRepo repo;

  RecommendedFoodConroller({required this.repo});

  final List<Food> _recommendedFoodList = [];

  List<Food> get recommendedFoodList => _recommendedFoodList;

  Future<void> getRecommendedFoodList() async {
    connect(
      () async => const Response(
        statusCode: 200,
        statusText: 'faker',
      ), // repo.getPopularFoodList,
      onSuccess: (res) {
        _recommendedFoodList.clear();
        // final paginate = Pagination<Food>.fromJson(res.body, Food.fromJson);
        _recommendedFoodList.addAll(List.generate(6, (index) => Food.faker()));
        // _recommendedFoodList.addAll(paginate.datas);
      },
    );
    // connect(
    //   repo.getRecommendedFoodList,
    //   onSuccess: (res) {
    //     _recommendedFoodList.clear();
    //     final paginate = Pagination<Food>.fromJson(res.body, Food.fromJson);
    //     _recommendedFoodList.addAll(paginate.datas);
    //   },
    // );
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
