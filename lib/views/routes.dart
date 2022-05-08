// ignore_for_file: unused_element

part of './app.dart';

class _Id {
  const _Id();
  static const String home = '/';
  static const String popular = '/popular_food';
  static const String recommended = '/recommended_food';
  static const String cart = '/cart';
}

class RouteHelper {
  const RouteHelper();

  static String getHome() => _Id.home;
  static String getCart() => _Id.cart;

  // route need param
  static String getPopularFood(String foodId) =>
      '${_Id.popular}?foodId=$foodId';
  static String getRecommendedFood(String foodId) =>
      '${_Id.recommended}?foodId=$foodId';

  static final List<GetPage> _routes = [
    GetPage(name: _Id.home, page: Home.new),
    GetPage(
      name: _Id.popular,
      page: () => PopularFoodDetail(foodId: '${Get.parameters['foodId']}'),
    ),
    GetPage(
      name: _Id.recommended,
      page: () => RecommenedFoodDetail(foodId: '${Get.parameters['foodId']}'),
    ),
    GetPage(name: _Id.recommended, page: Cart.new)
  ];

  // Methods

  static Future<T?>? goTo<T>(String name) {
    return Get.toNamed(name);
  }

  static void goBack(String name) {
    return Get.back();
  }
}
