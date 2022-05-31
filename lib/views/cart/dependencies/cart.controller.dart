import 'package:flutter/cupertino.dart';
import 'package:food_shop/models/cart.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/views/cart/dependencies/cart.repo.dart';
import 'package:food_shop/widgets/dialogs/confirm_dialog.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo repo;
  final Map<String, FoodInCart> _foods = {};

  double _totalPrice = 0.0;

  CartController({required this.repo});

  @override
  void onInit() {
    super.onInit();
    final cart = repo.getTemp();
    if (cart.isEmpty) return;
    _foods.addAll({for (FoodInCart food in cart) food.id: food});
    calculatorTotalPrice(cart);
  }

  void calculatorTotalPrice(List<FoodInCart> cart) {
    _totalPrice = cart.fold<double>(
      0.0,
      (sum, food) => sum + (food.price * food.quantity),
    );
  }

  FoodInCart? getFoodById(String id) => _foods[id];

  int get size => _foods.values.length;

  bool get isEmpty => _foods.isEmpty;

  double get totalPrice => _totalPrice;

  List<FoodInCart> getFoods({String? cartId}) {
    if (cartId != null) {
      final cart = repo.getCartHistory(cartId);
      calculatorTotalPrice(cart.foods);
      return cart.foods;
    }
    return _foods.values.toList();
  }

  Future<void> changeQuantityById(String id, {required int quantity}) async {
    if (!_foods.containsKey(id)) throw Exception('@FoodId $id is not exits');
    final int prevQuantity = _foods[id]!.quantity;
    _foods[id]!.quantity = quantity;
    _updateCart(_foods[id], prevQuantity);
  }

  Future<void> addToCart(Food food,
      {required int quantity, String pageId = ''}) async {
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
    _updateCart(_foods[food.id], prevQuantity);
  }

  Future<bool> removeItem(String foodId) async {
    if (_foods.isEmpty || !_foods.containsKey(foodId)) return false;
    final isConfirm = await showConfirmDialog(
      title: 'Remove',
      content: Text.rich(
        TextSpan(
          text: 'You want to reject',
          children: [
            TextSpan(
                text: ' ${_foods[foodId]?.name ?? '@food$foodId'}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: ' out of cart')
          ],
        ),
      ),
      onConfirm: () {
        final food = _foods.remove(foodId);
        _updateCart(food, (food?.quantity ?? 0) * 2);
      },
    );
    return isConfirm;
  }

  Future<void> _updateCart(FoodInCart? food, int prevQuantity) async {
    int diff = 0;
    if ((food?.quantity ?? 0) != prevQuantity) {
      diff = (food?.quantity ?? 0) - prevQuantity;
    }
    _totalPrice += diff * (food?.price ?? 0.0);
    repo.storeTemp(_foods.values.toList());
    update();
  }

  Future<bool> payment(List<FoodInCart> carts) async {
    final isAuth = repo.checkAuth();
    if (!isAuth) {
      await showNoticeDialog(
        title: 'Payment',
        content: const Center(
          child: BodyText('You must sign in to checkout this'),
        ),
      );
      return false;
    }

    try {
      return await showConfirmDialog(
        title: 'Payment',
        content: Text.rich(TextSpan(
            text: 'Pay your cart with total payment amount of ',
            children: [
              TextSpan(
                  text: '$_totalPrice \$',
                  style: const TextStyle(fontWeight: FontWeight.bold))
            ])),
        onConfirm: () {
          repo.storeHistory(Cart.create(foods: carts));
          _foods.clear();
          _totalPrice = 0.0;
        },
      );
    } catch (e) {
      return false;
    }
  }
}
