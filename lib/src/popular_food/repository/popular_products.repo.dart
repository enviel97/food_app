import 'package:food_shop/repository/api_client.dart';
import 'package:get/get.dart';

class PopularFoodRepo extends GetxService {
  final ApiClient client;

  PopularFoodRepo(this.client);

  Future<Response> getPopularProductList() async {
    return await client.getData('popular_product');
  }
}
