import 'package:food_shop/dependencies/repository/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressRepo extends GetxService {
  final ApiClient client;
  final SharedPreferences local;

  AddressRepo({required this.client, required this.local});
}
