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
    token = AppConstants.API_KEY;
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-8',
      'authenticate': token,
    };
  }

  Future<Response> getData(
    String uri, {
    List<String>? params,
    Map<String, dynamic>? query,
  }) async {
    try {
      String _uri = uri;
      if (params != null && params.isNotEmpty) {
        _uri = '$uri/${params.join('/')}';
      }
      final response = await get(
        _uri,
        headers: _mainHeader,
        query: query,
      );
      return response;
    } catch (e) {
      debugPrint('[GET]: $uri - $e');
      return Response(statusCode: -1, statusText: e.toString());
    }
  }
}
