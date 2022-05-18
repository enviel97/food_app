import 'package:food_shop/controller/base.controller.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/models/pagination.dart';
import 'package:food_shop/views/home/repository/recommended_food.repo.dart';
import 'package:get/get.dart';

const recommendedFoodListId = 'RecommendedFoodList';
const recommendedFoodId = 'RecommendedFoodList';

class RecommendedFoodConroller extends ApiBaseController {
  final RecommendedFoodRepo repo;

  RecommendedFoodConroller({required this.repo}) : super(connects: {});

  final List<Food> _recommendedFoodList = [];
  final Map<String, Food> catche = {};
  final Rx<Food?> _selectedFood = Rx(null);

  List<Food> get recommendedFoodList => _recommendedFoodList;
  Food? get selectedFood => _selectedFood.value;

  @override
  void init() {
    lazy(
      recommendedFoodListId,
      connect: ({dynamic data}) => repo.getRecommendedFoodList(),
      onSuccess: (res) {
        _recommendedFoodList.clear();
        final paginate = Pagination<Food>.fromJson(res.body, Food.fromJson);
        _recommendedFoodList.addAll(paginate.datas);
        catche.addAll({for (Food food in _recommendedFoodList) food.id: food});
      },
    );
    lazy(
      recommendedFoodId,
      connect: ({dynamic data}) => repo.getRecommendedFood(data),
      onSuccess: (res) {
        _selectedFood.value = Food.fromJson(res.body);
      },
    );
  }

  @override
  void close() {
    catche.clear();
  }

  Future<void> getRecommendedFoodList() async {
    request(recommendedFoodListId);
  }

  void getRecommendedFodd(String foodId) async {
    try {
      if (catche.containsKey(foodId)) {
        _selectedFood.value = catche[foodId];
      }
      request(recommendedFoodId, data: foodId);
      return null;
    } catch (error) {
      return null;
    }
  }
}
