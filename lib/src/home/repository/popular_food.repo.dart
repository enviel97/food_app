import 'package:food_shop/helpers/constants.dart';
import 'package:food_shop/repository/api_client.dart';
import 'package:food_shop/repository/base.repository.dart';
import 'package:get/get.dart';

class PopularFoodRepo extends BaseRepo {
  PopularFoodRepo({required ApiClient client}) : super(client);

  Future<Response> getPopularFoodList() async {
    return await client.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
