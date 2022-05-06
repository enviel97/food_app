part of './app.dart';

class RouteHelper {
  const RouteHelper();

  static const String _home = '/';
  static const String _popular = '/popular_food';
  static const String _recommended = '/recommended_food';

  static String getHome() => _home;
  static String getPopularFood(String foodId) => '$_popular?foodId=$foodId';
  static String getRecommendedFood(String foodId) =>
      '$_recommended?foodId=$foodId';

  static final List<GetPage> _routes = [
    GetPage(name: _home, page: Home.new),
    GetPage(
        name: _popular,
        page: () {
          final foodId = Get.parameters['foodId'].toString();
          return PopularFoodDetail(foodId: foodId);
        }),
    GetPage(
        name: _recommended,
        page: () {
          final foodId = Get.parameters['foodId'].toString();
          return RecommenedFoodDetail(foodId: foodId);
        }),
  ];

  // Methods

  static Future<T?>? goTo<T>(String name) {
    return Get.toNamed(name);
  }

  static void goBack(String name) {
    return Get.back();
  }
}
