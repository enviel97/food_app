import 'package:flutter/material.dart';
import 'package:food_shop/helpers/constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  late Map<String, String> _mainHeader;

  final String appBaseUrl;

  ApiClient(this.appBaseUrl) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(String uri) async {
    try {
      final response = await get(
        uri,
        headers: _mainHeader,
      );
      return response;
    } catch (e) {
      debugPrint('[GET]: $uri - $e');
      return Response(statusCode: -1, statusText: e.toString());
    }
  }
}
