import 'package:get/get.dart';

class ResponseError implements Exception {
  final dynamic cause;
  const ResponseError(this.cause);
}

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
    update();
  }

  void _onError() {
    _isLoaded = true;
    _isError = true;
    update();
  }

  void _onSuccess() {
    _isLoaded = true;
    _isError = false;
  }

  void restart() {
    _onStart();
    update();
  }

  Future<T?> request<T>(Future<Response> Function() fetch) async {
    _onStart();
    final response = await fetch();
    if (response.isOk) {
      _onSuccess();
      update();
      return response.body;
    }
    _onError();
    throw ResponseError(response.body ?? response.statusText);
  }
}
