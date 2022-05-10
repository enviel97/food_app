import 'package:get/get.dart';

class Connection {
  late bool _isLoaded, _isError, isRefresh;
  late Future<Response> Function() _connect;
  late Function(Response res) _onSuccess;
  late Function()? _onError;
  Connection(
    Future<Response> Function() connect, {
    required Function(Response res) onSuccess,
    Function()? onError,
  }) {
    _connect = connect;
    _onSuccess = onSuccess;
    _onError = onError;
    _isLoaded = false;
    _isError = false;
    isRefresh = false;
  }

  bool get isLoaded => _isLoaded;
  bool get isError => _isError;

  void request() async {
    final res = await _connect();
    if (res.isOk) {
      _isLoaded = true;
      _isError = false;
      await _onSuccess(res);
    } else {
      _isLoaded = true;
      _isError = true;
      _onError?.call();
    }
  }
}

abstract class ApiBaseController extends GetxController {
  final Map<String, Connection> connects;

  ApiBaseController({required this.connects});

  Connection reject(String key) {
    if (!connects.containsKey(key)) {
      throw Exception("Can't reject connection with key: $key");
    }
    final connect = connects[key]!;
    if (!connect.isLoaded) {
      connect.request();
    }
    return connects[key]!;
  }

  Future<void> inject(
    String keyConnect, {
    required Future<Response> Function() connect,
    required Function(Response res) onSuccess,
    bool isRefresh = false,
    Function()? onError,
  }) async {
    if (connects.containsKey(keyConnect)) return;
    final _connection = Connection(connect, onSuccess: (res) {
      onSuccess(res);
      update();
    }, onError: () {
      onError?.call();
      update();
    });
    _connection.isRefresh = isRefresh;
    connects[keyConnect] = _connection;
  }
}
