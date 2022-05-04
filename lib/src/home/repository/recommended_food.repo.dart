import 'package:food_shop/helpers/constants.dart';
import 'package:food_shop/repository/api_client.dart';
import 'package:food_shop/repository/base.repository.dart';
import 'package:get/get.dart';

class RecommendedFoodRepo extends BaseRepo {
  RecommendedFoodRepo({required ApiClient client}) : super(client);

  Future<Response> getRecommendedFoodList() async {
    return await client.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
