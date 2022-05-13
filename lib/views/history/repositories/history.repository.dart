import 'dart:convert';

import 'package:food_shop/helpers/constants.dart';
import 'package:food_shop/models/cart.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryRepo extends GetxService {
  late SharedPreferences _localStorage;

  HistoryRepo({required SharedPreferences localStorage}) {
    _localStorage = localStorage;
  }

  // Get History bill and auto clean garbage
  List<Cart> getHistory() {
    const key = AppConstants.CART_HISTORY;
    final List<Cart> carts = [];
    final List<String> garbage = [];
    try {
      final cartIds = _localStorage.getStringList(key) ?? [];
      if (cartIds.isEmpty) return carts;
      for (String id in cartIds) {
        final json = _localStorage.getString(id);
        if (json != null) {
          carts.add(Cart.fromJson(jsonDecode(json)));
        } else {
          garbage.add(id);
        }
      }

      // clear garbage
      if (garbage.isNotEmpty) {
        for (String id in garbage) {
          cartIds.remove(id);
          _localStorage.remove(id);
        }
        _localStorage.setStringList(key, cartIds);
      }
      return carts;
    } catch (e) {
      return carts;
    }
  }

  void remove(String id) async {
    final cartIds = _localStorage.getStringList(AppConstants.CART_HISTORY);
    if (cartIds?.isEmpty ?? true) return;
    cartIds!.remove(id);
    await Future.wait([
      _localStorage.setStringList(AppConstants.CART_HISTORY, cartIds),
      _localStorage.remove(id)
    ]);
  }
}
