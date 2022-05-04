import 'package:get/get.dart';

import 'api_client.dart';

abstract class BaseRepo extends GetxService {
  final ApiClient client;

  BaseRepo(this.client);
}
