import 'package:food_shop/models/cart.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/views/cart/repository/cart.repo.dart';
import 'package:food_shop/widgets/dialogs/confirm_dialog.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo repo;

  CartController({required this.repo});

  final Map<String, FoodInCart> _foods = {};
  double _totalPrice = 0.0;

  Cart get cart => Cart.create(foods: _foods.values.toList());

  int get size => _foods.values.length;

  bool get isEmpty => _foods.isEmpty;

  double get totalPrice => _totalPrice;

  List<FoodInCart> get getFoods => _foods.values.toList();

  FoodInCart? getFoodById(String id) => _foods[id];

  Future<void> changeQuantityById(String id, {required int quantity}) async {
    if (!_foods.containsKey(id)) throw Exception('@FoodId $id is not exits');
    final int prevQuantity = _foods[id]!.quantity;
    _foods[id]!.quantity = quantity;
    _calculatorTotalPrice(id, prevQuantity);
    update();
  }

  Future<void> changeQuantity(
    Food food, {
    required int quantity,
    String pageId = '',
  }) async {
    if (quantity.isNegative) throw Exception('Quantity is negative');
    int prevQuantity = 0;
    if (_foods.containsKey(food.id)) {
      prevQuantity = _foods[food.id]!.quantity;
      _foods[food.id]!.quantity = quantity;
    } else {
      _foods[food.id] = FoodInCart.fromFood(
        food,
        quantity: quantity,
        pageId: pageId,
      );
    }
    _calculatorTotalPrice(food.id, prevQuantity);
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
        final food = _foods.remove(foodId);
        _totalPrice -= (food?.quantity ?? 0) * (food?.price ?? 0);
        update();
      }
    }
  }

  Future<void> _calculatorTotalPrice(String foodId, int quantity) async {
    int diff = 0;
    final food = _foods[foodId];
    if ((food?.quantity ?? 0) != quantity) {
      diff = (food?.quantity ?? 0) - quantity;
    }
    _totalPrice += diff * (food?.price ?? 0.0);
  }
}
