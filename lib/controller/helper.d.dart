import 'package:get/get.dart';

class RequestOption {
  final List<String>? params;
  final Map<String, dynamic>? query;
  final Map<String, dynamic>? body;
  const RequestOption({this.params, this.query, this.body});
}

class Connection {
  late Rx<bool> _isLoaded, _isError, isRefresh;
  late Future<Response> Function({dynamic data}) _connect;
  late Function(Response res) _onSuccess;
  late Function()? _onError;

  Connection(
    Future<Response> Function({dynamic data}) connect, {
    required Function(Response res) onSuccess,
    Function()? onError,
  }) {
    _connect = connect;
    _onSuccess = onSuccess;
    _onError = onError;
    _isLoaded = false.obs;
    _isError = false.obs;
    isRefresh = false.obs;
  }

  bool get isLoaded => _isLoaded.value;
  bool get isError => _isError.value;

  void request(dynamic data) async {
    // repo.getString(id)
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
