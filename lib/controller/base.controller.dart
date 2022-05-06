import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  bool _isLoaded = false, _isError = false;
  bool get isLoaded => _isLoaded;
  bool get isError => _isError;

  void connect(
    Future<Response> Function() connect, {
    required Function(Response res) onSuccess,
    Function()? onError,
  }) async {
    _isLoaded = false;
    _isError = false;
    final res = await connect();
    if (res.isOk) {
      await onSuccess(res);
      _isLoaded = true;
      _isError = false;
      update();
    } else {
      if (onError != null) {
        onError();
      }
      _isLoaded = true;
      _isError = true;
      update();
    }
  }
}
