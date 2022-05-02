import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'api_client.dart';

class Routes {
  final String name;
  final GetxController? controller;
  final GetxService? repo;

  const Routes(
    this.name, {
    this.controller,
    this.repo,
  });
}

class Dependencies {
  const Dependencies();

  static final Map<String, dynamic> _routes = {};

  static void inject(Routes route) {
    if (_routes.containsKey(route.name)) {
      throw Exception('Inject Exception: ${route.name} is already');
    }
    _routes[route.name] = UniqueKey().toString();
    if (route.controller != null) Get.lazyPut(() => route.controller);
    if (route.repo != null) Get.lazyPut(() => route.repo);
  }

  static Future<void> init() async {
    const baseUrl = '';

    Get.lazyPut(() => ApiClient(baseUrl));
    // inject
  }
}
