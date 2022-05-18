import 'package:food_shop/controller/base.controller.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/models/pagination.dart';
import 'package:food_shop/views/home/repository/popular_food.repo.dart';
import 'package:get/get.dart';

const popularFoodListID = 'PopularFoodList';
const popularFoodID = 'PopularFoodId';

class PopularFoodConroller extends ApiBaseController {
  final PopularFoodRepo repo;

  PopularFoodConroller({required this.repo}) : super(connects: {});

  final List<Food> _popularFoodList = [];
  final Map<String, Food> catche = {};
  final Rx<Food?> _selectedFood = Rx(null);

  List<Food> get popularFoodList => _popularFoodList;
  Food? get selectedFood => _selectedFood.value;

  @override
  void init() {
    lazy(
      popularFoodListID,
      connect: ({dynamic data}) => repo.getPopularFoodList(),
      onSuccess: (res) {
        _popularFoodList.clear();
        final paginate = Pagination<Food>.fromJson(res.body, Food.fromJson);
        _popularFoodList.addAll(paginate.datas);
        catche.addAll({for (Food food in _popularFoodList) food.id: food});
      },
    );
    lazy(
      popularFoodID,
      connect: ({dynamic data}) => repo.getPopularFood(data),
      onSuccess: (res) {
        _selectedFood.value = Food.fromJson(res.body);
      },
    );
  }

  @override
  void close() {
    catche.clear();
  }

  Future<void> getPopularFoodList() async {
    request(popularFoodListID);
  }

  void getPopularFood(String foodId) async {
    try {
      if (catche.containsKey(foodId)) {
        _selectedFood.value = catche[foodId];
      }
      request(popularFoodListID, data: foodId);
      return null;
    } catch (error) {
      return null;
    }
  }
}
