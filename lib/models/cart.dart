import 'package:food_shop/helpers/functions.dart';
import 'package:food_shop/models/food.dart';

class FoodInCart {
  final String id, name, image, options, pageId;
  final double price;
  final int time;
  late int quantity;

  FoodInCart(
    this.id, {
    required this.name,
    required this.image,
    required this.options,
    this.price = 0.0,
    this.quantity = 0,
    this.time = 0,
    this.pageId = '',
  });

  factory FoodInCart.fromFood(Food food,
      {int quantity = 1, int time = 0, String pageId = ''}) {
    return FoodInCart(
      food.id,
      name: food.name,
      image: food.images.first,
      price: food.price,
      quantity: quantity,
      options: 'Spicy',
      time: time,
      pageId: pageId,
    );
  }

  factory FoodInCart.fromJson(Map<String, dynamic> json) {
    return FoodInCart(
      json['id'],
      name: json['name'],
      image: json['image'],
      quantity: json['quantity'] ?? -1,
      price: json['price'] ?? -1.0,
      options: json['options'],
      time: json['time'] ?? 0,
      pageId: json['pageId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'quantity': quantity,
      'price': price,
      'options': options,
      'time': time,
      'pageId': pageId,
    };
  }
}

enum CartStatus {
  accept,
  prepair,
  shipping,
  done,
  reject,
}

class Cart {
  final String id;
  final DateTime? createDate;
  final List<FoodInCart> foods;
  final CartStatus status;

  Cart(
    this.id, {
    this.foods = const [],
    this.createDate,
    this.status = CartStatus.accept,
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
      status: CartStatus.accept,
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

  Map<String, dynamic> toJson() {
    final json = {
      'id': id,
      'foods': foods.map((food) {
        return food.toJson();
      }).toList(),
      'createDate': createDate?.toIso8601String() ?? '',
      'status': status.name,
    };
    return json;
  }
}
