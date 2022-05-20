import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_shop/theme/app_theme.dart';
import 'package:food_shop/views/auth/views/forgot/forgot_password.dart';
import 'package:food_shop/views/auth/views/signin/signin.page.dart';
import 'package:food_shop/views/auth/views/signup/signup.page.dart';
import 'package:food_shop/views/main.dart';
import 'package:food_shop/views/splash.dart';
import 'package:get/get.dart';

import 'home/controllers/popular_product.controller.dart';
import 'home/controllers/recommended_food.controller.dart';
import 'home/home.page.dart';
import 'cart/cart.page.dart';
import 'home/views/popular_food_view/popular_food_detail.page.dart';
import 'home/views/recomend_food_view/recommened_food_detail.page.dart';

part 'routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Disable change on rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetBuilder<PopularFoodConroller>(builder: (_) {
      return GetBuilder<RecommendedFoodConroller>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          /** Just suport one theme */
          theme: AppTheme.lightTheme(context),
          darkTheme: AppTheme.lightTheme(context),
          title: 'Food App',
          initialRoute: RouteId.getSplash(),
          getPages: RouteHelper._routes,
        );
      });
    });
  }
}
