import 'package:get/get.dart';

class Connection {
  late Rx<bool> _isLoaded, _isError, isRefresh;
  late Future<Response> Function({dynamic data}) _connect;
  late Function(Response res) _onSuccess;
  late Function()? _onError;

  Connection(
    Future<Response> Function({dynamic data}) connect, {
    required Function(Response res) onSuccess,
    Function()? onError,
    bool isRefresh = false,
  }) {
    _connect = connect;
    _onSuccess = onSuccess;
    _onError = onError;
    _isLoaded = false.obs;
    _isError = false.obs;
    this.isRefresh = isRefresh.obs;
  }

  bool get isLoaded => _isLoaded.value;
  bool get isError => _isError.value;

  void request(dynamic data) async {
    _isLoaded = false.obs;
    _isError = false.obs;
    final res = await _connect(data: data);
    if (res.isOk) {
      _isLoaded = true.obs;
      _isError = false.obs;
      await _onSuccess(res);
    } else {
      _isLoaded = true.obs;
      _isError = true.obs;
      _onError?.call();
    }
  }
}
