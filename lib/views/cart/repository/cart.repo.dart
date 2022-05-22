import 'dart:convert';

import 'package:food_shop/helpers/constants.dart';
import 'package:food_shop/helpers/functions.dart';
import 'package:food_shop/helpers/widget_functions.dart';
import 'package:food_shop/models/cart.dart';
import 'package:food_shop/views/auth/controllers/auth.controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo extends GetxService {
  final AuthController authController;
  final SharedPreferences localStorage;

  CartRepo({
    required this.localStorage,
    required this.authController,
  });

  Cart getCartHistory(String id) {
    final json = localStorage.getString(id);
    if (json == null) throw Exception('$id is not have in history');
    return Cart.fromJson(jsonDecode(json));
  }

  void storeHistory(Cart cart) {
    if (authController.user == null) return;
    List<String> cartIds = [];
    try {
      final key = authController.user!.id;
      if (localStorage.containsKey(key)) {
        cartIds = localStorage.getStringList(key)!;
      }
      cartIds.add(cart.id);
      localStorage.setStringList(key, cartIds);

      localStorage.setString(cart.id, jsonEncode(cart));
      _clearTemp();
    } catch (error) {
      showError('Unknown');
      return;
    }
  }

  void storeTemp(List<FoodInCart> cart) {
    final json = cart.map(jsonEncode);
    localStorage.setStringList(AppConstants.CART_TEMP, json.toList());
  }

  Future<bool> _clearTemp() async {
    try {
      final isClear = await localStorage.remove(AppConstants.CART_TEMP);
      return isClear;
    } catch (e) {
      return false;
    }
  }

  List<FoodInCart> getTemp() {
    const key = AppConstants.CART_TEMP;
    if (!localStorage.containsKey(key)) return [];
    final json = localStorage.getStringList(key);
    final cart = mapToList<FoodInCart>(json, FoodInCart.fromJson);
    return cart;
  }

  bool checkAuth() {
    return authController.user != null;
  }
}
