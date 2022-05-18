import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helper.d.dart';

class ApiControllerBase extends GetxController {
  bool _isLoaded = false, _isError = false;

  bool get isLoaded => _isLoaded;
  bool get isError => _isError;

  @override
  void onInit() {
    super.onInit();
    onInitState();
  }

  @override
  void onClose() {
    onDispose();
    super.onClose();
  }

  // Init when init state
  void onInitState() {}

  // Init when dispose
  void onDispose() {}

  void _onStart() {
    _isLoaded = false;
    _isError = false;
  }

  void _onError() {
    _isLoaded = true;
    _isError = true;
  }

  void _onSuccess() {
    _isLoaded = true;
    _isError = false;
  }

  Future<T?> request<T>(Future<Response> Function() fetch) async {
    _onStart();
    final response = await fetch();
    if (response.isOk) {
      _onSuccess();
      return response.body;
    }
    _onError();
    return null;
  }
}
