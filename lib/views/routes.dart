// ignore_for_file: unused_element

part of './app.dart';

class RouteId {
  const RouteId();
  static const String home = '/';
  static const String popular = '/popular_food';
  static const String recommended = '/recommended_food';
  static const String cart = '/cart';

  static String getHome() => home;
  static String getCart() => cart;

  // route need param
  static String getPopularFood(String foodId) => '$popular?foodId=$foodId';
  static String getRecommendedFood(String foodId) =>
      '$recommended?foodId=$foodId';
}

class RouteHelper {
  const RouteHelper();

  static final List<GetPage> _routes = [
    GetPage(
      name: RouteId.home,
      page: () => const Home(),
    ),
    GetPage(
      name: RouteId.popular,
      page: () => PopularFoodDetail(foodId: '${Get.parameters['foodId']}'),
    ),
    GetPage(
      name: RouteId.recommended,
      page: () => RecommenedFoodDetail(foodId: '${Get.parameters['foodId']}'),
    ),
    GetPage(
      name: RouteId.cart,
      page: () => const Cart(),
    )
  ];

  // Methods

  static Future<T?>? goTo<T>(String name, {dynamic arguments}) {
    return Get.toNamed(name, arguments: arguments);
  }

  static void goBack<T>({T? result, bool canPop = false}) {
    return Get.back(result: result, canPop: canPop);
  }

  static Future<T?>? replace<T>(String name, {dynamic arguments}) {
    return Get.offAndToNamed(name, arguments: arguments);
  }
}
