import 'dart:convert';

import 'package:food_shop/helpers/constants.dart';
import 'package:food_shop/models/cart.dart';
import 'package:food_shop/views/auth/dependencies/auth.controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryRepo extends GetxService {
  final SharedPreferences localStorage;
  final AuthController authController;

  HistoryRepo({required this.localStorage, required this.authController});

  // Get History bill and auto clean garbage
  List<Cart> getHistory() {
    if (authController.user == null) return [];
    final List<Cart> carts = [];
    final List<String> garbage = [];
    try {
      final key = authController.user!.id;
      final cartIds = localStorage.getStringList(key) ?? [];
      if (cartIds.isEmpty) return carts;

      for (String id in cartIds) {
        final json = localStorage.getString(id);
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
          localStorage.remove(id);
        }
        localStorage.setStringList(key, cartIds);
      }
      return carts;
    } catch (e) {
      return carts;
    }
  }

  void remove(String id) async {
    final cartIds = localStorage.getStringList(AppConstants.CART_HISTORY);
    if (cartIds?.isEmpty ?? true) return;
    cartIds!.remove(id);
    await Future.wait([
      localStorage.setStringList(AppConstants.CART_HISTORY, cartIds),
      localStorage.remove(id)
    ]);
  }
}
