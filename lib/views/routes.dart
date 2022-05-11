// ignore_for_file: unused_element

part of './app.dart';

class RouteId {
  const RouteId();
  static const String _splash = '/splash';
  static const String _main = '/';
  static const String _home = '/home';
  static const String _popular = '/popular_food';
  static const String _recommended = '/recommended_food';
  static const String _cart = '/cart';

  static String getHome() => _home;
  static String getCart() => _cart;
  static String getMain() => _main;
  static String getSplash() => _splash;

  // route need param
  static String getPopularFood(String foodId) => '$_popular?foodId=$foodId';
  static String getRecommendedFood(String foodId) =>
      '$_recommended?foodId=$foodId';
}

class RouteHelper {
  const RouteHelper();

  static final List<GetPage> _routes = [
    GetPage(
      name: RouteId._main,
      page: () => const Main(),
    ),
    GetPage(
      name: RouteId._splash,
      page: () => const Splash(),
    ),
    GetPage(
      name: RouteId._home,
      page: () => const Home(),
    ),
    GetPage(
      name: RouteId._popular,
      page: () => PopularFoodDetail(foodId: '${Get.parameters['foodId']}'),
    ),
    GetPage(
      name: RouteId._recommended,
      page: () => RecommenedFoodDetail(foodId: '${Get.parameters['foodId']}'),
    ),
    GetPage(
      name: RouteId._cart,
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
