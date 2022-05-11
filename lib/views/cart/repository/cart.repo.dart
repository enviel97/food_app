import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences localStorage;

  const CartRepo({required this.localStorage});
}
