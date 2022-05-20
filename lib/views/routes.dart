// ignore_for_file: unused_element

part of './app.dart';

class RouteId {
  const RouteId._();
  static const String _splash = '/splash';
  static const String _main = '/';
  static const String _home = '/home';
  static const String _popular = '/popular_food';
  static const String _recommended = '/recommended_food';
  static const String _cart = '/cart';
  static const String _signin = '/signin';
  static const String _signup = '/signup';
  static const String _forgotPassword = '/forgot_password';

  static String getHome() => _home;
  static String getMain() => _main;
  static String getSplash() => _splash;
  static String getSignIn() => _signin;
  static String getSignUp() => _signup;

  // route need param
  static String getForgotPassword(String initEmail) =>
      '$_forgotPassword?initEmail=$initEmail';
  static String getPopularFood(String foodId) => '$_popular?foodId=$foodId';
  static String getRecommendedFood(String foodId) =>
      '$_recommended?foodId=$foodId';
  static String getCart({String? cartId}) =>
      _cart + ((cartId?.isEmpty ?? true) ? '' : '?cartId=$cartId');
}

class RouteHelper {
  const RouteHelper._();

  static final List<GetPage> _routes = [
    GetPage(name: RouteId._main, page: () => const Main()),
    GetPage(
      name: RouteId._home,
      page: () => const Home(),
      children: [
        GetPage(
          name: RouteId._popular,
          page: () => PopularFoodDetail(foodId: '${Get.parameters['foodId']}'),
        ),
        GetPage(
          name: RouteId._recommended,
          page: () =>
              RecommenedFoodDetail(foodId: '${Get.parameters['foodId']}'),
        ),
      ],
    ),
    GetPage(name: RouteId._splash, page: () => const Splash()),
    GetPage(
      name: RouteId._cart,
      page: () => Cart(
        cartId: Get.parameters['cartId'],
      ),
    ),
    // auth
    GetPage(
      name: RouteId._signin,
      page: () => const Signin(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteId._signup,
      page: () => const Signup(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteId._forgotPassword,
      page: () => ForgotPassword(Get.parameters['initEmail'] ?? ''),
      transition: Transition.fade,
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
