import 'package:food_shop/helpers/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/dependencies.dart';
import 'repository/api_client.dart';
import 'repository/dependencies.dart';

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
