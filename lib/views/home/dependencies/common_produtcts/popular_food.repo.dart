import 'package:food_shop/dependencies/repository/api_client.dart';
import 'package:food_shop/helpers/constants.dart';
import 'package:get/get.dart';

class PopularFoodRepo extends GetxService {
  final ApiClient client;
  PopularFoodRepo({required this.client});

  Future<Response> getPopularFoodList() async {
    return await client.getData(AppConstants.POPULAR_PRODUCT_URI);
  }

  Future<Response> getPopularFood(String foodId) async {
    return await client.getData(AppConstants.GET_PRODUCT, params: [foodId]);
  }
}
