import 'package:flutter/material.dart';
import 'package:food_shop/theme/app_theme.dart';
import 'package:food_shop/views/main.dart';
import 'package:get/get.dart';

import 'home/home.page.dart';
import 'cart/cart.page.dart';
import 'home/views/popular_food_view/popular_food_detail.page.dart';
import 'home/views/recomend_food_view/recommened_food_detail.page.dart';

part 'routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      title: 'Food App',
      getPages: RouteHelper._routes,
    );
  }
}
