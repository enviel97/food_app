import 'package:food_shop/dependencies/repository/api_client.dart';
import 'package:food_shop/helpers/constants.dart';
import 'package:get/get.dart';

class RecommendedFoodRepo {
  final ApiClient client;
  RecommendedFoodRepo({required this.client});

  Future<Response> getRecommendedFoodList() async {
    return await client.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }

  Future<Response> getRecommendedFood(String foodId) async {
    return await client.getData(AppConstants.GET_PRODUCT, params: [foodId]);
  }
}
