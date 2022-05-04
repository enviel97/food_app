import 'package:food_shop/controller/dependencies.dart';
import 'package:food_shop/helpers/constants.dart';
import 'package:food_shop/repository/dependencies.dart';
import 'package:get/get.dart';

import 'repository/api_client.dart';

Future<void> init() async {
  const baseUrl = AppConstants.BASE_URL;
  // inject
  Get.lazyPut(() => ApiClient(baseUrl));

  // repository
  RepositoryDependencies.inject();

  // controller
  ControllerDependencies.inject();
}
