import 'package:food_shop/controller/base.controller.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/views/home/repository/popular_food.repo.dart';
import 'package:get/get.dart';

const popularFoodListID = 'PopularFoodList';

class PopularFoodConroller extends ApiBaseController {
  final PopularFoodRepo repo;

  PopularFoodConroller({required this.repo}) : super(connects: {});

  final List<Food> _popularFoodList = [];

  List<Food> get popularFoodList => _popularFoodList;

  Future<void> getPopularFoodList() async {
    inject(
      popularFoodListID,
      connect: () async => const Response(
        statusCode: 200,
        statusText: 'faker',
      ), // repo.getPopularFoodList,
      onSuccess: (res) {
        _popularFoodList.clear();
        // final paginate = Pagination<Food>.fromJson(res.body, Food.fromJson);
        _popularFoodList.addAll(List.generate(6, (index) => Food.faker()));
        // _popularFoodList.addAll(paginate.datas);
      },
    );
  }

  Food? getPopularFood(String foodId) {
    try {
      final food = _popularFoodList.firstWhere((food) => food.id == foodId);
      return food;
    } catch (error) {
      return null;
    }
  }
}
