import 'package:food_shop/helpers/functions.dart';
import 'package:food_shop/models/food.dart';

class FoodInCart {
  final String id, name, image;
  final double price;
  late int quantity;

  FoodInCart(
    this.id, {
    required this.name,
    required this.image,
    this.price = 0.0,
    this.quantity = 0,
  });

  factory FoodInCart.fromFood(
    Food food, {
    required int quantity,
  }) {
    return FoodInCart(
      food.id,
      name: food.name,
      image: food.images.first,
      price: food.price,
      quantity: quantity,
    );
  }

  factory FoodInCart.fromJson(Map<String, dynamic> json) {
    return FoodInCart(
      json['id'],
      name: json['name'],
      image: json['image'],
      quantity: json['quantity'] ?? -1,
      price: json['price'] ?? -1.0,
    );
  }
}

class Cart {
  final String id;
  final DateTime? createDate;
  final List<FoodInCart> foods;

  Cart(
    this.id, {
    this.foods = const [],
    this.createDate,
  });

  static String get _generatorCartIs {
    final now = DateTime.now();
    return 'CART${now.microsecondsSinceEpoch}A${now.month}${now.year % 100}';
  }

  factory Cart.create({required List<FoodInCart> foods}) {
    return Cart(
      Cart._generatorCartIs,
      foods: foods,
      createDate: DateTime.now(),
    );
  }

  double get totalPrice {
    if (foods.isEmpty) return 0;
    return foods.fold(0.0, (sum, food) => sum + (food.quantity * food.price));
  }

  // int get quantity => foods.fold(0, (sum, food) => sum + food.quantity);

  factory Cart.fromJson(Map<String, dynamic> json) {
    final foods = mapToList<FoodInCart>(json['foods'], FoodInCart.fromJson);

    return Cart(
      json['id'] ?? '',
      foods: foods,
      createDate: DateTime.tryParse(json['createDate'] ?? ''),
    );
  }
}
