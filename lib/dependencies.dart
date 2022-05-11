import 'package:food_shop/controller/dependencies.dart';
import 'package:food_shop/helpers/constants.dart';
import 'package:food_shop/repository/dependencies.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'repository/api_client.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  const baseUrl = AppConstants.BASE_URL;
  // inject
  Get.lazyPut(() => ApiClient(baseUrl), fenix: true);

  // repository
  RepositoryDependencies.inject();

  // controller
  ControllerDependencies.inject();
}
