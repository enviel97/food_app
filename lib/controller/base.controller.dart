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

abstract class ApiBaseController extends GetxController {
  final Map<String, Connection> connects;

  ApiBaseController({required this.connects});

  // override options
  void init() {}
  void close() {}

  @protected
  void request(String key, {dynamic data}) {
    if (!connects.containsKey(key)) {
      throw Exception("Can't reject connection with key: $key");
    }
    final connect = connects[key]!;
    if (!connect.isLoaded) {
      connect.request(data);
    }
  }

  Connection status(String key) {
    if (!connects.containsKey(key)) {
      throw Exception("Can't reject connection with key: $key");
    }
    return connects[key]!;
  }

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onClose() {
    close();
    super.onClose();
  }

  void lazy(
    String keyConnect, {
    required Future<Response> Function({dynamic data}) connect,
    required Function(Response res) onSuccess,
    bool isRefresh = false,
    Function()? onError,
  }) async {
    if (connects.containsKey(keyConnect)) return;
    final _connection = Connection(
      connect,
      onSuccess: (res) {
        onSuccess(res);
        update();
      },
      onError: () {
        onError?.call();
        update();
      },
    );
    _connection.isRefresh = isRefresh.obs;
    connects[keyConnect] = _connection;
  }
}
