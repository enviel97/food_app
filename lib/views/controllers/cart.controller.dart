import 'package:food_shop/models/cart.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/views/repositories/cart.repo.dart';
import 'package:food_shop/widgets/dialogs/confirm_dialog.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo repo;

  CartController({required this.repo});

  final Map<String, FoodInCart> _foods = {};

  Cart get cart => Cart.create(foods: _foods.values.toList());

  int get size => _foods.values.length;

  bool get isEmpty => _foods.isEmpty;

  int getQuantity(String foodId) {
    if (_foods.isEmpty || !_foods.containsKey(foodId)) {
      return 1;
    }
    return _foods[foodId]!.quantity;
  }

  Future<void> addItem(Food food, {required int quantity}) async {
    if (quantity.isNegative) {
      throw Exception('Quantity is negative');
    }
    if (_foods.containsKey(food.id)) {
      _foods[food.id]!.quantity = quantity;
    } else {
      _foods[food.id] = FoodInCart.fromFood(food, quantity: quantity);
    }
    update();
  }

  Future<void> removeItem(String foodId, String name) async {
    if (_foods.isEmpty || !_foods.containsKey(foodId)) return;

    if (!(Get.isDialogOpen ?? false)) {
      final isConfirm = await Get.dialog<bool>(Dialog.confirm(
        title: 'Remove',
        content: 'You want to reject $name out of cart',
      ));
      if (isConfirm ?? false) {
        _foods.remove(foodId);
        update();
      }
    }
  }
}
