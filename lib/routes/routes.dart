// ignore_for_file: unused_element

import 'package:food_shop/views/auth/views/forgot/forgot_password.dart';
import 'package:food_shop/views/auth/views/signin/signin.page.dart';
import 'package:food_shop/views/auth/views/signup/signup.page.dart';
import 'package:food_shop/views/cart/cart.page.dart';
import 'package:food_shop/views/home/home.page.dart';
import 'package:food_shop/views/home/views/popular_food_view/popular_food_detail.page.dart';
import 'package:food_shop/views/home/views/recomend_food_view/recommened_food_detail.page.dart';
import 'package:food_shop/views/main.dart';
import 'package:food_shop/views/personal/views/address/address.page.dart';
import 'package:food_shop/views/splash.dart';
import 'package:get/get.dart';

part './helpers/routes.constant.dart';
part './routes_config/route.named.dart';

class Routes {
  Routes._();

  static final List<GetPage> config = [
    GetPage(name: _main, page: () => const Main()),
    GetPage(
      name: _home,
      page: () => const Home(),
      children: [
        GetPage(
          name: _popular,
          page: () => PopularFoodDetail(foodId: '${Get.parameters['foodId']}'),
        ),
        GetPage(
          name: _recommended,
          page: () =>
              RecommenedFoodDetail(foodId: '${Get.parameters['foodId']}'),
        ),
      ],
    ),
    GetPage(name: _splash, page: () => const Splash()),
    GetPage(
      name: _cart,
      page: () => Cart(
        cartId: Get.parameters['cartId'],
      ),
    ),
    GetPage(
        name: _signin,
        page: () => const Signin(),
        transition: Transition.fade,
        children: [
          GetPage(
            name: _forgotPassword,
            page: () => ForgotPassword(Get.parameters['initEmail'] ?? ''),
          )
        ]),
    GetPage(
      name: _signup,
      page: () => const Signup(),
    ),
    GetPage(
      name: _address,
      page: () => Address(
        latitude: double.tryParse(Get.parameters['latitude'] ?? '0.0'),
        longitude: double.tryParse(Get.parameters['longitude'] ?? '0.0'),
      ),
    )
  ];
}
