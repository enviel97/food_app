import 'dart:convert';

import 'package:food_shop/helpers/constants.dart';
import 'package:food_shop/helpers/functions.dart';
import 'package:food_shop/models/cart.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo extends GetxService {
  late SharedPreferences _localStorage;

  CartRepo({required SharedPreferences localStorage}) {
    _localStorage = localStorage;
  }

  Cart getCartHistory(String id) {
    final json = _localStorage.getString(id);
    if (json == null) throw Exception('$id is not have in history');
    return Cart.fromJson(jsonDecode(json));
  }

  void storeHistory(Cart cart) {
    List<String> cartIds = [];
    const key = AppConstants.CART_HISTORY;
    if (_localStorage.containsKey(key)) {
      cartIds = _localStorage.getStringList(key)!;
    }
    cartIds.add(cart.id);
    _localStorage.setStringList(key, cartIds);

    _localStorage.setString(cart.id, jsonEncode(cart));
    _clearTemp();
  }

  void storeTemp(List<FoodInCart> cart) {
    final json = cart.map(jsonEncode);
    _localStorage.setStringList(AppConstants.CART_TEMP, json.toList());
  }

  Future<bool> _clearTemp() async {
    try {
      final isClear = await _localStorage.remove(AppConstants.CART_TEMP);
      return isClear;
    } catch (e) {
      return false;
    }
  }

  List<FoodInCart> getTemp() {
    const key = AppConstants.CART_TEMP;
    if (!_localStorage.containsKey(key)) return [];
    final json = _localStorage.getStringList(key);
    final cart = mapToList<FoodInCart>(json, FoodInCart.fromJson);
    return cart;
  }
}
